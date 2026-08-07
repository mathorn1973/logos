import Logos.Systems.TotalityRegress.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- If the regress-totality fact is not necessary, fact-level A4' gives it an
actual entity-ground; externality then puts that ground outside the regress. -/
theorem regress_totality_necessary_or_external_ground
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F}
    (A : ExternalRegressTotalityAxioms M F R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ ActualGroundsFact F a R.totality ∧ ¬ R.inside a := by
  by_cases hNecessary : NecessaryFact F R.totality
  · exact Or.inl hNecessary
  · right
    have hDerived :=
      A.nonNecessaryFact_is_derived R.totality R.actual_totality hNecessary
    rcases hDerived with ⟨a, ha⟩
    have hActual := (A.groundsFact_existents ha).1
    exact ⟨a, hActual, ha, A.totality_ground_external ha⟩

/-- If the regress represents all actual non-necessary entities, every external
ground of its totality fact is necessary. -/
theorem external_totality_ground_is_necessary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F}
    (A : CompleteContingentTotalityAxioms M F R)
    {a : M.Entity}
    (ha : Actual M a)
    (hGround : ActualGroundsFact F a R.totality) :
    Necessary M a := by
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside := A.covers_nonNecessary a ha hNotNecessary
  exact A.totality_ground_external hGround hInside

/-- Main TOTALITY-REGRESS-1 dichotomy.

A candidate totality of contingent reality cannot remain purely contingent:
either the totality fact itself is necessary, or it has a necessary actual
entity-ground outside the regress.  No well-foundedness assumption A2 is used.
-/
theorem contingent_totality_forces_necessary_reality
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F}
    (A : CompleteContingentTotalityAxioms M F R) :
    NecessaryFact F R.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualGroundsFact F a R.totality ∧ ¬ R.inside a := by
  rcases regress_totality_necessary_or_external_ground
    A.toExternalRegressTotalityAxioms with hNecessary | hExternal
  · exact Or.inl hNecessary
  · right
    rcases hExternal with ⟨a, ha, hGround, hOutside⟩
    have hNecessary := external_totality_ground_is_necessary A ha hGround
    exact ⟨a, ha, hNecessary, hGround, hOutside⟩

/-- Pure contingency is incompatible with the complete-totality assumptions:
it cannot be the case that the totality fact is non-necessary and every actual
entity is also non-necessary. -/
theorem no_pure_contingent_reality
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F}
    (A : CompleteContingentTotalityAxioms M F R) :
    ¬ (¬ NecessaryFact F R.totality ∧
       ∀ x, Actual M x → ¬ Necessary M x) := by
  intro hPure
  rcases contingent_totality_forces_necessary_reality A with hFact | hEntity
  · exact hPure.1 hFact
  · rcases hEntity with ⟨a, ha, hNecessary, _, _⟩
    exact hPure.2 a ha hNecessary

end Grounding
end Logos
