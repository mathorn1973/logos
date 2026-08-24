/-
Logos / Models / Semantics / SelfClosure.lean

Tightness of the self-closure bound.

`selfClosed_excludes_exprNegT` says a bivalent self-closed language with
diagonalisation cannot express the negation of its own truth predicate. That is
a restatement of `no_internal_truth`. The content of this cut is that the bound
is TIGHT: self-closure is compatible with everything else, up to and including
a predicate carrier realising every function `Code -> V` except that one.
-/

import Logos.Systems.SelfClosure.Theorems
import Logos.Models.Semantics.InternalTruthIndependence

namespace Logos.Models.Semantics

open Logos.Ontology.Semantics Logos.Systems.InternalTruth Logos.Systems.SelfClosure

theorem bool_bivalent : Bivalent BoolTV := ⟨bool_noGap, bool_noGlut⟩

/-! ## 1. Self-closure is satisfiable

Full classical self-closure, with diagonalisation holding. The witness is the
language already used to drop `ExprNegT` in the independence set; here it is
stated by what holds in it rather than by what fails. -/

theorem self_closure_possible :
    ∃ (TV : TruthValues) (L : SemLanguage TV),
      SelfClosed L ∧ Diag L ∧ NegSwapT TV ∧ Bivalent TV :=
  ⟨BoolTV, LExpr,
   ⟨drop_ExprNegT.2.2.1, drop_ExprNegT.2.2.2.1⟩,
   drop_ExprNegT.1, bool_negSwap, bool_bivalent⟩

/-! ## 2. Self-closure with no internal predicates at all

`Pred := Empty`. Here `ExprNegT` fails not because some predicate returns the
wrong value but because there are no predicates. `Diag` is vacuous. -/

def SimpleLang : SemLanguage BoolTV where
  Sent := Unit
  Code := Unit
  Pred := Empty
  q    := fun _ => ()
  val  := fun _ => true
  pval := fun p => Empty.elim p
  T    := fun _ => some true

theorem simple_selfClosed : SelfClosed SimpleLang :=
  ⟨fun _ => ⟨true, rfl⟩,
   fun _ u hu => by simp [SimpleLang] at hu; exact hu.symm⟩

theorem simple_diag : Diag SimpleLang := fun p => Empty.elim p

theorem simple_not_expr : ¬ ExprNegT SimpleLang :=
  fun h => match h with | ⟨p, _⟩ => Empty.elim p

/-! ## 3. Self-closure with a maximal predicate carrier

`Pred` realises every function `Code -> V` except exactly one. The excluded
function is the negated internal truth predicate, and by
`selfClosed_excludes_exprNegT` no self-closed bivalent language with
diagonalisation can add it back. So the cost of self-closure here is exactly
one function, and it can be named. -/

/-- The one excluded function. -/
def negT : Bool → Bool := fun c => !c

