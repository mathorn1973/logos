import Logos.Systems.TotalityExternality.Theorems
import Logos.Systems.TotalityExternality.ScopeTheorems

universe u v w

namespace Logos
namespace Grounding

/-- B1: explicit-E_expl layer is pinned to its role-specific package.
No A2 or A3 record occurs in this type. -/
theorem audit_totality_externality_explicit_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {R : RegressTotality M F} :
    CompleteExplanationAxioms M F G R →
      NecessaryFact F R.totality ∨
        ∃ a, Actual M a ∧ Necessary M a ∧
          ActualExplainsFact G a R.totality ∧ ¬ R.inside a :=
  contingent_totality_forces_necessary_explanation

/-- B2: deepest layer is pinned to EF4 + S + I + C only.
No A2/A3 record and no externality record occurs in this type. -/
theorem audit_totality_externality_scope_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F} :
    CompleteScopedExplanationAxioms M F G E R →
      NecessaryFact F R.totality ∨
        ∃ a, Actual M a ∧ Necessary M a ∧
          ActualExplainsFact G a R.totality ∧ ¬ R.inside a :=
  contingent_totality_forces_necessary_reality_from_scope

#print axioms Logos.Grounding.audit_totality_externality_explicit_boundary
#print axioms Logos.Grounding.audit_totality_externality_scope_boundary

end Grounding
end Logos
