/-
Logos / Models / Seam / TruthFact.lean

TRUTH-FACT-SEAM-1. Whether the truth carrier of the semantic self-reference
line is a function of the fact carrier of the grounding line.

This is the only module in the repository that mentions both lines. It must
stay a leaf: nothing may import it. See TRUTH-FACT-SEAM-CONTRACT.md section 8.

`Bridge` is a substantive semantic commitment, not a discovery. It says a
sentence's fact obtains exactly when that sentence is designated true.

The value carriers here are defined locally rather than imported from the
countermodel file of another cut, so that this module depends on the two
languages and on nothing else.
-/

import Logos.Systems.SelfClosure.Theorems
import Logos.Systems.TotalityRegress.Axioms

namespace Logos.Models.Seam

open Logos Logos.Grounding
open Logos.Ontology.Semantics Logos.Systems.InternalTruth Logos.Systems.SelfClosure

universe u v w

/-! ## Value carriers -/

/-- Two-valued: a designation carries exactly as much as a value. -/
abbrev TwoValued : TruthValues :=
  { V := Bool, neg := not, isT := fun b => b = true, isF := fun b => b = false }

inductive Glut where
  | tru | fls | both
  deriving DecidableEq

/-- Three-valued with `tru` and `both` distinct yet both designated true, so a
designation carries strictly less than a value. -/
abbrev GlutValued : TruthValues :=
  { V := Glut
  , neg := fun x => match x with | .tru => .fls | .fls => .tru | .both => .both
  , isT := fun x => x = Glut.tru ∨ x = Glut.both
  , isF := fun x => x = Glut.fls ∨ x = Glut.both }

/-! ## The seam -/

