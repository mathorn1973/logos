import Logos.Ontology.Grounding.ExplanationAdequacy

universe u

namespace Logos
namespace Grounding

/-- A bare carrier for the totality explanation engine.

`S` is whatever kind of item is offered as the terminus of explanation for one
designated target.  In the accepted route `S` is a domain of entities, but
nothing here presupposes that.  A modal condition, a ground of a condition, or
any further structure introduced by a later escape is equally a carrier.

The five predicates are exactly what the accepted argument consults about its
sources.  Fact structure, worlds, accessibility and the regress itself are all
absent: they play no part in the step that forces an explainer to be
necessary. -/
structure ScopeCarrier (S : Type u) where
  /-- The item belongs to actual reality. -/
  Actual : S → Prop
  /-- The item could not have failed to be. -/
  Necessary : S → Prop
  /-- The item falls inside the represented totality. -/
  Inside : S → Prop
  /-- The item is registered as explaining the one designated target. -/
  Explains : S → Prop
  /-- The first item is an adequate explanation of the second. -/
  Adequate : S → S → Prop

end Grounding
end Logos
