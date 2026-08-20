import Logos.Ontology.Grounding.ExplanationScope

universe u v

namespace Logos
namespace Grounding

/-- Global explanatory irreflexivity: no actual entity explains itself.

This is the strong principle used by the previous scope cut.  The present cut
will show that it is stronger than the necessary-reality argument requires. -/
def GlobalExplanationIrreflexive
    (M : Model.{u, v}) (E : EntityExplanationModel M) : Prop :=
  ∀ {a}, Actual M a → ¬ ActualExplainsEntity E a a

/-- Minimal anti-vacuity principle for contingent existence.

An explanation of an actually existing non-necessary entity must use a source
distinct from the target.  This says nothing about self-explanation of a
necessary entity. -/
def ContingentExplanationProper
    (M : Model.{u, v}) (E : EntityExplanationModel M) : Prop :=
  ∀ {a x}, Actual M x → ¬ Necessary M x →
    ActualExplainsEntity E a x → a ≠ x

/-- Equivalent self-citation form: an actual non-necessary entity does not
explain its own existence. -/
def ContingentSelfExplanationExcluded
    (M : Model.{u, v}) (E : EntityExplanationModel M) : Prop :=
  ∀ {x}, Actual M x → ¬ Necessary M x →
    ¬ ActualExplainsEntity E x x

/-- The proper-explanation and contingent-self-exclusion readings are exactly
equivalent. -/
theorem contingentExplanationProper_iff_selfExcluded
    {M : Model.{u, v}} {E : EntityExplanationModel M} :
    ContingentExplanationProper M E ↔
      ContingentSelfExplanationExcluded M E := by
  constructor
  · intro h x hx hNot hSelf
    exact (h hx hNot hSelf) rfl
  · intro h a x hx hNot hExplain hEq
    cases hEq
    exact h hx hNot hExplain

/-- Full irreflexivity implies the weaker contingent propriety principle. -/
theorem globalIrreflexivity_implies_contingentExplanationProper
    {M : Model.{u, v}} {E : EntityExplanationModel M}
    (h : GlobalExplanationIrreflexive M E) :
    ContingentExplanationProper M E := by
  intro a x hx hNot hExplain hEq
  cases hEq
  exact h hx hExplain

end Grounding
end Logos