/-- A language named into a fact carrier. Carries no laws. -/
structure LinkedModel (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (TV : TruthValues) where
  L            : SemLanguage TV
  sentenceFact : L.Sent → F.Fact

/-- The bridge. A sentence's fact obtains at the actual world exactly when the
sentence is designated true. It relates `holdsAt` to `val`, the external
valuation, and never to `T`; relating it to `T` would presuppose what is under
test. -/
def Bridge {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {TV : TruthValues}
    (K : LinkedModel M F TV) : Prop :=
  ∀ s : K.L.Sent, ActualFact F (K.sentenceFact s) ↔ TV.isT (K.L.val s)

/-! ## S1a. Collapse under bivalence

Over `TwoValued`, `isT b` is `b = true`, so a designation determines the value.
Two sentences naming the same fact in two bridged models must then carry the
same value, and if both languages are self-closed, the same internal verdict.
Under these hypotheses the truth side IS a function of the fact side.

The sharing hypothesis is `hname`: the two sentences name the same fact. That
is weaker than requiring the two models to share sentence and code types, so
the statement is more general than the one the contract sketched. -/

theorem s1a_val
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (K₁ K₂ : LinkedModel M F TwoValued)
    (hb₁ : Bridge K₁) (hb₂ : Bridge K₂)
    (s₁ : K₁.L.Sent) (s₂ : K₂.L.Sent)
    (hname : K₁.sentenceFact s₁ = K₂.sentenceFact s₂) :
    K₁.L.val s₁ = K₂.L.val s₂ := by
  have h : (K₁.L.val s₁ = true) ↔ (K₂.L.val s₂ = true) := by
    have a := hb₁ s₁
    have b := hb₂ s₂
    rw [hname] at a
    exact a.symm.trans b
  cases hx : K₁.L.val s₁
  · cases hy : K₂.L.val s₂
    · rfl
    · exact Bool.noConfusion (hx.symm.trans (h.mpr hy))
  · cases hy : K₂.L.val s₂
    · exact Bool.noConfusion (hy.symm.trans (h.mp hx))
    · rfl

theorem s1a_T
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (K₁ K₂ : LinkedModel M F TwoValued)
    (hb₁ : Bridge K₁) (hb₂ : Bridge K₂)
    (hsc₁ : SelfClosed K₁.L) (hsc₂ : SelfClosed K₂.L)
    (s₁ : K₁.L.Sent) (s₂ : K₂.L.Sent)
    (hname : K₁.sentenceFact s₁ = K₂.sentenceFact s₂) :
    K₁.L.T (K₁.L.q s₁) = K₂.L.T (K₂.L.q s₂) := by
  have hv := s1a_val K₁ K₂ hb₁ hb₂ s₁ s₂ hname
  cases hsc₁.1 s₁ with
  | intro u₁ hu₁ =>
    cases hsc₂.1 s₂ with
    | intro u₂ hu₂ =>
      have e₁ : u₁ = K₁.L.val s₁ := hsc₁.2 s₁ u₁ hu₁
      have e₂ : u₂ = K₂.L.val s₂ := hsc₂.2 s₂ u₂ hu₂
      rw [hu₁, hu₂, e₁, e₂, hv]

/-! ## S1b. No collapse without bivalence

`GlutValued` has `tru` and `both` distinct and both designated true, so the
bridge reports only "designated true" and cannot separate them. -/

def SeamModel : Model where
  frame := { World := Unit, access := fun _ _ => True }
  Entity := Unit
  actual := ()
  existsAt := fun _ _ => True
  directGrounds := fun _ _ _ => False
  created := fun _ => False

def SeamFacts : FactModel SeamModel where
  Fact := Unit
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

/-- A one-sentence language over `GlutValued` whose sentence takes value `a`. -/
def glutLang (a : Glut) : SemLanguage GlutValued where
  Sent := Unit
  Code := Unit
  Pred := Unit
  q    := fun _ => ()
  val  := fun _ => a
  pval := fun _ _ => a
  T    := fun _ => some a

def K_tru : LinkedModel SeamModel SeamFacts GlutValued :=
  ⟨glutLang Glut.tru, fun _ => ()⟩

def K_both : LinkedModel SeamModel SeamFacts GlutValued :=
  ⟨glutLang Glut.both, fun _ => ()⟩

theorem s1b_bridge_tru : Bridge K_tru :=
  fun _ => ⟨fun _ => Or.inl rfl, fun _ => trivial⟩

theorem s1b_bridge_both : Bridge K_both :=
  fun _ => ⟨fun _ => Or.inr rfl, fun _ => trivial⟩

theorem s1b_selfClosed_tru : SelfClosed K_tru.L :=
  ⟨fun _ => ⟨Glut.tru, rfl⟩,
   fun _ u hu => (Option.some.inj (show some Glut.tru = some u from hu)).symm⟩

theorem s1b_selfClosed_both : SelfClosed K_both.L :=
  ⟨fun _ => ⟨Glut.both, rfl⟩,
   fun _ u hu => (Option.some.inj (show some Glut.both = some u from hu)).symm⟩

/-- The two sentences name the same fact: the sharing hypothesis of `s1a_val`
is satisfied. -/
theorem s1b_same_fact : K_tru.sentenceFact () = K_both.sentenceFact () := rfl

/-- Yet the values differ. -/
theorem s1b_val_differs : K_tru.L.val () ≠ K_both.L.val () := by decide

/-- And so do the internal verdicts on the image of `q`. -/
theorem s1b_T_differs :
    K_tru.L.T (K_tru.L.q ()) ≠ K_both.L.T (K_both.L.q ()) := by decide

/-! ### The scope of S1a

`s1a_T` concludes only about codes in the image of `q`. Off that image the
bridge says nothing and `Scope` and `Disq` say nothing, so `T` stays free even
under bivalence. The collapse of S1a is therefore partial, and this is stated
rather than left to be inferred from the shape of the conclusion. -/

def scopeLang (t : Bool → Option Bool) : SemLanguage TwoValued where
  Sent := Unit
  Code := Bool
  Pred := Unit
  q    := fun _ => true
  val  := fun _ => true
  pval := fun _ _ => true
  T    := t

def K_total : LinkedModel SeamModel SeamFacts TwoValued :=
  ⟨scopeLang (fun _ => some true), fun _ => ()⟩

def K_partial : LinkedModel SeamModel SeamFacts TwoValued :=
  ⟨scopeLang (fun c => if c then some true else none), fun _ => ()⟩

theorem s1a_scope_bridge_total : Bridge K_total :=
  fun _ => ⟨fun _ => rfl, fun _ => trivial⟩

theorem s1a_scope_bridge_partial : Bridge K_partial :=
  fun _ => ⟨fun _ => rfl, fun _ => trivial⟩

theorem s1a_scope_selfClosed_total : SelfClosed K_total.L :=
  ⟨fun _ => ⟨true, rfl⟩,
   fun _ u hu => (Option.some.inj (show some true = some u from hu)).symm⟩

theorem s1a_scope_selfClosed_partial : SelfClosed K_partial.L :=
  ⟨fun _ => ⟨true, rfl⟩,
   fun _ u hu => (Option.some.inj (show some true = some u from hu)).symm⟩

/-- They agree on the image of `q`, as `s1a_T` requires. -/
theorem s1a_scope_agree_on_image :
    K_total.L.T (K_total.L.q ()) = K_partial.L.T (K_partial.L.q ()) := rfl

/-- And differ off it, so even under bivalence the collapse is partial. -/
theorem s1a_scope_differ_off_image :
    K_total.L.T false ≠ K_partial.L.T false := by decide

/-! ## S2. The fact side is not a function of the language side

Two fact carriers agreeing at the actual world, with the same language, the
same naming map, that map surjective, both satisfying the bridge, differing at
a non-actual world. Surjectivity is what stops this being an artefact of facts
the bridge never mentions: the residual freedom is modal, not extensional. -/

inductive TwoWorlds where
  | actualW | otherW
  deriving DecidableEq

def SeamModel2 : Model where
  frame := { World := TwoWorlds, access := fun _ _ => True }
  Entity := Unit
  actual := TwoWorlds.actualW
  existsAt := fun _ _ => True
  directGrounds := fun _ _ _ => False
  created := fun _ => False

def FactsEverywhere : FactModel SeamModel2 where
  Fact := Unit
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

def FactsActualOnly : FactModel SeamModel2 where
  Fact := Unit
  holdsAt := fun wld _ => wld = TwoWorlds.actualW
  groundsFact := fun _ _ _ => False

def boolLang : SemLanguage TwoValued where
  Sent := Unit
  Code := Unit
  Pred := Unit
  q    := fun _ => ()
  val  := fun _ => true
  pval := fun _ _ => true
  T    := fun _ => some true

def K_everywhere : LinkedModel SeamModel2 FactsEverywhere TwoValued :=
  ⟨boolLang, fun _ => ()⟩

def K_actualOnly : LinkedModel SeamModel2 FactsActualOnly TwoValued :=
  ⟨boolLang, fun _ => ()⟩

theorem s2_naming_surjective :
    ∀ p : FactsEverywhere.Fact, ∃ s, K_everywhere.sentenceFact s = p :=
  fun _ => ⟨(), rfl⟩

theorem s2_bridge_everywhere : Bridge K_everywhere :=
  fun _ => ⟨fun _ => rfl, fun _ => trivial⟩

theorem s2_bridge_actualOnly : Bridge K_actualOnly :=
  fun _ => ⟨fun _ => rfl, fun _ => rfl⟩

theorem s2_same_language : K_everywhere.L = K_actualOnly.L := rfl

theorem s2_agree_at_actual :
    ∀ p : Unit, ActualFact FactsEverywhere p ↔ ActualFact FactsActualOnly p :=
  fun _ => ⟨fun _ => rfl, fun _ => trivial⟩

theorem s2_differ_off_actual :
    FactsEverywhere.holdsAt TwoWorlds.otherW ()
    ∧ ¬ FactsActualOnly.holdsAt TwoWorlds.otherW () :=
  ⟨trivial,
   fun h => TwoWorlds.noConfusion (show TwoWorlds.otherW = TwoWorlds.actualW from h)⟩

end Logos.Models.Seam
