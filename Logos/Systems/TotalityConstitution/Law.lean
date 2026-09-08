import Logos.Ontology.Grounding.TotalityConstitution
import Logos.Systems.TotalityRegress.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- The constitution law: the designated totality fact obtains at a world
exactly when every represented member exists there.

Membership `R.inside` is rigid, so at a non-actual world this is the fact that
*these* members exist there. The law fixes `holdsAt` only; `groundsFact`,
`constitutesFact` and `explainsFact` are untouched. -/
def ConstitutedTotality
    {M : Model.{u, v}} (F : FactModel.{u, v, w} M)
    (R : RegressTotality M F) : Prop :=
  ∀ world, F.holdsAt world R.totality ↔ (∀ x, R.inside x → M.existsAt world x)

/-- The forward half of the law: if the totality obtains, every member exists.
Most results need only this half. -/
def TotalityRequiresMembers
    {M : Model.{u, v}} (F : FactModel.{u, v, w} M)
    (R : RegressTotality M F) : Prop :=
  ∀ world, F.holdsAt world R.totality → ∀ x, R.inside x → M.existsAt world x

theorem TotalityRequiresMembers.of_constituted
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : ConstitutedTotality F R) : TotalityRequiresMembers F R :=
  fun world hHolds => (hLaw world).1 hHolds

/-- Given an actual infinite descending grounding chain whose nodes lie inside
a membership predicate, and given that every member actually exists, the
constituted carrier supports a totality record. The existence hypothesis is
forced: `RegressTotality.actual_totality` demands that the totality actually
obtain, and under constitution that is exactly the actual existence of every
member. -/
def constitutedRegress
    (M : Model.{u, v}) (inside : M.Entity → Prop)
    (groundsFact : M.frame.World → M.Entity → PUnit.{w + 1} → Prop)
    (node : Nat → M.Entity)
    (step : ∀ n, ActualGrounds M (node (n + 1)) (node n))
    (node_inside : ∀ n, inside (node n))
    (members_actual : ∀ x, inside x → Actual M x) :
    RegressTotality M (constitutedFacts.{u, v, w} M inside groundsFact) where
  node := node
  step := step
  totality := PUnit.unit
  actual_totality := members_actual
  inside := inside
  node_inside := node_inside

/-- The constructed record satisfies the constitution law by definition. -/
theorem constitutedRegress_law
    (M : Model.{u, v}) (inside : M.Entity → Prop)
    (groundsFact : M.frame.World → M.Entity → PUnit.{w + 1} → Prop)
    (node : Nat → M.Entity)
    (step : ∀ n, ActualGrounds M (node (n + 1)) (node n))
    (node_inside : ∀ n, inside (node n))
    (members_actual : ∀ x, inside x → Actual M x) :
    ConstitutedTotality (constitutedFacts.{u, v, w} M inside groundsFact)
      (constitutedRegress M inside groundsFact node step node_inside members_actual) :=
  fun _ => Iff.rfl

end Grounding
end Logos