def MaxLang : SemLanguage BoolTV where
  Sent := Bool
  Code := Bool
  Pred := {f : Bool → Bool // f ≠ negT}
  q    := fun s => s
  val  := fun s => s
  pval := fun p c => p.val c
  T    := fun c => some c

theorem maxLang_selfClosed : SelfClosed MaxLang :=
  ⟨fun s => ⟨s, rfl⟩,
   fun s u hu => by simp [MaxLang] at hu; exact hu.symm⟩

theorem maxLang_diag : Diag MaxLang := by
  intro p
  cases hf : p.val false with
  | false => exact ⟨false, by simp [MaxLang, hf]⟩
  | true =>
    cases ht : p.val true with
    | true => exact ⟨true, by simp [MaxLang, ht]⟩
    | false =>
      exact absurd (funext fun b => by cases b <;> simp [negT, hf, ht]) p.property

theorem maxLang_not_expr : ¬ ExprNegT MaxLang := by
  intro h
  cases h with
  | intro p hp =>
    refine p.property (funext fun c => ?_)
    have hc := hp c c rfl
    simpa [MaxLang, BoolTV, negT] using hc

/-- Every function on codes other than the excluded one is realised. -/
theorem maxLang_pred_universal (f : Bool → Bool) (hf : f ≠ negT) :
    ∃ p : MaxLang.Pred, ∀ c, MaxLang.pval p c = f c :=
  ⟨⟨f, hf⟩, fun _ => rfl⟩

/-- The excluded one is not realised. -/
theorem maxLang_excluded : ¬ ∃ p : MaxLang.Pred, ∀ c, MaxLang.pval p c = negT c := by
  intro h
  cases h with
  | intro p hp => exact p.property (funext hp)

/-- The excluded function is exactly the negated internal truth predicate. -/
theorem maxLang_excluded_is_negTruth (c u : Bool) (h : MaxLang.T c = some u) :
    negT c = BoolTV.neg u := by
  have h' : some c = some u := h
  have hcu : c = u := Option.some.inj h'
  subst hcu
  simp [negT, BoolTV]

/-! ## 4. Self-closure with infinitely many sentences

To show the witnesses above are not tied to finite sentence types. The
predicate carrier of `OmegaLang` is small. `OmegaMaxLang` is both infinite and
maximal, and is the only theorem in either cut that uses `Classical.choice`. -/

def evenVal : Nat → Bool
  | 0 => true
  | 1 => false
  | n + 2 => evenVal n

def OmegaLang : SemLanguage BoolTV where
  Sent := Nat
  Code := Nat
  Pred := Bool
  q    := fun s => s
  val  := evenVal
  pval := fun b _ => b
  T    := fun c => some (evenVal c)

theorem omega_selfClosed : SelfClosed OmegaLang :=
  ⟨fun s => ⟨evenVal s, rfl⟩,
   fun s u hu => by simp [OmegaLang] at hu; exact hu.symm⟩

theorem omega_diag : Diag OmegaLang := by
  intro b
  cases b with
  | false => exact ⟨(1 : Nat), rfl⟩
  | true  => exact ⟨(0 : Nat), rfl⟩

theorem omega_not_expr : ¬ ExprNegT OmegaLang := by
  intro h
  cases h with
  | intro b hb =>
    have h0 := hb (0 : Nat) true rfl
    have h1 := hb (1 : Nat) false rfl
    simp [OmegaLang, BoolTV] at h0 h1
    exact absurd (h0.symm.trans h1) (by decide)

/-! ## 5. Infinite and maximal at once

Same shape as section 3 but over `Nat`. Unlike everything else in this cut and
in `internal-truth-1`, this uses `Classical.choice`: the step from "no sentence
diagonalises `p`" to "`p` is the negated truth predicate everywhere" needs a
classical existence step at infinite size. At finite size (section 3) it does
not. -/

def negEven : Nat → Bool := fun n => !(evenVal n)

def OmegaMaxLang : SemLanguage BoolTV where
  Sent := Nat
  Code := Nat
  Pred := {f : Nat → Bool // f ≠ negEven}
  q    := fun s => s
  val  := evenVal
  pval := fun p c => p.val c
  T    := fun c => some (evenVal c)

theorem omegaMax_selfClosed : SelfClosed OmegaMaxLang :=
  ⟨fun s => ⟨evenVal s, rfl⟩,
   fun s u hu => by simp [OmegaMaxLang] at hu; exact hu.symm⟩

theorem omegaMax_diag : Diag OmegaMaxLang := by
  intro p
  apply Classical.byContradiction
  intro hno
  refine p.property (funext fun n => ?_)
  have hne : evenVal n ≠ p.val n := fun heq => hno ⟨n, heq⟩
  cases he : evenVal n
  · cases hp : p.val n
    · exact absurd (he.trans hp.symm) hne
    · simp [negEven, he, hp]
  · cases hp : p.val n
    · simp [negEven, he, hp]
    · exact absurd (he.trans hp.symm) hne

theorem omegaMax_not_expr : ¬ ExprNegT OmegaMaxLang := by
  intro h
  cases h with
  | intro p hp =>
    refine p.property (funext fun c => ?_)
    have hc := hp c (evenVal c) rfl
    simpa [OmegaMaxLang, BoolTV, negEven] using hc

theorem omegaMax_pred_universal (f : Nat → Bool) (hf : f ≠ negEven) :
    ∃ p : OmegaMaxLang.Pred, ∀ c, OmegaMaxLang.pval p c = f c :=
  ⟨⟨f, hf⟩, fun _ => rfl⟩

theorem omegaMax_excluded :
    ¬ ∃ p : OmegaMaxLang.Pred, ∀ c, OmegaMaxLang.pval p c = negEven c := by
  intro h
  cases h with
  | intro p hp => exact p.property (funext hp)

end Logos.Models.Semantics
