import Logos.Ontology.Grounding.ScopeCarrier

universe u

namespace Logos
namespace Grounding

/-- The conditions the accepted totality route imposes on its carrier, stated
for an arbitrary carrier.

The first three transcribe `TotalityExplanationCore` with every reference to
entities removed.  The fourth is the one thing that is definitional in the
entity case and therefore invisible there: adequacy refuses to let a
non-necessary item count as its own adequate explanation.

Nothing in this record mentions a fact model, a regress, or a world.  That is
the point: it is a statement about how a carrier is treated, not about what
kind of thing populates it. -/
structure ScopeClosureAxioms {S : Type u} (K : ScopeCarrier S) : Prop where
  /-- Whatever explains the target is itself actual. -/
  explains_source_actual :
    ∀ {a}, K.Explains a → K.Actual a

  /-- Completeness C: every actual non-necessary item is inside the totality. -/
  covers_nonNecessary :
    ∀ a, K.Actual a → ¬ K.Necessary a → K.Inside a

  /-- Scope S: an explanation of the target adequately explains every actual
  item inside the totality. -/
  adequate_members :
    ∀ {a}, K.Explains a → ∀ {x}, K.Inside x → K.Actual x → K.Adequate a x

  /-- Adequacy is not self-satisfiable for a non-necessary item. -/
  adequacy_excludes_contingent_self :
    ∀ {a}, ¬ K.Necessary a → ¬ K.Adequate a a

end Grounding
end Logos
