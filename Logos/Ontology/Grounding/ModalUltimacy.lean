import Logos.Ontology.Grounding.ExplanatoryAbsolute

universe u v w

namespace Logos
namespace Grounding

/-- Modal absoluteness of a fact: it actually obtains and obtains throughout
all worlds accessible from the distinguished actual world.

This is deliberately distinct from explanatory absoluteness. -/
def ModallyAbsoluteFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (p : F.Fact) : Prop :=
  ActualFact F p ∧ NecessaryFact F p

/-- A brute modal asymmetry: the fact obtains actually, fails at some accessible
world, and nevertheless has no registered explanatory source.

This exposes the exact modal shape of a contingent explanatory absolute. -/
def BruteModalAsymmetryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ActualFact F p ∧
    (∃ world, M.frame.access M.actual world ∧ ¬ F.holdsAt world p) ∧
    ¬ ExplainedFact G p

/-- Local modal-stability bridge for one designated fact.

It says only that explanatory ultimacy at this fact entails modal necessity.
No such bridge is built into the meanings of `ExplanatorilyAbsoluteFact` or
`NecessaryFact`. -/
def UltimateModalStabilityAt
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ExplanatorilyAbsoluteFact G p → NecessaryFact F p

/-- Failure of necessity yields an accessible counterexample world, classically. -/
theorem accessibleCounterexample_of_notNecessaryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {p : F.Fact} (hNotNecessary : ¬ NecessaryFact F p) :
    ∃ world, M.frame.access M.actual world ∧ ¬ F.holdsAt world p := by
  apply Classical.byContradiction
  intro hNoCounterexample
  apply hNotNecessary
  intro world hAccess
  apply Classical.byContradiction
  intro hNotHolds
  apply hNoCounterexample
  exact ⟨world, hAccess, hNotHolds⟩

/-- A contingent explanatory absolute is exactly an unexplained actual modal
asymmetry: actual here, false at an accessible alternative, and unexplained. -/
theorem contingentAbsolute_iff_bruteModalAsymmetry
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact} :
    ContingentExplanatoryAbsoluteFact G p ↔
      BruteModalAsymmetryFact G p := by
  constructor
  · intro hAbsolute
    exact ⟨
      hAbsolute.1,
      accessibleCounterexample_of_notNecessaryFact hAbsolute.2.1,
      hAbsolute.2.2
    ⟩
  · intro hBrute
    rcases hBrute with ⟨hActual, ⟨world, hAccess, hNotHolds⟩, hNotExplained⟩
    have hNotNecessary : ¬ NecessaryFact F p := by
      intro hNecessary
      exact hNotHolds (hNecessary world hAccess)
    exact ⟨hActual, hNotNecessary, hNotExplained⟩

/-- Critical boundary theorem.

For an actual fact, the statement "if this fact is explanatorily absolute then
it is necessary" is equivalent to local EF4 at exactly that fact.

Therefore deriving necessity from explanatory ultimacy is not an independent
way around the sufficient-explanation question; it is the same commitment in a
modal-stability formulation. -/
theorem ultimateModalStabilityAt_iff_localFactSufficientExplanation
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (hp : ActualFact F p) :
    UltimateModalStabilityAt G p ↔ LocalFactSufficientExplanation G p := by
  constructor
  · intro hStability hNotNecessary
    apply Classical.byContradiction
    intro hNotExplained
    have hAbsolute : ExplanatorilyAbsoluteFact G p := ⟨hp, hNotExplained⟩
    exact hNotNecessary (hStability hAbsolute)
  · intro hSufficient hAbsolute
    apply Classical.byContradiction
    intro hNotNecessary
    exact hAbsolute.2 (hSufficient hNotNecessary)

/-- Equivalently, local modal stability is exactly exclusion of a contingent
explanatory absolute at an actual fact. -/
theorem ultimateModalStabilityAt_iff_noContingentAbsolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (hp : ActualFact F p) :
    UltimateModalStabilityAt G p ↔
      ¬ ContingentExplanatoryAbsoluteFact G p := by
  rw [ultimateModalStabilityAt_iff_localFactSufficientExplanation hp]
  constructor
  · intro hLocal hAbsolute
    exact hAbsolute.2.2 (hLocal hAbsolute.2.1)
  · intro hNoAbsolute hNotNecessary
    apply Classical.byContradiction
    intro hNotExplained
    exact hNoAbsolute ⟨hp, hNotNecessary, hNotExplained⟩

end Grounding
end Logos
