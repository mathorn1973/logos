import Logos.Systems.SelfExplanation.AdequateScopeAxioms

universe u v w

namespace Logos
namespace Grounding

/-- Any actual explainer of the totality fact is necessary if the explanation
of members supplied by that totality explanation is locally adequate. -/
theorem totality_explainer_is_necessary_of_local_adequacy
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : AdequateTotalityScopeAxioms M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a := by
  have ha : Actual M a := (A.explains_existents hExplain).1
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside : R.inside a := A.covers_nonNecessary a ha hNotNecessary
  have hAdequate : AdequateExplainsEntity M E a a :=
    A.adequate_members hExplain hInside ha
  exact hAdequate.2 hNotNecessary rfl

/-- Deepest self-explanation reduction in this cut.

There is no global irreflexivity and no global contingent-self-explanation
principle.  Only local adequacy of the explanations delivered by the totality
explanation is used. -/
theorem contingent_totality_forces_necessary_reality_from_local_adequacy
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : AdequateTotalityScopeAxioms M F G E R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · right
    have hExplained :=
      A.nonNecessaryFact_is_explained R.totality R.actual_totality hNecessary
    rcases hExplained with ⟨a, hExplain⟩
    have ha : Actual M a := (A.explains_existents hExplain).1
    have hNecessaryA :=
      totality_explainer_is_necessary_of_local_adequacy A hExplain
    exact ⟨a, ha, hNecessaryA, hExplain⟩

/-- Pure contingency is incompatible with local explanatory adequacy. -/
theorem no_pure_contingency_from_local_adequacy
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : AdequateTotalityScopeAxioms M F G E R) :
    ¬ (¬ NecessaryFact F R.totality ∧
       ∀ x, Actual M x → ¬ Necessary M x) := by
  intro hPure
  rcases contingent_totality_forces_necessary_reality_from_local_adequacy A with
      hFact | hEntity
  · exact hPure.1 hFact
  · rcases hEntity with ⟨a, ha, hNecessary, _⟩
    exact hPure.2 a ha hNecessary

end Grounding
end Logos
