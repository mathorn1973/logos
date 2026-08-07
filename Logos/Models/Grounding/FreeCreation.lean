import Logos.Systems.AbsoluteGround.Theorems

namespace Logos
namespace GroundingModels

open Grounding

/-- Two possible worlds: the actual created world and an accessible world in
which the creature is absent. -/
inductive FreeWorld where
  | actual
  | noCreature
  deriving Repr, DecidableEq

/-- Full accessibility keeps the example inside an S5-like two-world frame. -/
def freeAccess : FreeWorld → FreeWorld → Prop :=
  fun _ _ => True

/-- One absolute-ground candidate and one contingent creature. -/
inductive FreeEntity where
  | ground
  | creature
  deriving Repr, DecidableEq

/-- The ground exists at both worlds; the creature only at the actual world. -/
def freeExistsAt : FreeWorld → FreeEntity → Prop
  | _, .ground => True
  | .actual, .creature => True
  | .noCreature, .creature => False

/-- The only grounding edge is `ground -> creature` at the actual world. -/
def freeDirectGrounds : FreeWorld → FreeEntity → FreeEntity → Prop
  | .actual, .ground, .creature => True
  | _, _, _ => False

/-- Only the creature belongs to the created order. -/
def freeCreated : FreeEntity → Prop
  | .ground => False
  | .creature => True

/-- Concrete model: necessary ground, contingent creation. -/
def freeCreationModel : Grounding.Model where
  frame := {
    World := FreeWorld
    access := freeAccess
  }
  Entity := FreeEntity
  actual := .actual
  existsAt := freeExistsAt
  directGrounds := freeDirectGrounds
  created := freeCreated

abbrev FCM := freeCreationModel

theorem free_ground_actual :
    Actual FCM FreeEntity.ground :=
  True.intro

theorem free_creature_actual :
    Actual FCM FreeEntity.creature :=
  True.intro

theorem free_ground_grounds_creature :
    ActualGrounds FCM FreeEntity.ground FreeEntity.creature :=
  True.intro

theorem free_ground_ancestor_creature :
    GroundAncestor FCM FreeEntity.ground FreeEntity.creature := by
  exact GroundAncestor.extend
    (GroundAncestor.refl (M := FCM) FreeEntity.ground)
    free_ground_grounds_creature

/-- Actual grounding in the example is well founded. -/
theorem free_grounding_wellFounded :
    WellFounded (ActualGrounds FCM) := by
  constructor
  intro x
  cases x with
  | ground =>
      apply Acc.intro
      intro y hy
      cases y <;> exact False.elim hy
  | creature =>
      apply Acc.intro
      intro y hy
      cases y with
      | ground =>
          apply Acc.intro
          intro z hz
          cases z <;> exact False.elim hz
      | creature =>
          exact False.elim hy

/-- The concrete model satisfies A0-A7. -/
def freeCreationAxioms : CreationAxioms FCM where
  actual_nonempty := ⟨FreeEntity.ground, free_ground_actual⟩

  grounds_existents := by
    intro w a x h
    cases w <;> cases a <;> cases x
    · exact False.elim h
    · exact ⟨True.intro, True.intro⟩
    · exact False.elim h
    · exact False.elim h
    · exact False.elim h
    · exact False.elim h
    · exact False.elim h
    · exact False.elim h

  grounding_wellFounded := free_grounding_wellFounded

  common_ground := by
    intro x y hx hy
    refine ⟨FreeEntity.ground, free_ground_actual, ?_, ?_⟩
    · cases x with
      | ground => exact GroundAncestor.refl (M := FCM) FreeEntity.ground
      | creature => exact free_ground_ancestor_creature
    · cases y with
      | ground => exact GroundAncestor.refl (M := FCM) FreeEntity.ground
      | creature => exact free_ground_ancestor_creature

  contingent_is_derived := by
    intro x hx hCont
    cases x with
    | ground =>
        exfalso
        rcases hCont.2 with ⟨w, _, hNot⟩
        cases w <;> exact hNot True.intro
    | creature =>
        exact ⟨FreeEntity.ground, free_ground_grounds_creature⟩

  actual_reflexive := True.intro

  created_is_derived := by
    intro x hx hCreated
    cases x with
    | ground => exact False.elim hCreated
    | creature => exact ⟨FreeEntity.ground, free_ground_grounds_creature⟩

  created_nonempty := ⟨FreeEntity.creature, free_creature_actual, True.intro⟩

/-- The distinguished ground satisfies the formal absolute-ground predicate. -/
theorem free_ground_is_absolute :
    AbsoluteGround FCM FreeEntity.ground := by
  constructor
  · constructor
    · exact free_ground_actual
    · intro hDerived
      rcases hDerived with ⟨a, ha⟩
      cases a <;> exact ha
  constructor
  · intro w _
    cases w <;> exact True.intro
  constructor
  · intro h
    exact h
  · intro x hx
    cases x with
    | ground => exact GroundAncestor.refl (M := FCM) FreeEntity.ground
    | creature => exact free_ground_ancestor_creature

/-- The creature does not exist necessarily. -/
theorem free_creature_not_necessary :
    ¬ Necessary FCM FreeEntity.creature := by
  intro hNecessary
  exact hNecessary FreeWorld.noCreature True.intro

/-- The creature is genuinely contingent: both existence and nonexistence are accessible. -/
theorem free_creature_contingent :
    Contingent FCM FreeEntity.creature := by
  constructor
  · exact ⟨FreeWorld.actual, True.intro, True.intro⟩
  · exact ⟨FreeWorld.noCreature, True.intro, by intro h; exact h⟩

/-- Explicit anti-collapse witness: actuality does not imply necessity for all entities. -/
theorem free_creation_refutes_actual_implies_necessary :
    ¬ (∀ x, Actual FCM x → Necessary FCM x) := by
  intro hCollapse
  exact free_creature_not_necessary
    (hCollapse FreeEntity.creature free_creature_actual)

/-- The abstract A0-A6 theorem is inhabited by this stronger A0-A7 concrete model. -/
theorem free_model_has_unique_absoluteGround :
    ∃ a, AbsoluteGround FCM a ∧ ∀ b, AbsoluteGround FCM b → b = a :=
  exists_unique_absoluteGround freeCreationAxioms.toTranscendenceAxioms

end GroundingModels
end Logos
