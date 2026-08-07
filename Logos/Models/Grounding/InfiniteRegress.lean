import Logos.Systems.AbsoluteGround.Theorems

namespace Logos
namespace GroundingModels
namespace InfiniteRegress

open Grounding

/-!
A genuine A2 attack: an acyclic, endlessly deepen-able grounding order.

Every entity has a further ground, so no ungrounded root exists.  Unlike the
finite cycle countermodel, grounding always moves from a structurally larger
term to one of its proper components.  The reverse relation is well founded,
which witnesses acyclicity, while grounding itself is not well founded.

The model also satisfies A0, A1, A3, A4, and A5.  Thus A2 alone is the missing
commitment among the premises relevant to the minimal necessity argument.
-/

inductive RegressWorld where
  | w
  deriving Repr, DecidableEq

inductive RegressEntity where
  | atom
  | lift (x : RegressEntity)
  | join (x y : RegressEntity)
  deriving Repr, DecidableEq

/-- A larger term immediately grounds one of the terms from which it is built. -/
inductive InfiniteGrounds : RegressEntity → RegressEntity → Prop where
  | liftStep (x : RegressEntity) :
      InfiniteGrounds (.lift x) x
  | joinLeft (x y : RegressEntity) :
      InfiniteGrounds (.join x y) x
  | joinRight (x y : RegressEntity) :
      InfiniteGrounds (.join x y) y

def regressModel : Grounding.Model where
  frame := { World := RegressWorld, access := fun _ _ => True }
  Entity := RegressEntity
  actual := .w
  existsAt := fun _ _ => True
  directGrounds := fun _ a x => InfiniteGrounds a x
  created := fun _ => False

abbrev RM := regressModel

/-- An explicit endless chain: each next tower term grounds the previous one. -/
def tower : Nat → RegressEntity
  | 0 => .atom
  | n + 1 => .lift (tower n)

theorem tower_step (n : Nat) :
    ActualGrounds RM (tower (n + 1)) (tower n) := by
  exact InfiniteGrounds.liftStep (tower n)

/-- Every entity has a strictly further immediate ground. -/
theorem regress_derived (x : RegressEntity) :
    Derived RM x := by
  exact ⟨RegressEntity.lift x, InfiniteGrounds.liftStep x⟩

/-- Therefore no entity in the model is ungrounded. -/
theorem regress_no_ungrounded :
    ∀ x, ¬ Ungrounded RM x := by
  intro x hx
  exact hx.2 (regress_derived x)

/-- Acyclic orientation witness: reversing grounding gives structural descent
and is well founded.  A grounding cycle would also be a cycle in this reverse
relation and is therefore excluded. -/
theorem regress_reverse_wellFounded :
    WellFounded (fun x a => ActualGrounds RM a x) := by
  constructor
  intro a
  induction a with
  | atom =>
      apply Acc.intro
      intro y hy
      cases hy
  | lift x ih =>
      apply Acc.intro
      intro y hy
      cases hy with
      | liftStep => exact ih
  | join x y ihx ihy =>
      apply Acc.intro
      intro z hz
      cases hz with
      | joinLeft => exact ihx
      | joinRight => exact ihy

/-- A0. -/
theorem regress_actual_nonempty :
    ∃ x, Actual RM x :=
  ⟨RegressEntity.atom, True.intro⟩

/-- A1. -/
theorem regress_grounds_existents :
    ∀ {w a x}, RM.directGrounds w a x →
      RM.existsAt w a ∧ RM.existsAt w x := by
  intro w a x h
  exact ⟨True.intro, True.intro⟩

/-- A3 holds strongly: `join x y` is an immediate common ground of x and y. -/
theorem regress_common_ground :
    ∀ {x y}, Actual RM x → Actual RM y →
      ∃ z, Actual RM z ∧ GroundAncestor RM z x ∧ GroundAncestor RM z y := by
  intro x y hx hy
  let z := RegressEntity.join x y
  refine ⟨z, True.intro, ?_, ?_⟩
  · exact GroundAncestor.extend
      (GroundAncestor.refl (M := RM) z)
      (InfiniteGrounds.joinLeft x y)
  · exact GroundAncestor.extend
      (GroundAncestor.refl (M := RM) z)
      (InfiniteGrounds.joinRight x y)

/-- A4 holds non-vacuously at the level of derivation: every entity is already
derived, regardless of its modal status. -/
theorem regress_contingent_is_derived :
    ∀ x, Actual RM x → Contingent RM x → Derived RM x := by
  intro x hx hContingent
  exact regress_derived x

/-- A5. -/
theorem regress_actual_reflexive :
    RM.frame.access RM.actual RM.actual :=
  True.intro

/-- The original grounding direction is not well founded.  If it were, A0-A2
would produce an ungrounded root, contradicting `regress_no_ungrounded`. -/
theorem regress_not_wellFounded :
    ¬ WellFounded (ActualGrounds RM) := by
  intro hWF
  let A : FoundationAxioms RM := {
    actual_nonempty := regress_actual_nonempty
    grounds_existents := regress_grounds_existents
    grounding_wellFounded := hWF
  }
  rcases exists_ungrounded A with ⟨a, ha⟩
  exact regress_no_ungrounded a ha

end InfiniteRegress
end GroundingModels
end Logos
