import Logos.Ontology.Grounding.ExplanationLanguage

universe u v w

namespace Logos
namespace Grounding

/-! # NECESSITATION-1: the two necessitation premises

Both definitions are premises. They appear only as hypotheses of the theorems
of this cut and are never asserted globally. Section 3 of
`NECESSITATION-CONTRACT.md` records the four choices made here. -/

/-- Full-ground necessitation at the actual world.

For every entity with an actual immediate ground (such an entity is actual
under A1), at every world accessible from the actual one, if all of its actual
immediate grounds exist there, the entity exists there too.
The antecedent is the whole plurality of actual immediate grounds, so a single
partial ground is not required to necessitate anything. -/
def GroundingNecessitates (M : Model.{u, v}) : Prop :=
  ∀ x, Derived M x →
    box M.frame
      (fun world => (∀ a, ActualGrounds M a x → M.existsAt world a) → M.existsAt world x)
      M.actual

/-- Local explanatory necessitation at one fact.

If the fact is explained at the actual world, then at every accessible world
where all of its actual explanatory sources exist, the fact obtains. An
unexplained fact satisfies this vacuously. -/
def ExplanationNecessitates
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ExplainedFact G p →
    box M.frame
      (fun world => (∀ a, ActualExplainsFact G a p → M.existsAt world a) → F.holdsAt world p)
      M.actual

end Grounding
end Logos
