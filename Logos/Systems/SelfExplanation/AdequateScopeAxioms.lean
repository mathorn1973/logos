import Logos.Ontology.Grounding.ExplanationAdequacy
import Logos.Systems.TotalityExternality.Axioms
import Logos.Systems.SelfExplanation.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Even weaker package: no global anti-self-explanation principle at all.

Only the explanations supplied *within the totality explanation itself* must be
adequate for their targets.  Self-citations elsewhere in the explanation graph
are allowed. -/
structure AdequateTotalityScopeAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop
    extends ExplanatoryFactAxioms M F G where
  adequate_members :
    ∀ {a}, ActualExplainsFact G a R.totality →
      ∀ {x}, R.inside x → Actual M x →
        AdequateExplainsEntity M E a x

  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

/-- The earlier global contingent-propriety package implies this local package. -/
def ContingentScopeAxioms.toAdequateTotalityScopeAxioms
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : ContingentScopeAxioms M F G E R) :
    AdequateTotalityScopeAxioms M F G E R where
  toExplanatoryFactAxioms := A.toExplanatoryFactAxioms
  adequate_members := by
    intro a hExplain x hInside hx
    have hRaw := A.explains_members hExplain hInside
    exact adequateExplanation_of_contingentPropriety
      A.contingent_explanation_proper hx hRaw
  covers_nonNecessary := A.covers_nonNecessary

end Grounding
end Logos
