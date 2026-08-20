import Logos.Systems.AbsoluteGround.Axioms
import Logos.Models.Grounding.FactSufficientExplanation

namespace Logos
namespace GroundingModels
namespace A4FactIndependence

open Grounding

/-! # A4' and local EF4 are two commitments, not one

Both directions are stated inside one fixed environment:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
¬ NecessaryFact F R.totality
```

so the independence is exhibited within the accepted setting rather than by
varying it. -/

/-! ## Direction 1: entity level regular, fact level brute

The accepted `BruteTotality` model is reused unchanged. Every entity there is a
regress node and every node has a deeper node grounding it, so A4' holds while
the fact-level principle fails. -/

namespace FactBruteEntityRegular

open TotalityRegress.InternalGround
open FactSufficientExplanation.BruteTotality

/-- A4' holds: every actual non-necessary entity has an actual ground.  The
witness for a node is its successor in the regress. -/
theorem a4_holds : NonNecessaryIsDerived IM := by
  intro x _ _
  cases x with
  | node n => exact ⟨IEntity.node (n + 1), rfl⟩

theorem totality_not_necessary : ¬ NecessaryFact IFM IR.totality :=
  internal_totality_not_necessary

theorem local_ef4_fails : ¬ LocalFactSufficientExplanation BG IR.totality :=
  local_totality_EF4_fails

end FactBruteEntityRegular

/-! ## Direction 2: fact level regular, entity level brute

One entity `stray` is added to an otherwise well-behaved model.  It is actual,
non-necessary and grounded by nothing, while the totality fact is explained.
`stray` is inside the represented totality and is adequately explained by the
same source that explains the totality fact, so completeness and local adequacy
are untouched. -/

namespace EntityBruteFactRegular

inductive World where
  | actual
  | stripped
  deriving Repr, DecidableEq

/-- `stray` is the entity-level brute fact: actual, contingent, underived. -/
inductive Entity where
  | root
  | node (n : Nat)
  | stray
  deriving Repr, DecidableEq

inductive Fact where
  | totality
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def existsAt : World → Entity → Prop
  | _, .root => True
  | .actual, .node _ => True
  | .stripped, .node _ => False
  | .actual, .stray => True
  | .stripped, .stray => False

def directGrounds : World → Entity → Entity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def model : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := existsAt
  directGrounds := directGrounds
  created := fun _ => False

abbrev M := model

def holdsAt : World → Fact → Prop
  | .actual, .totality => True
  | .stripped, .totality => False

def groundsFact : World → Entity → Fact → Prop
  | .actual, .node _, .totality => True
  | _, _, _ => False

def facts : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := facts

def inside : Entity → Prop
  | .root => False
  | .node _ => True
  | .stray => True

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := rfl

def regress : RegressTotality M F where
  node := Entity.node
  step := regress_step
  totality := Fact.totality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .totality => True
    | _, _, _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .root, .totality => True
    | _, _, _ => False

abbrev G := roles

/-- The totality explainer adequately explains every represented member,
including `stray`. -/
def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .node _ => True
    | .actual, .root, .stray => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem root_actual : Actual M Entity.root := True.intro

theorem root_explains : ActualExplainsFact G Entity.root R.totality := True.intro

theorem root_necessary : Necessary M Entity.root := by
  intro world _
  cases world <;> exact True.intro

theorem totality_not_necessary : ¬ NecessaryFact F R.totality := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

/-- The shared environment is satisfied. -/
def explanationCore : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    cases a with
    | root => exact root_actual
    | node n => exact False.elim hExplain
    | stray => exact False.elim hExplain
  adequate_members := by
    intro a hExplain x hInside _hx
    cases a with
    | root =>
        cases x with
        | root => exact False.elim hInside
        | node n => exact ⟨True.intro, by intro _ hEq; cases hEq⟩
        | stray => exact ⟨True.intro, by intro _ hEq; cases hEq⟩
    | node n => exact False.elim hExplain
    | stray => exact False.elim hExplain
  covers_nonNecessary := by
    intro x _ hNotNecessary
    cases x with
    | root => exact False.elim (hNotNecessary root_necessary)
    | node n => exact True.intro
    | stray => exact True.intro

/-- Local EF4 holds here. -/
theorem local_ef4_holds : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨Entity.root, root_explains⟩

/-- Non-vacuity, first half: the antecedent of local EF4 is met. -/
theorem local_ef4_antecedent_met : ¬ NecessaryFact F R.totality :=
  totality_not_necessary

/-- Non-vacuity, second half: the consequent is met by an actual explainer. -/
theorem local_ef4_consequent_met : ExplainedFact G R.totality :=
  ⟨Entity.root, root_explains⟩

theorem stray_actual : Actual M Entity.stray := True.intro

theorem stray_not_necessary : ¬ Necessary M Entity.stray := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

theorem stray_not_derived : ¬ Derived M Entity.stray := by
  intro hDerived
  rcases hDerived with ⟨a, hGrounds⟩
  cases a with
  | root => exact hGrounds
  | node n =>
      cases n with
      | zero => exact hGrounds
      | succ k => exact hGrounds
  | stray => exact hGrounds

/-- A4' fails, witnessed at `stray`. -/
theorem a4_fails : ¬ NonNecessaryIsDerived M := by
  intro hA4
  exact stray_not_derived (hA4 Entity.stray stray_actual stray_not_necessary)

end EntityBruteFactRegular

/-! ## The joint statement -/

/-- Inside `RegressTotality` plus `TotalityExplanationCore` with a non-necessary
totality fact, A4' and local EF4 are independent.

An argument excluding brute contingent entities therefore does not exclude a
brute contingent totality fact, and an argument excluding the brute fact does not
exclude brute entities. -/
theorem a4_and_localEF4_are_independent :
    (TotalityExplanationCore
        TotalityRegress.InternalGround.IM
        TotalityRegress.InternalGround.IFM
        FactSufficientExplanation.BruteTotality.BG
        FactSufficientExplanation.BruteTotality.BE
        TotalityRegress.InternalGround.IR ∧
      NonNecessaryIsDerived TotalityRegress.InternalGround.IM ∧
      ¬ NecessaryFact TotalityRegress.InternalGround.IFM
          TotalityRegress.InternalGround.IR.totality ∧
      ¬ LocalFactSufficientExplanation
          FactSufficientExplanation.BruteTotality.BG
          TotalityRegress.InternalGround.IR.totality) ∧
    (TotalityExplanationCore
        EntityBruteFactRegular.M EntityBruteFactRegular.F
        EntityBruteFactRegular.G EntityBruteFactRegular.E
        EntityBruteFactRegular.R ∧
      LocalFactSufficientExplanation EntityBruteFactRegular.G
          EntityBruteFactRegular.R.totality ∧
      ¬ NecessaryFact EntityBruteFactRegular.F
          EntityBruteFactRegular.R.totality ∧
      ¬ NonNecessaryIsDerived EntityBruteFactRegular.M) :=
  ⟨⟨FactSufficientExplanation.BruteTotality.bruteCore,
      FactBruteEntityRegular.a4_holds,
      FactBruteEntityRegular.totality_not_necessary,
      FactBruteEntityRegular.local_ef4_fails⟩,
    ⟨EntityBruteFactRegular.explanationCore,
      EntityBruteFactRegular.local_ef4_holds,
      EntityBruteFactRegular.totality_not_necessary,
      EntityBruteFactRegular.a4_fails⟩⟩

end A4FactIndependence
end GroundingModels
end Logos
