import Logos.Systems.TotalityExternality.ScopeAxioms

universe u v w

namespace Logos
namespace Grounding

/-- S + I derive explanatory externality E_expl.

No externality record is assumed or constructed. -/
theorem totality_explainer_is_outside
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : ScopedExplanationAxioms M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    ¬ R.inside a := by
  intro hInside
  have ha : Actual M a := (A.explains_existents hExplain).1
  have hSelf : ActualExplainsEntity E a a :=
    A.explains_members hExplain hInside
  exact A.explanation_irreflexive ha hSelf

/-- Under EF4 + S + I + C, any actual source that explains the totality fact is
necessary. The proof is direct and does not pass through an externality record. -/
theorem totality_explainer_is_necessary_from_scope
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : CompleteScopedExplanationAxioms M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a := by
  have ha : Actual M a := (A.explains_existents hExplain).1
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside : R.inside a := A.covers_nonNecessary a ha hNotNecessary
  have hSelf : ActualExplainsEntity E a a :=
    A.explains_members hExplain hInside
  exact A.explanation_irreflexive ha hSelf

/-- Deepest TOTALITY-EXTERNALITY-1 theorem.

Premises are exactly EF4 + S + I + C. There is no A2, A3, old E, or primitive
E_expl premise, and the proof does not construct either externality axiom record. -/
theorem contingent_totality_forces_necessary_reality_from_scope
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : CompleteScopedExplanationAxioms M F G E R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · right
    rcases A.nonNecessaryFact_is_explained
      R.totality R.actual_totality hNecessary with ⟨a, hExplain⟩
    have ha : Actual M a := (A.explains_existents hExplain).1
    have hNecessaryA : Necessary M a :=
      totality_explainer_is_necessary_from_scope A hExplain
    have hOutside : ¬ R.inside a :=
      totality_explainer_is_outside A.toScopedExplanationAxioms hExplain
    exact ⟨a, ha, hNecessaryA, hExplain, hOutside⟩

/-- Pure contingency is incompatible with EF4 + S + I + C. -/
theorem no_pure_contingency_from_scope
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : CompleteScopedExplanationAxioms M F G E R) :
    ¬ (¬ NecessaryFact F R.totality ∧
       ∀ x, Actual M x → ¬ Necessary M x) := by
  intro hPure
  rcases contingent_totality_forces_necessary_reality_from_scope A with
      hFact | hEntity
  · exact hPure.1 hFact
  · rcases hEntity with ⟨a, ha, hNecessary, _, _⟩
    exact hPure.2 a ha hNecessary

end Grounding
end Logos
