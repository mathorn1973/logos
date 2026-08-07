import Logos.Systems.SelfExplanation.AdequateScopeTheorems
import Logos.Models.Grounding.TotalityExternality
import Logos.Models.Grounding.TotalityExplanationScope

namespace Logos
namespace GroundingModels
namespace SelfExplanationAdequacy

open Grounding

/-! ## Positive model: contingent self-citation elsewhere is allowed -/

namespace LocalOnly

open TotalityExternality

/-- Raw explanatory graph with both necessary self-citation and an unrelated
contingent self-citation.  Only the root explains the totality fact. -/
def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .root => True
    | .actual, .root, .node _ => True
    | .actual, .node 0, .node 0 => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem node0_actual : Actual M (Entity.node 0) := True.intro

theorem node0_nonNecessary : ¬ Necessary M (Entity.node 0) := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

theorem node0_self_explains :
    ActualExplainsEntity E (Entity.node 0) (Entity.node 0) := True.intro

/-- Hence even the global contingent-propriety principle fails in this model. -/
theorem global_contingent_propriety_fails :
    ¬ ContingentExplanationProper M E := by
  intro hProper
  have hNe : Entity.node 0 ≠ Entity.node 0 :=
    hProper node0_actual node0_nonNecessary node0_self_explains
  exact hNe rfl

/-- Yet the explanation delivered by the totality explainer is locally adequate
for every member it purports to explain. -/
def adequateScopeAxioms : AdequateTotalityScopeAxioms M F G E R where
  toExplanatoryFactAxioms :=
    completeExplanationAxioms.toExternalExplanationAxioms.toExplanatoryFactAxioms

  adequate_members := by
    intro a hExplain x hInside hx
    cases a with
    | root =>
        cases x with
        | root =>
            exact False.elim hInside
        | node n =>
            constructor
            · exact True.intro
            · intro hNot hEq
              cases hEq
    | node n =>
        exact False.elim hExplain

  covers_nonNecessary := completeExplanationAxioms.covers_nonNecessary

/-- Necessary reality follows even though contingent self-citation exists
elsewhere in the explanatory graph. -/
theorem necessary_reality_survives_global_contingent_self_citation :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality :=
  contingent_totality_forces_necessary_reality_from_local_adequacy
    adequateScopeAxioms

end LocalOnly

/-! ## Countermodel: local adequacy fails exactly at self-citation -/

namespace NoLocalAdequacy

open TotalityExternality.InternalExplanation
open TotalityExplanationScope.SelfExplanation

/-- The local adequacy condition for the totality explanation fails at node 0. -/
theorem adequate_totality_scope_fails :
    ¬ (∀ {a}, ActualExplainsFact IG a IR.totality →
      ∀ {x}, IR.inside x → Actual IM x →
        AdequateExplainsEntity IM ES a x) := by
  intro hAdequate
  have h := hAdequate node0_explains
    (x := IEntity.node 0) True.intro True.intro
  have hNot : ¬ Necessary IM (IEntity.node 0) :=
    every_entity_nonNecessary (IEntity.node 0) True.intro
  exact h.2 hNot rfl

/-- And the same model remains wholly contingent. -/
theorem pure_contingency_survives_when_self_citation_counts_as_adequate :
    (¬ NecessaryFact IFM IR.totality) ∧
      (∀ x, Actual IM x → ¬ Necessary IM x) :=
  pure_contingency_survives_with_self_explanation

end NoLocalAdequacy

end SelfExplanationAdequacy
end GroundingModels
end Logos
