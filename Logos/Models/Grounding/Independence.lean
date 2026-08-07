import Logos.Systems.AbsoluteGround.Theorems

namespace Logos
namespace GroundingModels
namespace Independence

open Grounding

/-! ## A2: a finite grounding cycle

A0, A1, and the common-ground condition can hold while every entity is derived.
The missing commitment is well-foundedness.
-/

inductive CycleWorld where
  | w
  deriving Repr, DecidableEq

inductive CycleEntity where
  | left
  | right
  deriving Repr, DecidableEq

def cycleModel : Grounding.Model where
  frame := { World := CycleWorld, access := fun _ _ => True }
  Entity := CycleEntity
  actual := .w
  existsAt := fun _ _ => True
  directGrounds := fun _ a x =>
    match a, x with
    | .left, .right => True
    | .right, .left => True
    | _, _ => False
  created := fun _ => False

abbrev CM := cycleModel

theorem cycle_left_grounds_right :
    ActualGrounds CM CycleEntity.left CycleEntity.right := True.intro

theorem cycle_right_grounds_left :
    ActualGrounds CM CycleEntity.right CycleEntity.left := True.intro

theorem cycle_left_ancestor_right :
    GroundAncestor CM CycleEntity.left CycleEntity.right :=
  GroundAncestor.extend
    (GroundAncestor.refl (M := CM) CycleEntity.left)
    cycle_left_grounds_right

theorem cycle_left_ancestor_left :
    GroundAncestor CM CycleEntity.left CycleEntity.left :=
  GroundAncestor.refl (M := CM) CycleEntity.left

theorem cycle_no_ungrounded :
    ∀ x, ¬ Ungrounded CM x := by
  intro x hx
  cases x with
  | left => exact hx.2 ⟨CycleEntity.right, cycle_right_grounds_left⟩
  | right => exact hx.2 ⟨CycleEntity.left, cycle_left_grounds_right⟩

theorem cycle_common_ground :
    ∀ {x y}, Actual CM x → Actual CM y →
      ∃ z, Actual CM z ∧ GroundAncestor CM z x ∧ GroundAncestor CM z y := by
  intro x y hx hy
  refine ⟨CycleEntity.left, True.intro, ?_, ?_⟩
  · cases x with
    | left => exact cycle_left_ancestor_left
    | right => exact cycle_left_ancestor_right
  · cases y with
    | left => exact cycle_left_ancestor_left
    | right => exact cycle_left_ancestor_right

/-- A2 is genuinely needed: the cycle cannot be well founded. -/
theorem cycle_not_wellFounded :
    ¬ WellFounded (ActualGrounds CM) := by
  intro hWF
  let A : StructuralAxioms CM := {
    actual_nonempty := ⟨CycleEntity.left, True.intro⟩
    grounds_existents := by
      intro w a x h
      exact ⟨True.intro, True.intro⟩
    grounding_wellFounded := hWF
    common_ground := cycle_common_ground
  }
  rcases exists_ungrounded A.toFoundationAxioms with ⟨a, ha⟩
  exact cycle_no_ungrounded a ha

/-! ## A3: two disconnected ungrounded roots

Well-foundedness gives roots but not uniqueness. The common-ground condition is
what excludes disconnected absolute orders.
-/

inductive TwoRootWorld where
  | w
  deriving Repr, DecidableEq

inductive TwoRootEntity where
  | a
  | b
  deriving Repr, DecidableEq

def twoRootModel : Grounding.Model where
  frame := { World := TwoRootWorld, access := fun _ _ => True }
  Entity := TwoRootEntity
  actual := .w
  existsAt := fun _ _ => True
  directGrounds := fun _ _ _ => False
  created := fun _ => False

abbrev TRM := twoRootModel

theorem twoRoot_wellFounded :
    WellFounded (ActualGrounds TRM) := by
  constructor
  intro x
  apply Acc.intro
  intro y hy
  cases y <;> exact False.elim hy

theorem twoRoot_a_ungrounded :
    Ungrounded TRM TwoRootEntity.a := by
  constructor
  · exact True.intro
  · intro hd
    rcases hd with ⟨x, hx⟩
    cases x <;> exact hx

theorem twoRoot_b_ungrounded :
    Ungrounded TRM TwoRootEntity.b := by
  constructor
  · exact True.intro
  · intro hd
    rcases hd with ⟨x, hx⟩
    cases x <;> exact hx

theorem twoRoot_distinct : TwoRootEntity.a ≠ TwoRootEntity.b := by
  intro h
  cases h

theorem twoRoot_no_common_ground :
    ¬ (∃ z, Actual TRM z ∧
      GroundAncestor TRM z TwoRootEntity.a ∧
      GroundAncestor TRM z TwoRootEntity.b) := by
  intro h
  rcases h with ⟨z, hz, hza, hzb⟩
  have hzaEq : z = TwoRootEntity.a :=
    ancestor_eq_of_ungrounded_target twoRoot_a_ungrounded hza
  have hzbEq : z = TwoRootEntity.b :=
    ancestor_eq_of_ungrounded_target twoRoot_b_ungrounded hzb
  exact twoRoot_distinct (hzaEq.symm.trans hzbEq)

