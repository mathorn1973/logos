import Logos.Ontology.Grounding.Language

universe u v w

namespace Logos
namespace Grounding

/-- A fact layer over an entity-grounding model.

Facts are deliberately a separate carrier.  Introducing a fact is therefore an
explicit semantic commitment rather than silently reifying a proposition as an
entity.  `groundsFact world entity fact` says that an entity grounds a fact at
a world. -/
structure FactModel (M : Model.{u, v}) where
  Fact : Type w
  holdsAt : M.frame.World → Fact → Prop
  groundsFact : M.frame.World → M.Entity → Fact → Prop

/-- A fact holds at the distinguished actual world. -/
def ActualFact {M : Model.{u, v}} (F : FactModel.{u, v, w} M) (p : F.Fact) : Prop :=
  F.holdsAt M.actual p

/-- A fact is necessary relative to accessibility from the actual world. -/
def NecessaryFact {M : Model.{u, v}} (F : FactModel.{u, v, w} M) (p : F.Fact) : Prop :=
  box M.frame (fun world => F.holdsAt world p) M.actual

/-- An entity grounds a fact at the actual world. -/
def ActualGroundsFact {M : Model.{u, v}} (F : FactModel.{u, v, w} M)
    (a : M.Entity) (p : F.Fact) : Prop :=
  F.groundsFact M.actual a p

/-- A fact is derived at the actual world when some entity grounds it there. -/
def DerivedFact {M : Model.{u, v}} (F : FactModel.{u, v, w} M) (p : F.Fact) : Prop :=
  ∃ a, ActualGroundsFact F a p

/-- An actual fact with no actual entity-ground. -/
def UngroundedFact {M : Model.{u, v}} (F : FactModel.{u, v, w} M) (p : F.Fact) : Prop :=
  ActualFact F p ∧ ¬ DerivedFact F p

end Grounding
end Logos
