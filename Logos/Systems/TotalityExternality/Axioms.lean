import Logos.Ontology.Grounding.ExplanationLanguage
import Logos.Systems.TotalityRegress.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Old generic externality E, factored as a reusable predicate. -/
def GenericTotalityExternality
    {M : Model.{u, v}} (F : FactModel.{u, v, w} M)
    (R : RegressTotality M F) : Prop :=
  ∀ {a}, ActualGroundsFact F a R.totality → ¬ R.inside a

/-- Role-specific explanatory externality E_expl. -/
def ExplanatoryTotalityExternality
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F)
    (R : RegressTotality M F) : Prop :=
  ∀ {a}, ActualExplainsFact G a R.totality → ¬ R.inside a

/-- Under the explicit bridge G saying explanations are generic fact grounds,
old E implies E_expl. Without G no such ordering is built into the language. -/
theorem genericExternality_implies_explanatoryExternality_of_bridge
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F}
    (hBridge : ExplanationImpliesGrounding G)
    (hExternal : GenericTotalityExternality F R) :
    ExplanatoryTotalityExternality G R := by
  intro a hExplain
  exact hExternal (hBridge hExplain)

/-- Explanation-specific fact commitments.

This record uses EF4, not the accepted generic F4. The two principles are
independent in the unbridged comparison models. Under `ExplanationImpliesGrounding`,
EF4 implies generic F4, while the comparison suite shows the converse still fails. -/
structure ExplanatoryFactAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F) : Prop where
  explains_existents :
    ∀ {a p}, ActualExplainsFact G a p → Actual M a ∧ ActualFact F p
  nonNecessaryFact_is_explained : ExplanatoryFactSufficientGround G

/-- EF4 plus role-specific explanatory externality E_expl. -/
structure ExternalExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (R : RegressTotality M F) : Prop
    extends ExplanatoryFactAxioms M F G where
  totality_explanation_external : ExplanatoryTotalityExternality G R

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
