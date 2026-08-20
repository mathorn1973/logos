import Logos.Ontology.Grounding.ModalUltimacy
import Logos.Systems.FactSufficientExplanation.Theorems

universe u v w

namespace Logos
namespace Grounding

/-- Pure contingency at the entity and totality levels forces an unexplained
modal asymmetry at the totality fact.

This is the exact EF4-free form of the brute-fact escape. -/
theorem pure_contingency_forces_brute_modal_asymmetry
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hFactNonNecessary : ¬ NecessaryFact F R.totality)
    (hEntitiesNonNecessary : ∀ x, Actual M x → ¬ Necessary M x) :
    BruteModalAsymmetryFact G R.totality := by
  have hAbsolute : ContingentExplanatoryAbsoluteFact G R.totality :=
    pure_contingency_forces_contingent_explanatory_absolute
      A hFactNonNecessary hEntitiesNonNecessary
  exact contingentAbsolute_iff_bruteModalAsymmetry.mp hAbsolute

/-- At the designated actual totality fact, the proposed bridge from
explanatory ultimacy to modal necessity is exactly local EF4.

This theorem prevents a verbal relabeling from being mistaken for a new proof. -/
theorem totality_ultimateModalStability_iff_localEF4
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F} :
    UltimateModalStabilityAt G R.totality ↔
      LocalFactSufficientExplanation G R.totality :=
  ultimateModalStabilityAt_iff_localFactSufficientExplanation R.actual_totality

/-- The same bridge is exactly the exclusion of the brute contingent-totality
option in the EF4-free trichotomy. -/
theorem totality_ultimateModalStability_iff_noContingentAbsolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F} :
    UltimateModalStabilityAt G R.totality ↔
      ¬ ContingentExplanatoryAbsoluteFact G R.totality :=
  ultimateModalStabilityAt_iff_noContingentAbsolute R.actual_totality

end Grounding
end Logos
