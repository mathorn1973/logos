import Logos.Systems.TotalityExternality.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Explicit-E_expl layer.

A contingent totality fact has an explanatory source outside the represented
regress, conditional on EF4 and E_expl. This is not a theorem from generic F4. -/
theorem totality_necessary_or_external_explanation
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F}
    (A : ExternalExplanationAxioms M F G R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · right
    rcases A.nonNecessaryFact_is_explained
      R.totality R.actual_totality hNecessary with ⟨a, hExplain⟩
    have hActual := (A.explains_existents hExplain).1
    exact ⟨a, hActual, hExplain, A.totality_explanation_external hExplain⟩

/-- Completeness C turns an actual external explanatory source into a necessary
entity. The outside premise is supplied by E_expl; necessity is the derived step. -/
theorem external_explainer_is_necessary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F}
    (A : CompleteExplanationAxioms M F G R)
    {a : M.Entity}
    (ha : Actual M a)
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a := by
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside := A.covers_nonNecessary a ha hNotNecessary
  exact A.totality_explanation_external hExplain hInside

/-- Role-separated analogue of TOTALITY-REGRESS-1.

Premises are EF4 + E_expl + C. No A2 or A3 occurs. -/
theorem contingent_totality_forces_necessary_explanation
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F}
    (A : CompleteExplanationAxioms M F G R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  rcases totality_necessary_or_external_explanation
    A.toExternalExplanationAxioms with hFact | hExternal
  · exact Or.inl hFact
  · right
    rcases hExternal with ⟨a, ha, hExplain, hOutside⟩
    have hNecessary := external_explainer_is_necessary A ha hExplain
    exact ⟨a, ha, hNecessary, hExplain, hOutside⟩

/-- Pure contingency is incompatible with EF4 + E_expl + C. -/
theorem no_pure_contingency_under_explanation_roles
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F}
    (A : CompleteExplanationAxioms M F G R) :
    ¬ (¬ NecessaryFact F R.totality ∧
       ∀ x, Actual M x → ¬ Necessary M x) := by
  intro hPure
  rcases contingent_totality_forces_necessary_explanation A with hFact | hEntity
  · exact hPure.1 hFact
  · rcases hEntity with ⟨a, ha, hNecessary, _, _⟩
    exact hPure.2 a ha hNecessary

end Grounding
end Logos