/-- A3 fails in the disconnected two-root model. -/
theorem twoRoot_common_ground_fails :
    ¬ (∀ {x y}, Actual TRM x → Actual TRM y →
      ∃ z, Actual TRM z ∧ GroundAncestor TRM z x ∧ GroundAncestor TRM z y) := by
  intro hCommon
  apply twoRoot_no_common_ground
  exact hCommon twoRoot_a_ungrounded.1 twoRoot_b_ungrounded.1

/-! ## A4: an ungrounded contingent brute fact

A0-A3 and actual reflexivity can hold while the unique root is contingent. A4
is exactly what rules this out.
-/

inductive BruteWorld where
  | actual
  | absent
  deriving Repr, DecidableEq

inductive BruteEntity where
  | brute
  deriving Repr, DecidableEq

def bruteModel : Grounding.Model where
  frame := { World := BruteWorld, access := fun _ _ => True }
  Entity := BruteEntity
  actual := .actual
  existsAt := fun w _ =>
    match w with
    | .actual => True
    | .absent => False
  directGrounds := fun _ _ _ => False
  created := fun _ => False

abbrev BM := bruteModel

theorem brute_wellFounded :
    WellFounded (ActualGrounds BM) := by
  constructor
  intro x
  apply Acc.intro
  intro y hy
  cases y
  exact False.elim hy

def bruteStructuralAxioms : StructuralAxioms BM where
  actual_nonempty := ⟨BruteEntity.brute, True.intro⟩
  grounds_existents := by
    intro w a x h
    exact False.elim h
  grounding_wellFounded := brute_wellFounded
  common_ground := by
    intro x y hx hy
    cases x
    cases y
    exact ⟨BruteEntity.brute, True.intro,
      GroundAncestor.refl (M := BM) BruteEntity.brute,
      GroundAncestor.refl (M := BM) BruteEntity.brute⟩

theorem brute_ungrounded :
    Ungrounded BM BruteEntity.brute := by
  constructor
  · exact True.intro
  · intro hd
    rcases hd with ⟨x, hx⟩
    cases x
    exact hx

theorem brute_contingent :
    Contingent BM BruteEntity.brute := by
  constructor
  · exact ⟨BruteWorld.actual, True.intro, True.intro⟩
  · exact ⟨BruteWorld.absent, True.intro, by intro h; exact h⟩

theorem brute_not_necessary :
    ¬ Necessary BM BruteEntity.brute := by
  intro hNec
  exact hNec BruteWorld.absent True.intro

/-- A4 fails: the actual contingent brute has no ground. -/
theorem brute_A4_fails :
    ¬ (∀ x, Actual BM x → Contingent BM x → Derived BM x) := by
  intro hA4
  have hd := hA4 BruteEntity.brute brute_ungrounded.1 brute_contingent
  exact brute_ungrounded.2 hd

/-! ## A6: a root marked as created

A0-A5 alone do not force transcendence of the created order. A6 supplies that
bridge by requiring created actual entities to be derived.
-/

inductive CreatedRootWorld where
  | w
  deriving Repr, DecidableEq

inductive CreatedRootEntity where
  | root
  deriving Repr, DecidableEq

def createdRootModel : Grounding.Model where
  frame := { World := CreatedRootWorld, access := fun _ _ => True }
  Entity := CreatedRootEntity
  actual := .w
  existsAt := fun _ _ => True
  directGrounds := fun _ _ _ => False
  created := fun _ => True

abbrev CRM := createdRootModel

theorem createdRoot_wellFounded :
    WellFounded (ActualGrounds CRM) := by
  constructor
  intro x
  apply Acc.intro
  intro y hy
  cases y
  exact False.elim hy

theorem createdRoot_ungrounded :
    Ungrounded CRM CreatedRootEntity.root := by
  constructor
  · exact True.intro
  · intro hd
    rcases hd with ⟨x, hx⟩
    cases x
    exact hx

def createdRootNecessaryAxioms : NecessaryGroundAxioms CRM where
  actual_nonempty := ⟨CreatedRootEntity.root, True.intro⟩
  grounds_existents := by
    intro w a x h
    exact False.elim h
  grounding_wellFounded := createdRoot_wellFounded
  common_ground := by
    intro x y hx hy
    cases x
    cases y
    exact ⟨CreatedRootEntity.root, True.intro,
      GroundAncestor.refl (M := CRM) CreatedRootEntity.root,
      GroundAncestor.refl (M := CRM) CreatedRootEntity.root⟩
  contingent_is_derived := by
    intro x hx hCont
    exfalso
    rcases hCont.2 with ⟨w, _, hNot⟩
    cases w
    exact hNot True.intro
  actual_reflexive := True.intro

