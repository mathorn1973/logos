import Logos.Systems.SelfExplanation.Theorems
import Logos.Models.Grounding.TotalityExternality
import Logos.Models.Grounding.TotalityExplanationScope

namespace Logos
namespace GroundingModels
namespace SelfExplanation

open Grounding

/-! ## Positive model: necessary self-citation is allowed -/

namespace NecessarySelfCitation

open TotalityExternality

/-- The necessary root explains the contingent members and is also allowed to
explain itself.  This deliberately violates global irreflexivity. -/
def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .root => True
    | .actual, .root, .node _ => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem root_self_explains :
    ActualExplainsEntity E Entity.root Entity.root := True.intro

/-- Full global irreflexivity is false in this model. -/
theorem global_irreflexivity_fails :
    ¬ GlobalExplanationIrreflexive M E := by
  intro h
  exact h root_actual root_self_explains

/-- Nevertheless, every explanation of a contingent target is proper. -/
theorem contingent_explanation_proper :
    ContingentExplanationProper M E := by
  intro a x hx hNotNecessary hExplain hEq
  cases hEq
  cases a with
  | root =>
      exact False.elim (hNotNecessary root_necessary)
  | node n =>
      exact False.elim hExplain

/-- The minimal package is satisfied even though the necessary root
self-explains. -/
def contingentScopeAxioms : ContingentScopeAxioms M F G E R where
  toExplanatoryFactAxioms :=
    completeExplanationAxioms.toExternalExplanationAxioms.toExplanatoryFactAxioms

  explains_members := by
    intro a hExplain x hInside
    cases a with
    | root =>
        cases x with
        | root => exact False.elim hInside
        | node n => exact True.intro
    | node n =>
        exact False.elim hExplain

  contingent_explanation_proper := contingent_explanation_proper

  covers_nonNecessary := completeExplanationAxioms.covers_nonNecessary

/-- Necessary reality follows despite explicit necessary self-citation. -/
theorem necessary_reality_survives_necessary_self_explanation :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality :=
  contingent_totality_forces_necessary_reality_without_global_irreflexivity
    contingentScopeAxioms

end NecessarySelfCitation

/-! ## Countermodel: contingent self-explanation is the exact escape -/

namespace ContingentSelfCitation

open TotalityExternality.InternalExplanation
open TotalityExplanationScope.SelfExplanation

/-- The internal explainer is actual and non-necessary. -/
theorem node0_nonNecessary :
    ¬ Necessary IM (IEntity.node 0) := by
  exact every_entity_nonNecessary (IEntity.node 0) True.intro

/-- It explains itself in the existing pure-contingency model. -/
theorem node0_self_explains :
    ActualExplainsEntity ES (IEntity.node 0) (IEntity.node 0) := True.intro

/-- The minimal contingent propriety principle fails exactly at that self-loop. -/
theorem contingent_explanation_proper_fails :
    ¬ ContingentExplanationProper IM ES := by
  intro hProper
  have hNe : IEntity.node 0 ≠ IEntity.node 0 :=
    hProper True.intro node0_nonNecessary node0_self_explains
  exact hNe rfl

/-- Fact-level sufficient explanation still holds. -/
theorem fact_sufficient_explanation_holds :
    ExplanatoryFactAxioms IM IFM IG := explanatoryFactAxioms

/-- Scope adequacy still holds: the internal source explains every represented
member, including itself. -/
theorem totality_scope_holds :
    ∀ {a}, ActualExplainsFact IG a IR.totality →
      ∀ {x}, IR.inside x → ActualExplainsEntity ES a x :=
  scope_adequacy_holds

/-- Coverage of all actual non-necessary entities also holds because every
entity is inside this totality. -/
theorem contingent_coverage_holds :
    ∀ x, Actual IM x → ¬ Necessary IM x → IR.inside x := by
  intro x hx hNot
  exact True.intro

/-- Therefore pure contingency survives when contingent self-explanation is
accepted. -/
theorem pure_contingency_survives_if_contingent_self_explanation_counts :
    (¬ NecessaryFact IFM IR.totality) ∧
      (∀ x, Actual IM x → ¬ Necessary IM x) :=
  pure_contingency_survives_with_self_explanation

end ContingentSelfCitation

end SelfExplanation
end GroundingModels
end Logos
