/-
Logos / Models / Seam / ScottGrounding.lean

SCOTT-COLLAPSE-1, contract sections 5.6 and 5.7. Where Scott's axiom package
sits on the map drawn by `totality-constitution-1`.

This is the only module that mentions both the GoedelScott line and the
grounding line. It must stay a leaf: nothing may import it.

It states its result through `ContingencyWitness` and `SingleSuccessor`, so it
imports the totality constitution modules. It does not use the constitution
law: no statement about the totality fact is made here, and a static guard
rejects the law's names in this file.

Every theorem of 5.6 is stated for an arbitrary carrier over the model's frame
and entities, so nothing depends on how `dom` represents existence.
-/

import Logos.Systems.GoedelScott.Theorems
import Logos.Systems.TotalityConstitution.Theorems

namespace Logos.Models.Seam.ScottGrounding

open Logos Logos.Grounding Logos.GoedelScott

universe u v

/-! ## 5.6 The seam -/

section Seam

variable {M : Model.{u, v}} {C : Carrier M.frame M.Entity}

/-- Scott's core package with back-access at the actual world forces the frame
on which `Necessary` coincides with `Actual`. -/
theorem singleSuccessor_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual) :
    SingleSuccessor M :=
  (seesOnlyItself_of_scottCore A hBack).1

/-- `A5` of the grounding line is a conclusion here, not a hypothesis. -/
theorem actual_reflexive_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual) :
    M.frame.access M.actual M.actual :=
  (seesOnlyItself_of_scottCore A hBack).2

/-- The package denies `W`. -/
theorem not_contingencyWitness_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual) :
    ¬ ContingencyWitness M :=
  fun hW =>
    not_singleSuccessor_of_contingencyWitness hW (singleSuccessor_of_scottCore A hBack)

theorem necessary_iff_actual_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual) (x : M.Entity) :
    Necessary M x ↔ Actual M x :=
  necessary_iff_actual_of_singleSuccessor
    (singleSuccessor_of_scottCore A hBack) (actual_reflexive_of_scottCore A hBack) x

/-- `A4` of the grounding line is vacuous under the package. -/
theorem necessaryExistenceAxioms_of_foundation_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual)
    (hFoundation : FoundationAxioms M) :
    NecessaryExistenceAxioms M :=
  necessaryExistenceAxioms_of_foundation_of_singleSuccessor
    (singleSuccessor_of_scottCore A hBack) (actual_reflexive_of_scottCore A hBack)
    hFoundation

/-- The modal conjunct of the central theorem is free under the package. -/
theorem exists_necessary_ungrounded_iff_exists_ungrounded_of_scottCore
    (A : ScottCoreAxioms C) (hBack : BackAccess M.frame M.actual) :
    (∃ a, Ungrounded M a ∧ Necessary M a) ↔ ∃ a, Ungrounded M a :=
  exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor
    (singleSuccessor_of_scottCore A hBack) (actual_reflexive_of_scottCore A hBack)

end Seam

/-! ## 5.7 The package says nothing about grounding position -/

/-- Two entities: a root and what it grounds. -/
inductive Node where
  | root
  | leaf

/-- The only grounding edge is `root -> leaf`. -/
def directGrounds : Unit → Node → Node → Prop
  | _, .root, .leaf => True
  | _, _, _ => False

/-- One reflexive world, two entities, both existing. -/
def model : Grounding.Model where
  frame := {
    World := Unit
    access := fun _ _ => True
  }
  Entity := Node
  actual := ()
  existsAt := fun _ _ => True
  directGrounds := directGrounds
  created := fun _ => False

theorem grounding_wellFounded : WellFounded (ActualGrounds model) := by
  constructor
  intro x
  cases x with
  | root =>
      apply Acc.intro
      intro y hy
      cases y <;> exact False.elim hy
  | leaf =>
      apply Acc.intro
      intro y hy
      cases y with
      | root =>
          apply Acc.intro
          intro z hz
          cases z <;> exact False.elim hz
      | leaf =>
          exact False.elim hy

/-- The grounding side satisfies the foundation package of `absolute-ground-1`. -/
theorem necessaryExistenceAxioms : NecessaryExistenceAxioms model where
  actual_nonempty := ⟨Node.root, True.intro⟩
  grounds_existents := fun _ => ⟨True.intro, True.intro⟩
  grounding_wellFounded := grounding_wellFounded
  contingent_is_derived := by
    intro _ _ hContingent
    obtain ⟨_, _, hNot⟩ := hContingent.2
    exact False.elim (hNot True.intro)
  actual_reflexive := True.intro

theorem backAccess : BackAccess model.frame model.actual :=
  fun _ _ => True.intro

theorem root_ungrounded : Ungrounded model Node.root := by
  refine ⟨True.intro, ?_⟩
  rintro ⟨a, ha⟩
  cases a <;> exact False.elim ha

theorem leaf_derived : Derived model Node.leaf :=
  ⟨Node.root, True.intro⟩

/-- A carrier over the grounding model whose positive properties are those of
one chosen entity. Quantification is actualist: `dom` is `existsAt`. -/
def carrierAt (chosen : Node) : Carrier model.frame model.Entity where
  dom := model.existsAt
  positive := fun φ w => φ chosen w

/-- Whichever entity is chosen, the full package A1-A5 holds. -/
theorem scottAxioms_carrierAt (chosen : Node) : ScottAxioms (carrierAt chosen) where
  positive_neg := fun _ _ => Iff.rfl
  positive_mono := fun _ _ w hφ hEntails => hEntails w True.intro chosen True.intro hφ
  positive_necInstantiated := fun _ _ hEssence _ _ => ⟨chosen, True.intro, hEssence.1⟩
  positive_allPositive := fun _ _ hφ => hφ
  positive_rigid := fun _ _ hφ _ _ => hφ

theorem allPositive_chosen (chosen : Node) :
    AllPositive (carrierAt chosen) chosen model.actual :=
  fun _ hφ => hφ

/-- RootCarrier: the union of the two premise packages is consistent, and the
all-positive individual is ungrounded. -/
theorem rootCarrier_joint :
    NecessaryExistenceAxioms model ∧ ScottAxioms (carrierAt Node.root) ∧
      BackAccess model.frame model.actual ∧
      AllPositive (carrierAt Node.root) Node.root model.actual ∧
      Ungrounded model Node.root :=
  ⟨necessaryExistenceAxioms, scottAxioms_carrierAt Node.root, backAccess,
    allPositive_chosen Node.root, root_ungrounded⟩

/-- LeafCarrier: over the same grounding model, the all-positive individual is
derived, and the root is not all-positive. -/
theorem leafCarrier_joint :
    NecessaryExistenceAxioms model ∧ ScottAxioms (carrierAt Node.leaf) ∧
      BackAccess model.frame model.actual ∧
      AllPositive (carrierAt Node.leaf) Node.leaf model.actual ∧
      Derived model Node.leaf ∧
      ¬ AllPositive (carrierAt Node.leaf) Node.root model.actual := by
  refine ⟨necessaryExistenceAxioms, scottAxioms_carrierAt Node.leaf, backAccess,
    allPositive_chosen Node.leaf, leaf_derived, ?_⟩
  intro hAll
  have hEq : Node.root = Node.leaf := hAll (fun y _ => y = Node.leaf) rfl
  cases hEq

end Logos.Models.Seam.ScottGrounding
