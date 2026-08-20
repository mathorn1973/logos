import Logos.Systems.CarrierSchema.Axioms

universe u

namespace Logos
namespace Grounding

/-- The engine of the accepted totality route, carrier-neutral.

An explainer of the target is actual.  If it were non-necessary, completeness
would put it inside the totality, scope would then require it to explain itself
adequately, and adequacy forbids exactly that for a non-necessary item. -/
theorem closure_explainer_is_necessary
    {S : Type u} {K : ScopeCarrier S}
    (A : ScopeClosureAxioms K)
    {a : S} (hExplains : K.Explains a) :
    K.Necessary a := by
  have ha : K.Actual a := A.explains_source_actual hExplains
  apply Classical.byContradiction
  intro hNotNecessary
  have hInside : K.Inside a := A.covers_nonNecessary a ha hNotNecessary
  exact A.adequacy_excludes_contingent_self hNotNecessary
    (A.adequate_members hExplains hInside ha)

/-- The fork, at an arbitrary carrier.

Either something actual and necessary at this carrier explains the target, or
nothing at this carrier explains it at all.  There is no third option in which
a merely contingent item at a closed carrier does the explaining. -/
theorem closure_dichotomy
    {S : Type u} {K : ScopeCarrier S}
    (A : ScopeClosureAxioms K) :
    (∃ a, K.Actual a ∧ K.Necessary a ∧ K.Explains a) ∨ (∀ a, ¬ K.Explains a) := by
  by_cases hSome : ∃ a, K.Explains a
  · rcases hSome with ⟨a, hExplains⟩
    exact Or.inl ⟨a, A.explains_source_actual hExplains,
      closure_explainer_is_necessary A hExplains, hExplains⟩
  · right
    intro a hExplains
    exact hSome ⟨a, hExplains⟩

/-- Stability of the fork under carrier extension.

Introducing a new kind of item and letting a contingent one of them explain the
target does not dissolve the fork.  It can only be done by exempting the new
carrier from the very conditions the argument imposes on the old one.

Read it no more strongly than that.  `Explains` here is uninterpreted, so this
says a contingent item can be offered as an explainer of the target only at an
exempt carrier.  It does not say the item is itself unexplained, and it supplies
no interpretation of `Explains` for any particular fresh carrier. -/
theorem escape_requires_exemption
    {S : Type u} {K : ScopeCarrier S} {a : S}
    (hExplains : K.Explains a) (hNotNecessary : ¬ K.Necessary a) :
    ¬ ScopeClosureAxioms K :=
  fun A => hNotNecessary (closure_explainer_is_necessary A hExplains)

/-- The contrapositive reading used when auditing a proposed escape: a closed
carrier whose every item is contingent explains the target nowhere, so the
target is absolute relative to it. -/
theorem pure_contingency_leaves_target_absolute_at_carrier
    {S : Type u} {K : ScopeCarrier S}
    (A : ScopeClosureAxioms K)
    (hAllContingent : ∀ a, K.Actual a → ¬ K.Necessary a) :
    ∀ a, ¬ K.Explains a := by
  intro a hExplains
  exact hAllContingent a (A.explains_source_actual hExplains)
    (closure_explainer_is_necessary A hExplains)

end Grounding
end Logos
