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

/-! ## Exhaustiveness at the level of entity grounding -/

/-- From a point that is not accessible, an immediate ground that is not
accessible either. -/
theorem exists_notAcc_pred
    {M : Model.{u, v}} {x : M.Entity}
    (hx : ¬ Acc (ActualGrounds M) x) :
    ∃ y, ActualGrounds M y x ∧ ¬ Acc (ActualGrounds M) y := by
  apply Classical.byContradiction
  intro hNone
  apply hx
  refine Acc.intro x ?_
  intro y hy
  apply Classical.byContradiction
  intro hNotAcc
  exact hNone ⟨y, hy, hNotAcc⟩

/-- Failure of well-foundedness supplies a point that is not accessible. -/
theorem exists_notAcc
    {M : Model.{u, v}}
    (h : ¬ WellFounded (ActualGrounds M)) :
    ∃ x, ¬ Acc (ActualGrounds M) x := by
  apply Classical.byContradiction
  intro hNone
  apply h
  refine WellFounded.intro ?_
  intro a
  apply Classical.byContradiction
  intro hNotAcc
  exact hNone ⟨a, hNotAcc⟩

/-- Failure of A2 yields an actual infinite descending grounding chain.

This uses classical choice to select a deeper ground at each step. It is the
converse direction of `regressTotality_refutes_wellFoundedness` at the level of
entities, before any fact structure is involved. -/
theorem exists_descending_chain_of_not_wellFounded
    {M : Model.{u, v}}
    (h : ¬ WellFounded (ActualGrounds M)) :
    ∃ f : Nat → M.Entity, ∀ n, ActualGrounds M (f (n + 1)) (f n) := by
  classical
  let S := { a : M.Entity // ¬ Acc (ActualGrounds M) a }
  have hStep : ∀ s : S, ∃ t : S, ActualGrounds M t.1 s.1 := by
    intro s
    rcases exists_notAcc_pred s.2 with ⟨y, hy, hyNot⟩
    exact ⟨⟨y, hyNot⟩, hy⟩
  rcases exists_notAcc h with ⟨x0, hx0⟩
  let next : S → S := fun s => Classical.choose (hStep s)
  have hNext : ∀ s : S, ActualGrounds M (next s).1 s.1 := by
    intro s; exact Classical.choose_spec (hStep s)
  let seq : Nat → S := fun n => Nat.rec (⟨x0, hx0⟩ : S) (fun _ p => next p) n
  refine ⟨fun n => (seq n).1, ?_⟩
  intro n
  exact hNext (seq n)

end Grounding
end Logos
