import Logos.Systems.TotalityExternality.Theorems
import Logos.Systems.TotalityExternality.ScopeTheorems
import Logos.Models.Grounding.TotalityExternalityComparison
import Logos.Models.Grounding.TotalityRegress

namespace Logos
namespace GroundingModels
namespace TotalityExternality

open Grounding

/-! ## Positive model on the preregistered mixed-role carrier -/

namespace Positive

open TotalityExternalityComparison.MixedRoles

theorem root_actual : Actual M Entity.root := True.intro

theorem root_necessary : Necessary M Entity.root := by
  intro world hAccess
  cases world <;> exact True.intro

theorem totality_not_necessary : ¬ NecessaryFact F R.totality := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

/-- Explicit-E_expl package. This uses EF4, not generic F4. -/
def completeExplanationAxioms : CompleteExplanationAxioms M F G R where
  explains_existents := by
    intro a p hExplain
    cases a with
    | root =>
        cases p
        exact ⟨root_actual, True.intro⟩
    | node n =>
        cases p
        exact False.elim hExplain
  nonNecessaryFact_is_explained := by
    intro p hp hNotNecessary
    cases p
    exact ⟨Entity.root, root_explains⟩
  totality_explanation_external := explanatory_externality_holds
  covers_nonNecessary := by
    intro x hx hNotNecessary
    cases x with
    | root => exact False.elim (hNotNecessary root_necessary)
    | node n => exact True.intro

/-- The explicit-E_expl theorem is inhabited while old E fails in the same model. -/
theorem explicit_externality_route_has_necessary_explainer :
    ∃ a, Actual M a ∧ Necessary M a ∧
      ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  rcases contingent_totality_forces_necessary_explanation completeExplanationAxioms with
      hFact | hEntity
  · exact False.elim (totality_not_necessary hFact)
  · exact hEntity

/-- Entity explanation used only for the deeper S/I factorization. -/
def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .node _ => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem root_explains_each_node (n : Nat) :
    ActualExplainsEntity E Entity.root (Entity.node n) := True.intro

/-- Deep package EF4 + S + I + C, with no externality field. -/
def completeScopedAxioms : CompleteScopedExplanationAxioms M F G E R where
  toExplanatoryFactAxioms := completeExplanationAxioms.toExternalExplanationAxioms.toExplanatoryFactAxioms
  explains_members := by
    intro a hExplain x hInside
    cases a with
    | root =>
        cases x with
        | root => exact False.elim hInside
        | node n => exact root_explains_each_node n
    | node n => exact False.elim hExplain
  explanation_irreflexive := by
    intro a ha hSelf
    cases a with
    | root => exact hSelf
    | node n => exact hSelf
  covers_nonNecessary := completeExplanationAxioms.covers_nonNecessary

/-- E_expl is now derived rather than assumed. -/
theorem root_outside_derived : ¬ R.inside Entity.root :=
  totality_explainer_is_outside
    completeScopedAxioms.toScopedExplanationAxioms root_explains

/-- Deepest theorem instantiated without passing through an externality record. -/
theorem deep_route_has_necessary_explainer :
    ∃ a, Actual M a ∧ Necessary M a ∧
      ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  rcases contingent_totality_forces_necessary_reality_from_scope completeScopedAxioms with
      hFact | hEntity
  · exact False.elim (totality_not_necessary hFact)
  · exact hEntity

end Positive

/-! ## Independence of S and I on a pure-contingency carrier -/

namespace NoScope

open TotalityRegress.InternalGround

/-- Node 0 is registered as explaining the totality fact. -/
def roles : FactGroundingRoles IM IFM where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .regressTotality => True
    | _, _, _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node 0, .regressTotality => True
    | _, _, _ => False

abbrev G := roles

theorem node0_explains :
    ActualExplainsFact G (IEntity.node 0) IR.totality := True.intro

