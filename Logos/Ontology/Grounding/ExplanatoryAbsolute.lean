import Logos.Ontology.Grounding.ExplanationLanguage

universe u v w

namespace Logos
namespace Grounding

/-- A fact is explanatorily absolute when it actually obtains and no entity is
registered as an actual explanatory source for it.

This is a purely structural notion relative to the chosen explanatory relation.
It does not imply modal necessity. -/
def ExplanatorilyAbsoluteFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ActualFact F p ∧ ¬ ExplainedFact G p

/-- A contingent explanatory absolute: actual, non-necessary, and unexplained. -/
def ContingentExplanatoryAbsoluteFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ActualFact F p ∧ ¬ NecessaryFact F p ∧ ¬ ExplainedFact G p

/-- The local fact-level sufficient-explanation principle at one designated fact. -/
def LocalFactSufficientExplanation
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ¬ NecessaryFact F p → ExplainedFact G p

/-- Every contingent explanatory absolute is explanatorily absolute. -/
theorem contingentAbsolute_is_explanatorilyAbsolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (h : ContingentExplanatoryAbsoluteFact G p) :
    ExplanatorilyAbsoluteFact G p :=
  ⟨h.1, h.2.2⟩

/-- For an actual fact, rejecting local sufficient explanation is exactly
accepting that fact as a contingent explanatory absolute. -/
theorem not_localFactSufficientExplanation_iff_contingentAbsolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (hp : ActualFact F p) :
    ¬ LocalFactSufficientExplanation G p ↔
      ContingentExplanatoryAbsoluteFact G p := by
  constructor
  · intro hLocal
    have hNotNecessary : ¬ NecessaryFact F p := by
      intro hNecessary
      apply hLocal
      intro hNotNecessary
      exact False.elim (hNotNecessary hNecessary)
    have hNotExplained : ¬ ExplainedFact G p := by
      intro hExplained
      apply hLocal
      intro _
      exact hExplained
    exact ⟨hp, hNotNecessary, hNotExplained⟩
  · intro hAbsolute hLocal
    exact hAbsolute.2.2 (hLocal hAbsolute.2.1)

end Grounding
end Logos
