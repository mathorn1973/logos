import Logos.Systems.SelfExplanation.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Any actual explainer of the totality fact is necessary under the minimal
contingent anti-vacuity principle.

If the explainer were non-necessary, completeness would place it inside the
represented totality; scope adequacy would then make it explain itself, which
violates contingent explanatory propriety. -/
theorem totality_explainer_is_necessary_of_contingent_propriety
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : ContingentScopeAxioms M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a := by
  have ha : Actual M a := (A.explains_existents hExplain).1
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside : R.inside a := A.covers_nonNecessary a ha hNotNecessary
  have hSelf : ActualExplainsEntity E a a :=
    A.explains_members hExplain hInside
  have hNe : a ≠ a :=
    A.contingent_explanation_proper ha hNotNecessary hSelf
  exact hNe rfl

/-- Main SELF-EXPLANATION-1 result.

Global explanatory irreflexivity is unnecessary.  EF4 plus totality scope,
contingent anti-vacuity, and completeness force either a necessary totality
fact or an actual necessary explainer of that fact. -/
theorem contingent_totality_forces_necessary_reality_without_global_irreflexivity
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : ContingentScopeAxioms M F G E R) :
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
    have hNecessaryA : Necessary M a :=
      totality_explainer_is_necessary_of_contingent_propriety A hExplain
    exact ⟨a, ha, hNecessaryA, hExplain⟩

/-- Pure contingency is impossible under the minimal contingent propriety
criterion. -/
theorem no_pure_contingency_without_global_irreflexivity
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : ContingentScopeAxioms M F G E R) :
    ¬ (¬ NecessaryFact F R.totality ∧
       ∀ x, Actual M x → ¬ Necessary M x) := by
  intro hPure
  rcases contingent_totality_forces_necessary_reality_without_global_irreflexivity A with
      hFact | hEntity
  · exact hPure.1 hFact
  · rcases hEntity with ⟨a, ha, hNecessary, _⟩
    exact hPure.2 a ha hNecessary

end Grounding
end Logos