theorem createdRoot_is_created :
    CRM.created CreatedRootEntity.root := True.intro

/-- A6 fails in a model satisfying A0-A5. -/
theorem createdRoot_A6_fails :
    ¬ (∀ x, Actual CRM x → CRM.created x → Derived CRM x) := by
  intro hA6
  have hd := hA6 CreatedRootEntity.root createdRoot_ungrounded.1 createdRoot_is_created
  exact createdRoot_ungrounded.2 hd

/-! ## A8: necessary existence with accidental actual aseity

A0-A7 can hold while the absolute ground is ungrounded only at the actual
world. At another accessible world it can itself be grounded. A8 excludes this.
-/

inductive AccidentalWorld where
  | actual
  | other
  deriving Repr, DecidableEq

inductive AccidentalEntity where
  | ground
  | creature
  deriving Repr, DecidableEq

def accidentalModel : Grounding.Model where
  frame := { World := AccidentalWorld, access := fun _ _ => True }
  Entity := AccidentalEntity
  actual := .actual
  existsAt := fun _ _ => True
  directGrounds := fun w a x =>
    match w, a, x with
    | .actual, .ground, .creature => True
    | .other, .creature, .ground => True
    | _, _, _ => False
  created := fun x =>
    match x with
    | .ground => False
    | .creature => True

abbrev AM := accidentalModel

theorem accidental_ground_grounds_creature :
    ActualGrounds AM AccidentalEntity.ground AccidentalEntity.creature :=
  True.intro

theorem accidental_ground_ancestor_creature :
    GroundAncestor AM AccidentalEntity.ground AccidentalEntity.creature :=
  GroundAncestor.extend
    (GroundAncestor.refl (M := AM) AccidentalEntity.ground)
    accidental_ground_grounds_creature

theorem accidental_wellFounded :
    WellFounded (ActualGrounds AM) := by
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
      | creature => exact False.elim hy

def accidentalCreationAxioms : CreationAxioms AM where
  actual_nonempty := ⟨AccidentalEntity.ground, True.intro⟩
  grounds_existents := by
    intro w a x h
    exact ⟨True.intro, True.intro⟩
  grounding_wellFounded := accidental_wellFounded
  common_ground := by
    intro x y hx hy
    refine ⟨AccidentalEntity.ground, True.intro, ?_, ?_⟩
    · cases x with
      | ground => exact GroundAncestor.refl (M := AM) AccidentalEntity.ground
      | creature => exact accidental_ground_ancestor_creature
    · cases y with
      | ground => exact GroundAncestor.refl (M := AM) AccidentalEntity.ground
      | creature => exact accidental_ground_ancestor_creature
  contingent_is_derived := by
    intro x hx hCont
    exfalso
    rcases hCont.2 with ⟨w, _, hNot⟩
    cases x <;> cases w <;> exact hNot True.intro
  actual_reflexive := True.intro
  created_is_derived := by
    intro x hx hCreated
    cases x with
    | ground => exact False.elim hCreated
    | creature =>
        exact ⟨AccidentalEntity.ground, accidental_ground_grounds_creature⟩
  created_nonempty := ⟨AccidentalEntity.creature, True.intro, True.intro⟩

theorem accidental_ground_ungrounded :
    Ungrounded AM AccidentalEntity.ground := by
  constructor
  · exact True.intro
  · intro hd
    rcases hd with ⟨x, hx⟩
    cases x <;> exact hx

theorem accidental_ground_absolute :
    AbsoluteGround AM AccidentalEntity.ground := by
  constructor
  · exact accidental_ground_ungrounded
  constructor
  · intro w _
    cases w <;> exact True.intro
  constructor
  · intro h
    exact h
  · intro x hx
    cases x with
    | ground => exact GroundAncestor.refl (M := AM) AccidentalEntity.ground
    | creature => exact accidental_ground_ancestor_creature

theorem accidental_ground_not_necessarilyAseitic :
    ¬ NecessarilyAseitic AM AccidentalEntity.ground := by
  intro hAseitic
  have hu := hAseitic AccidentalWorld.other True.intro
  exact hu.2 ⟨AccidentalEntity.creature, True.intro⟩

/-- A8 itself fails while A0-A7 hold. -/
theorem accidental_A8_fails :
    ¬ (∀ x, Ungrounded AM x →
      box AM.frame
        (fun w => AM.existsAt w x → ¬ DerivedAt AM w x)
        AM.actual) := by
  intro hA8
  have h := hA8 AccidentalEntity.ground accidental_ground_ungrounded
  have hOther := h AccidentalWorld.other True.intro True.intro
  exact hOther ⟨AccidentalEntity.creature, True.intro⟩

end Independence
end GroundingModels
end Logos
