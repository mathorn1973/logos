import Logos.Ontology.Grounding.ExplanationLanguage
import Logos.Systems.TotalityRegress.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Explanation-specific fact commitments.

This record uses EF4, not the accepted generic F4. The two principles are
independent in the preregistered comparison models unless an additional bridge
is supplied. -/
structure ExplanatoryFactAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F) : Prop where
  explains_existents :
    ∀ {a p}, ActualExplainsFact G a p → Actual M a ∧ ActualFact F p
  nonNecessaryFact_is_explained : ExplanatoryFactSufficientGround G

/-- Role-specific explanatory externality E_expl. -/
structure ExternalExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (R : RegressTotality M F) : Prop
    extends ExplanatoryFactAxioms M F G where
  totality_explanation_external :
    ∀ {a}, ActualExplainsFact G a R.totality → ¬ R.inside a

/-- EF4 + E_expl + completeness C. -/
structure CompleteExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (R : RegressTotality M F) : Prop
    extends ExternalExplanationAxioms M F G R where
  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

end Grounding
end Logos
