import Logos.Systems.FactSufficientExplanation.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Once an actual source explains the complete contingent totality, local
adequacy forces that source to be necessary.  No sufficient-explanation
principle for facts is used here. -/
theorem totality_explainer_is_necessary_from_core
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a := by
  have ha : Actual M a := A.explains_source_actual hExplain
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside : R.inside a := A.covers_nonNecessary a ha hNotNecessary
  have hAdequate : AdequateExplainsEntity M E a a :=
    A.adequate_members hExplain hInside ha
  exact hAdequate.2 hNotNecessary rfl

/-- Only local EF4 for the totality fact is needed to recover the previous
necessary-reality dichotomy. -/
theorem local_totality_sufficient_explanation_forces_necessary_reality
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : LocalTotalitySufficientExplanationAxioms M F G E R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · right
    have hExplained : ExplainedFact G R.totality :=
      A.totality_sufficient hNecessary
    rcases hExplained with ⟨a, hExplain⟩
    have ha : Actual M a := A.explains_source_actual hExplain
    have hNecessaryA : Necessary M a :=
      totality_explainer_is_necessary_from_core
        A.toTotalityExplanationCore hExplain
    exact ⟨a, ha, hNecessaryA, hExplain⟩

/-- EF4-free main trichotomy.

For an actual proposed totality of contingent reality, exactly the issue EF4
was hiding becomes visible: either the totality fact is necessary, or an actual
necessary entity explains it, or the totality fact is itself a contingent
explanatory absolute (actual, non-necessary, and unexplained). -/
theorem totality_necessary_or_necessary_explainer_or_contingent_absolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R) :
    NecessaryFact F R.totality ∨
      (∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality) ∨
      ContingentExplanatoryAbsoluteFact G R.totality := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · by_cases hExplained : ExplainedFact G R.totality
    · rcases hExplained with ⟨a, hExplain⟩
      have ha : Actual M a := A.explains_source_actual hExplain
      have hNecessaryA : Necessary M a :=
        totality_explainer_is_necessary_from_core A hExplain
      exact Or.inr (Or.inl ⟨a, ha, hNecessaryA, hExplain⟩)
    · exact Or.inr (Or.inr ⟨R.actual_totality, hNecessary, hExplained⟩)

/-- If both the totality fact and every actual entity are declared non-necessary,
then the totality fact must occupy an unexplained ultimate position.

Thus pure contingency does not eliminate explanatory ultimacy; it relocates it
to a contingent brute totality fact. -/
theorem pure_contingency_forces_contingent_explanatory_absolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hFactNonNecessary : ¬ NecessaryFact F R.totality)
    (hEntitiesNonNecessary : ∀ x, Actual M x → ¬ Necessary M x) :
    ContingentExplanatoryAbsoluteFact G R.totality := by
  refine ⟨R.actual_totality, hFactNonNecessary, ?_⟩
  intro hExplained
  rcases hExplained with ⟨a, hExplain⟩
  have ha : Actual M a := A.explains_source_actual hExplain
  have hNecessaryA : Necessary M a :=
    totality_explainer_is_necessary_from_core A hExplain
  exact hEntitiesNonNecessary a ha hNecessaryA

/-- Excluding a contingent explanatory absolute is equivalent, for the actual
totality fact, to accepting the local sufficient-explanation principle. -/
theorem localTotalityEF4_iff_no_contingent_absolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F} :
    LocalFactSufficientExplanation G R.totality ↔
      ¬ ContingentExplanatoryAbsoluteFact G R.totality := by
  constructor
  · intro hLocal hAbsolute
    exact hAbsolute.2.2 (hLocal hAbsolute.2.1)
  · intro hNoAbsolute hNotNecessary
    apply Classical.byContradiction
    intro hNotExplained
    apply hNoAbsolute
    exact ⟨R.actual_totality, hNotNecessary, hNotExplained⟩

end Grounding
end Logos
