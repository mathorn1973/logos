import Logos.Ontology.Grounding.ModalUltimacy

universe u v w z

namespace Logos
namespace Grounding

/-- A separate carrier for conditions that license modal variation of facts.

This layer is deliberately distinct from entity grounding and explanatory
support.  A `Condition` need not be an entity and need not explain the actual
fact.  It records only what makes a contrastive failure at an accessible world
metaphysically licensed rather than a bare edge of the Kripke frame. -/
structure ModalVariationModel
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M) where
  Condition : Type z
  availableAt : M.frame.World → Condition → Prop
  licensesFailure : Condition → F.Fact → M.frame.World → Prop

/-- A modal condition is available at the distinguished actual world. -/
def ActualModalCondition
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (V : ModalVariationModel.{u, v, w, z} M F) (c : V.Condition) : Prop :=
  V.availableAt M.actual c

/-- Failure of `p` at `world` is grounded/licensed when the world is accessible,
`p` fails there, and some condition available at actuality licenses that
failure. -/
def GroundedFailureAt
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (V : ModalVariationModel.{u, v, w, z} M F)
    (p : F.Fact) (world : M.frame.World) : Prop :=
  M.frame.access M.actual world ∧
    ¬ F.holdsAt world p ∧
    ∃ c, ActualModalCondition V c ∧ V.licensesFailure c p world

/-- There is a metaphysically licensed accessible alternative at which `p`
fails. -/
def GroundedFailurePossible
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (V : ModalVariationModel.{u, v, w, z} M F) (p : F.Fact) : Prop :=
  ∃ world, GroundedFailureAt V p world

/-- `p` is modally unconditioned when it actually obtains and no available
condition licenses an accessible failure of it.

This is not definitionally modal necessity.  A raw accessible counterexample
may still exist if the frame contains brute/unlicensed modal edges. -/
def ModallyUnconditionedFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (V : ModalVariationModel.{u, v, w, z} M F) (p : F.Fact) : Prop :=
  ActualFact F p ∧ ¬ GroundedFailurePossible V p

/-- No-brute-modality at one fact: every accessible failure of `p` has an
available modal condition licensing that contrast.

This is the substantive bridge between raw Kripke accessibility and the
stronger reading of accessibility as metaphysically grounded possibility. -/
def NoBruteModalVariationAt
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (V : ModalVariationModel.{u, v, w, z} M F) (p : F.Fact) : Prop :=
  ∀ world, M.frame.access M.actual world → ¬ F.holdsAt world p →
    ∃ c, ActualModalCondition V c ∧ V.licensesFailure c p world

/-- A fact that is both explanatorily ultimate and modally unconditioned.

No necessity is included in this definition. -/
def FullyUnconditionedFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F)
    (V : ModalVariationModel.{u, v, w, z} M F)
    (p : F.Fact) : Prop :=
  ExplanatorilyAbsoluteFact G p ∧ ModallyUnconditionedFact V p

end Grounding
end Logos
