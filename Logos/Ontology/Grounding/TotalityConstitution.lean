import Logos.Ontology.Grounding.FactLanguage

universe u v w

namespace Logos
namespace Grounding

/-- W: something actual is not necessary.

This is the presupposition of the programme's question, stated as a premise.
It is phrased with `¬ Necessary` rather than `Contingent` because the totality
packages carry no reflexivity assumption; under `A5` the two readings agree
(`contingencyWitness_iff_contingent_of_reflexive`). -/
def ContingencyWitness (M : Model.{u, v}) : Prop :=
  ∃ x, Actual M x ∧ ¬ Necessary M x

/-- The actual world accesses only itself.

No accepted premise package excludes this frame. On it `Necessary` coincides
with `Actual` and `Contingent` is empty, so the modal content of any
conclusion is supplied by the frame and by nothing in the premises. -/
def SingleSuccessor (M : Model.{u, v}) : Prop :=
  ∀ world, M.frame.access M.actual world → world = M.actual

/-- A fact carrier with exactly one fact, obtaining at a world exactly when
every member of `inside` exists there.

Membership is rigid: `inside` does not vary with the world. Fact grounding is a
parameter and is left free; the construction says what it is for the totality
to obtain and nothing about what grounds it. -/
def constitutedFacts (M : Model.{u, v}) (inside : M.Entity → Prop)
    (groundsFact : M.frame.World → M.Entity → PUnit.{w + 1} → Prop) :
    FactModel.{u, v, w} M where
  Fact := PUnit
  holdsAt := fun world _ => ∀ x, inside x → M.existsAt world x
  groundsFact := groundsFact

/-- In the constituted carrier, the one fact obtains at a world exactly when
every member exists there. This is definitional and is stated so that the law
in `Logos.Systems.TotalityConstitution.Law` can be discharged by it. -/
theorem constitutedFacts_holdsAt
    {M : Model.{u, v}} {inside : M.Entity → Prop}
    {groundsFact : M.frame.World → M.Entity → PUnit.{w + 1} → Prop}
    (world : M.frame.World) (p : PUnit.{w + 1}) :
    (constitutedFacts M inside groundsFact).holdsAt world p ↔
      ∀ x, inside x → M.existsAt world x :=
  Iff.rfl

end Grounding
end Logos
