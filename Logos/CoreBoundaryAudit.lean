import Logos.Systems.AbsoluteGround.Theorems
import Logos.Systems.TotalityRegress.Theorems

universe u v w

namespace Logos
namespace Grounding

/-- Machine-pinned minimal theorem boundary.

If `exists_necessary_ungrounded` were strengthened to require A3 or any of the
A6-A8 extension records, this wrapper would stop elaborating. -/
theorem audit_minimal_necessary_ground_boundary
    {M : Model.{u, v}} :
    NecessaryExistenceAxioms M →
      ∃ a, Ungrounded M a ∧ Necessary M a :=
  exists_necessary_ungrounded

/-- The root-existence layer uses only A0-A2. -/
theorem audit_foundation_boundary
    {M : Model.{u, v}} :
    FoundationAxioms M → ∃ a, Ungrounded M a :=
  exists_ungrounded

/-- Unity is a separate strengthening and is required only when uniqueness is requested. -/
theorem audit_unity_boundary
    {M : Model.{u, v}} :
    StructuralAxioms M →
      ∃ a, Ungrounded M a ∧ ∀ b, Ungrounded M b → b = a :=
  exists_unique_ungrounded

/-- TOTALITY-REGRESS-1 is pinned to its own F4+E+C package.

No foundation/well-foundedness record A2 and no unity record A3 occurs in this
signature. If either were added as a premise of the load-bearing theorem, this
wrapper would stop elaborating. -/
theorem audit_totality_regress_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F} :
    CompleteContingentTotalityAxioms M F R →
      NecessaryFact F R.totality ∨
        ∃ a, Actual M a ∧ Necessary M a ∧
          ActualGroundsFact F a R.totality ∧ ¬ R.inside a :=
  contingent_totality_forces_necessary_reality

/-- The pure-contingency corollary has the same exact premise boundary. -/
theorem audit_no_pure_contingent_reality_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {R : RegressTotality M F} :
    CompleteContingentTotalityAxioms M F R →
      ¬ (¬ NecessaryFact F R.totality ∧
         ∀ x, Actual M x → ¬ Necessary M x) :=
  no_pure_contingent_reality

#print axioms Logos.Grounding.audit_minimal_necessary_ground_boundary
#print axioms Logos.Grounding.audit_foundation_boundary
#print axioms Logos.Grounding.audit_unity_boundary
#print axioms Logos.Grounding.audit_totality_regress_boundary
#print axioms Logos.Grounding.audit_no_pure_contingent_reality_boundary

end Grounding
end Logos
