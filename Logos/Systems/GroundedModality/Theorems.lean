import Logos.Ontology.Grounding.GroundedModality

universe u v w z

namespace Logos
namespace Grounding

/-- Modal necessity always excludes grounded failure. -/
theorem necessary_implies_modallyUnconditioned
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {V : ModalVariationModel.{u, v, w, z} M F}
    {p : F.Fact}
    (hp : ActualFact F p)
    (hNecessary : NecessaryFact F p) :
    ModallyUnconditionedFact V p := by
  refine ⟨hp, ?_⟩
  intro hFailure
  rcases hFailure with ⟨world, hAccess, hNotHolds, c, hcActual, hcLicense⟩
  exact hNotHolds (hNecessary world hAccess)

/-- Under no-brute-modality, modal unconditionedness forces ordinary Kripke
necessity.  No explanatory sufficient-reason principle is used. -/
theorem modallyUnconditioned_implies_necessary_of_noBrute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {V : ModalVariationModel.{u, v, w, z} M F}
    {p : F.Fact}
    (hNoBrute : NoBruteModalVariationAt V p)
    (hUnconditioned : ModallyUnconditionedFact V p) :
    NecessaryFact F p := by
  intro world hAccess
  apply Classical.byContradiction
  intro hNotHolds
  have hCondition := hNoBrute world hAccess hNotHolds
  rcases hCondition with ⟨c, hcActual, hcLicense⟩
  apply hUnconditioned.2
  exact ⟨world, hAccess, hNotHolds, c, hcActual, hcLicense⟩

/-- Once every raw accessible contrast is required to be grounded,
`ModallyUnconditionedFact` coincides with modal absoluteness.  Without the
no-brute premise this equivalence is false, as the model suite shows. -/
theorem modallyUnconditioned_iff_modallyAbsolute_of_noBrute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {V : ModalVariationModel.{u, v, w, z} M F}
    {p : F.Fact}
    (hNoBrute : NoBruteModalVariationAt V p) :
    ModallyUnconditionedFact V p ↔ ModallyAbsoluteFact p := by
  constructor
  · intro hUnconditioned
    exact ⟨hUnconditioned.1,
      modallyUnconditioned_implies_necessary_of_noBrute hNoBrute hUnconditioned⟩
  · intro hAbsolute
    exact necessary_implies_modallyUnconditioned hAbsolute.1 hAbsolute.2

/-- A fact absolute in both explanatory and modal-conditioning senses is
necessary once brute modal variation is excluded.

The explanatory component is retained because this is the intended formal
shape of a fully unconditioned absolute, but necessity is carried by the modal
unconditionedness + no-brute-modality pair. -/
theorem fullyUnconditioned_implies_necessary_of_noBrute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {V : ModalVariationModel.{u, v, w, z} M F}
    {p : F.Fact}
    (hNoBrute : NoBruteModalVariationAt V p)
    (hAbsolute : FullyUnconditionedFact G V p) :
    NecessaryFact F p :=
  modallyUnconditioned_implies_necessary_of_noBrute hNoBrute hAbsolute.2

/-- If `p` is actual and non-necessary while modal variation is complete, then
some actual modal condition must license a concrete accessible failure.

This exposes the exact price of contingency under grounded modality. -/
theorem nonNecessary_yields_modalCondition_of_noBrute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {V : ModalVariationModel.{u, v, w, z} M F}
    {p : F.Fact}
    (hNoBrute : NoBruteModalVariationAt V p)
    (hNotNecessary : ¬ NecessaryFact F p) :
    GroundedFailurePossible V p := by
  rcases accessibleCounterexample_of_notNecessaryFact hNotNecessary with
    ⟨world, hAccess, hNotHolds⟩
  rcases hNoBrute world hAccess hNotHolds with ⟨c, hcActual, hcLicense⟩
  exact ⟨world, hAccess, hNotHolds, c, hcActual, hcLicense⟩

end Grounding
end Logos
