import Logos.Systems.TotalityRegress.Axioms
import Logos.Systems.AbsoluteGround.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- A regress totality carries an actual infinite descending grounding chain as
data, not as a possibility: `node` and `step` exhibit the chain explicitly.

Therefore no model carrying one can have well-founded actual grounding. -/
theorem regressTotality_refutes_wellFoundedness
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (R : RegressTotality M F) :
    ¬ WellFounded (ActualGrounds M) := by
  intro hWellFounded
  have key : ∀ x, Acc (ActualGrounds M) x → ∀ n, x ≠ R.node n := by
    intro x hAcc
    induction hAcc with
    | intro y _hPred ih =>
        intro n hEq
        subst hEq
        exact ih (R.node (n + 1)) (R.step n) (n + 1) rfl
  exact key (R.node 0) (hWellFounded.apply (R.node 0)) 0 rfl

/-- A2 is a field of `FoundationAxioms`, so the foundation package is
unavailable wherever a regress totality is present. -/
theorem regressTotality_refutes_foundationAxioms
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (R : RegressTotality M F) :
    ¬ FoundationAxioms M := by
  intro A
  exact regressTotality_refutes_wellFoundedness R A.grounding_wellFounded

/-- The same for the minimal necessity package A0-A2 plus A4-A5. -/
theorem regressTotality_refutes_necessaryExistenceAxioms
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (R : RegressTotality M F) :
    ¬ NecessaryExistenceAxioms M := by
  intro A
  exact regressTotality_refutes_foundationAxioms R A.toFoundationAxioms

/-- The two accepted routes cannot be combined.

Assuming a regress totality together with the foundation route's necessity
package proves an arbitrary conclusion, so any bridge theorem stated over both
packages is vacuous and establishes nothing. -/
theorem seam_bridge_is_vacuous
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (R : RegressTotality M F)
    (A : NecessaryExistenceAxioms M)
    {C : Prop} :
    C :=
  absurd A (regressTotality_refutes_necessaryExistenceAxioms R)

end Grounding
end Logos
