import Logos.Ontology.Grounding.ExplanationLanguage

universe u v

namespace Logos
namespace Grounding

/-- Entity-to-entity explanatory dependence, separate from ontological
`directGrounds`, generic fact grounding, and fact explanation.

No adequacy or anti-self-explanation condition is built into this relation. -/
structure EntityExplanationModel (M : Model.{u, v}) where
  explainsEntity : M.frame.World → M.Entity → M.Entity → Prop

/-- Actual entity-level explanation. -/
def ActualExplainsEntity
    {M : Model.{u, v}} (E : EntityExplanationModel M)
    (a x : M.Entity) : Prop :=
  E.explainsEntity M.actual a x

end Grounding
end Logos
