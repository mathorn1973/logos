import Logos.Systems.AbsoluteGround.Theorems

universe u v

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

#print axioms Logos.Grounding.audit_minimal_necessary_ground_boundary
#print axioms Logos.Grounding.audit_foundation_boundary
#print axioms Logos.Grounding.audit_unity_boundary

end Grounding
end Logos
