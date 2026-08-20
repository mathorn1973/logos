import Logos.Systems.AbsoluteGround.Theorems
import Logos.Models.Grounding.FactSufficientExplanation

namespace Logos
namespace GroundingModels
namespace A4FactIndependence

open Grounding

/-! # A4' and local EF4 are two commitments, not one

The two directions are two different models.  What they share is the same fixed
hypothesis schema:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
¬ NecessaryFact F R.totality
```

so the independence is exhibited under the accepted hypotheses rather than by
changing them. -/

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

/-- The original A4, not only A4'.  The actual world of this model accesses
itself, so the accepted equivalence applies. -/
theorem original_a4_holds :
    ∀ x, Actual IM x → Contingent IM x → Derived IM x :=
  contingent_is_derived_of_nonNecessary a4_holds

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

/-- `stray` is the brute contingent entity: actual, contingent, underived. -/
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

/-- `root` is admitted as a generic fact ground as well as an explanatory source,
so the fact-level bridge `ExplanationImpliesGrounding` holds here.  The result
then depends only on the absence of an entity-level bridge from adequate
explanation to ontological grounding. -/
def groundsFact : World → Entity → Fact → Prop
  | .actual, .node _, .totality => True
  | .actual, .root, .totality => True
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

/-- The shared hypothesis schema is satisfied. -/
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

/-- The fact-level bridge is present, so nothing in this direction turns on its
absence. -/
theorem explanation_implies_grounding : ExplanationImpliesGrounding G := by
  intro a p hExplain
  cases a with
  | root => cases p; exact True.intro
  | node n => cases p; exact False.elim hExplain
  | stray => cases p; exact False.elim hExplain

/-- `root` adequately explains `stray` without grounding it.  Adequacy is in the
statement, not only raw explanation: `root` explains `stray` and is distinct from
it, so the explanation is proper in the sense of `AdequateExplainsEntity`, and
`root` still does not ground `stray`.  That gap is what lets the core hold while
A4' fails, and it exists because the current language has no entity-level bridge
from adequate explanation to ontological grounding. -/
theorem root_explains_stray_without_grounding :
    AdequateExplainsEntity M E Entity.root Entity.stray ∧
      ¬ ActualGrounds M Entity.root Entity.stray :=
  ⟨⟨True.intro, by intro _ hEq; cases hEq⟩, by intro h; exact h⟩

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

/-- `stray` is contingent in the original sense, not merely non-necessary. -/
theorem stray_contingent : Contingent M Entity.stray :=
  ⟨⟨World.actual, True.intro, True.intro⟩,
    ⟨World.stripped, True.intro, by intro h; exact h⟩⟩

/-- A4' fails, witnessed at `stray`. -/
theorem a4_fails : ¬ NonNecessaryIsDerived M := by
  intro hA4
  exact stray_not_derived (hA4 Entity.stray stray_actual stray_not_necessary)

/-- The original A4 fails too, at the same witness. -/
theorem original_a4_fails :
    ¬ (∀ x, Actual M x → Contingent M x → Derived M x) := by
  intro hA4
  exact stray_not_derived (hA4 Entity.stray stray_actual stray_contingent)

end EntityBruteFactRegular

/-! ## The joint statement -/

/-- Under the shared hypothesis schema, A4 and A4' on one side and local EF4 on
the other are independent.  Both the original A4 and the cleaner A4' are stated,
so the result is not confined to the reformulated principle.

What this says is exactly two non-entailments, both under that schema:

```text
A4 and A4' do not entail local EF4
local EF4 does not entail A4 or A4'
```

Nothing about arguments follows.  A countermodel bears on entailment; whether a
particular argument against one position also reaches the other depends on that
argument's own premises, which no model here settles. -/
theorem a4_and_localEF4_are_independent :
    (TotalityExplanationCore
        TotalityRegress.InternalGround.IM
        TotalityRegress.InternalGround.IFM
        FactSufficientExplanation.BruteTotality.BG
        FactSufficientExplanation.BruteTotality.BE
        TotalityRegress.InternalGround.IR ∧
      NonNecessaryIsDerived TotalityRegress.InternalGround.IM ∧
      (∀ x, Actual TotalityRegress.InternalGround.IM x →
        Contingent TotalityRegress.InternalGround.IM x →
        Derived TotalityRegress.InternalGround.IM x) ∧
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
      ¬ NonNecessaryIsDerived EntityBruteFactRegular.M ∧
      ¬ (∀ x, Actual EntityBruteFactRegular.M x →
          Contingent EntityBruteFactRegular.M x →
          Derived EntityBruteFactRegular.M x)) :=
  ⟨⟨FactSufficientExplanation.BruteTotality.bruteCore,
      FactBruteEntityRegular.a4_holds,
      FactBruteEntityRegular.original_a4_holds,
      FactBruteEntityRegular.totality_not_necessary,
      FactBruteEntityRegular.local_ef4_fails⟩,
    ⟨EntityBruteFactRegular.explanationCore,
      EntityBruteFactRegular.local_ef4_holds,
      EntityBruteFactRegular.totality_not_necessary,
      EntityBruteFactRegular.a4_fails,
      EntityBruteFactRegular.original_a4_fails⟩⟩

end A4FactIndependence
end GroundingModels
end Logos
