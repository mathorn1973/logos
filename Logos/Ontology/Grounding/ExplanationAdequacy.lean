import Logos.Ontology.Grounding.SelfExplanation

universe u v

namespace Logos
namespace Grounding

/-- Local adequacy for explaining an entity's existence.

Raw explanation is retained, including possible self-citation.  The only extra
condition is that if the target is non-necessary, the source used as its
adequate explanation must be distinct from the target.  Necessary targets are
left unrestricted. -/
def AdequateExplainsEntity
    (M : Model.{u, v}) (E : EntityExplanationModel M)
    (a x : M.Entity) : Prop :=
  ActualExplainsEntity E a x ∧
    (¬ Necessary M x → a ≠ x)

/-- An adequate self-explanation can occur only for a necessary target. -/
theorem adequateSelfExplanation_implies_necessary
    {M : Model.{u, v}} {E : EntityExplanationModel M}
    {x : M.Entity} (hx : Actual M x)
    (h : AdequateExplainsEntity M E x x) :
    Necessary M x := by
  apply Classical.byContradiction
  intro hNotNecessary
  exact h.2 hNotNecessary rfl

/-- The global contingent-propriety principle implies local adequacy whenever
the target is actual. -/
theorem adequateExplanation_of_contingentPropriety
    {M : Model.{u, v}} {E : EntityExplanationModel M}
    (hProper : ContingentExplanationProper M E)
    {a x : M.Entity} (hx : Actual M x)
    (hExplain : ActualExplainsEntity E a x) :
    AdequateExplainsEntity M E a x := by
  constructor
  · exact hExplain
  · intro hNotNecessary
    exact hProper hx hNotNecessary hExplain

end Grounding
end Logos