def explanatoryFactAxioms : ExplanatoryFactAxioms IM IFM G where
  explains_existents := by
    intro a p hExplain
    cases a with
    | node n =>
        cases n with
        | zero =>
            cases p
            exact ⟨True.intro, True.intro⟩
        | succ n =>
            cases p
            exact False.elim hExplain
  nonNecessaryFact_is_explained := by
    intro p hp hNotNecessary
    cases p
    exact ⟨IEntity.node 0, node0_explains⟩

/-- Empty entity-explanation graph makes I hold. -/
def entityExplanation : EntityExplanationModel IM where
  explainsEntity := fun _ _ _ => False

abbrev E := entityExplanation

theorem irreflexivity_holds :
    ∀ {a}, Actual IM a → ¬ ActualExplainsEntity E a a := by
  intro a ha hSelf
  exact hSelf

/-- C holds because every entity is inside this represented totality. -/
theorem completeness_holds :
    ∀ x, Actual IM x → ¬ Necessary IM x → IR.inside x := by
  intro x hx hNotNecessary
  exact True.intro

/-- S fails: the registered totality explainer explains no entity members. -/
theorem scope_fails :
    ¬ (∀ {a}, ActualExplainsFact G a IR.totality →
      ∀ {x}, IR.inside x → ActualExplainsEntity E a x) := by
  intro hScope
  have h := hScope node0_explains (x := IEntity.node 0) True.intro
  exact h

/-- Pure contingency survives when S is absent. -/
theorem pure_contingency_survives_without_scope :
    (¬ NecessaryFact IFM IR.totality) ∧
      (∀ x, Actual IM x → ¬ Necessary IM x) :=
  pure_contingency_survives_without_externality

end NoScope

namespace NoIrreflexivity

open TotalityRegress.InternalGround

def roles : FactGroundingRoles IM IFM where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .regressTotality => True
    | _, _, _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node 0, .regressTotality => True
    | _, _, _ => False

abbrev G := roles

theorem node0_explains :
    ActualExplainsFact G (IEntity.node 0) IR.totality := True.intro

def explanatoryFactAxioms : ExplanatoryFactAxioms IM IFM G where
  explains_existents := by
    intro a p hExplain
    cases a with
    | node n =>
        cases n with
        | zero =>
            cases p
            exact ⟨True.intro, True.intro⟩
        | succ n =>
            cases p
            exact False.elim hExplain
  nonNecessaryFact_is_explained := by
    intro p hp hNotNecessary
    cases p
    exact ⟨IEntity.node 0, node0_explains⟩

/-- Node 0 explains every member, including itself. S therefore holds. -/
def entityExplanation : EntityExplanationModel IM where
  explainsEntity := fun world a x =>
    match world, a with
    | .actual, .node 0 => True
    | _, _ => False

abbrev E := entityExplanation

theorem scope_holds :
    ∀ {a}, ActualExplainsFact G a IR.totality →
      ∀ {x}, IR.inside x → ActualExplainsEntity E a x := by
  intro a hExplain x hInside
  cases a with
  | node n =>
      cases n with
      | zero => exact True.intro
      | succ n => exact False.elim hExplain

/-- I fails exactly at the internal source. -/
theorem irreflexivity_fails :
    ¬ (∀ {a}, Actual IM a → ¬ ActualExplainsEntity E a a) := by
  intro hIrrefl
  have hSelf : ActualExplainsEntity E (IEntity.node 0) (IEntity.node 0) := True.intro
  exact hIrrefl True.intro hSelf

theorem completeness_holds :
    ∀ x, Actual IM x → ¬ Necessary IM x → IR.inside x := by
  intro x hx hNotNecessary
  exact True.intro

/-- Pure contingency survives when I is absent. -/
theorem pure_contingency_survives_without_irreflexivity :
    (¬ NecessaryFact IFM IR.totality) ∧
      (∀ x, Actual IM x → ¬ Necessary IM x) :=
  pure_contingency_survives_without_externality

end NoIrreflexivity

end TotalityExternality
end GroundingModels
end Logos
