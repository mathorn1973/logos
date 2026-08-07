import Logos.Ontology.Grounding.SelfExplanation
import Logos.Systems.TotalityExternality.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Minimal totality-explanation package for attacking self-explanation.

Compared with `CompleteScopedExplanationAxioms`, global irreflexivity is gone.
The only anti-vacuity requirement is that explanations of actual non-necessary
entities use a source distinct from the target. -/
structure ContingentScopeAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop
    extends ExplanatoryFactAxioms M F G where
  /-- An explanation of the totality covers every entity in its declared scope. -/
  explains_members :
    ∀ {a}, ActualExplainsFact G a R.totality →
      ∀ {x}, R.inside x → ActualExplainsEntity E a x

  /-- Only contingent targets require a proper, non-identical explanatory source. -/
  contingent_explanation_proper :
    ContingentExplanationProper M E

  /-- The represented totality covers every actual non-necessary entity. -/
  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

end Grounding
end Logos
