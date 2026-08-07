import Logos.Ontology.Grounding.ExplanationScope
import Logos.Systems.TotalityExternality.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- Lower-level explanatory principles from which E_expl can be derived.

No externality field is present in this record. -/
structure ScopedExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop
    extends ExplanatoryFactAxioms M F G where
  /-- S: an explanation of the totality covers every entity inside its claimed scope. -/
  explains_members :
    ∀ {a}, ActualExplainsFact G a R.totality →
      ∀ {x}, R.inside x → ActualExplainsEntity E a x
  /-- I: no actual entity explains itself in this entity-explanation relation. -/
  explanation_irreflexive :
    ∀ {a}, Actual M a → ¬ ActualExplainsEntity E a a

/-- EF4 + S + I + completeness C. No E or E_expl field occurs. -/
structure CompleteScopedExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop
    extends ScopedExplanationAxioms M F G E R where
  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

end Grounding
end Logos
