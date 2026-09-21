/-
Logos / Models / GoedelScott / Independence.lean

SCOTT-COLLAPSE-1, contract section 5.5. One consistency witness and four
independence models, each followed by a non-redundancy theorem that quantifies
over all frames, carriers and designated worlds.

Every independence model satisfies all five axioms except the one it drops,
including A3 and A4, which no theorem of the cut uses.
-/

import Logos.Systems.GoedelScott.Theorems

namespace Logos
namespace GoedelScottModels

open GoedelScott

/-! ## Consistency witness -/

namespace OneWorld

/-- One reflexive world. -/
def frame : Frame.{0} where
  World := Unit
  access := fun _ _ => True

/-- One individual; positive is whatever that individual has. -/
def carrier : Carrier frame Unit where
  dom := fun _ _ => True
  positive := fun φ _ => φ () ()

/-- The full package A1-A5 is satisfiable, so 5.3 is not vacuous. -/
theorem scottAxioms : ScottAxioms carrier where
  positive_neg := fun _ _ => Iff.rfl
  positive_mono := fun _ _ _ hφ hEntails => hEntails () True.intro () True.intro hφ
  positive_necInstantiated := fun _ _ hEssence _ _ => ⟨(), True.intro, hEssence.1⟩
  positive_allPositive := fun _ _ hφ => hφ
  positive_rigid := fun _ _ hφ _ _ => hφ

theorem backAccess : BackAccess frame () :=
  fun _ _ => True.intro

end OneWorld

/-! ## Two worlds -/

/-- The two worlds shared by the independence models. `a` is designated. -/
inductive W2 where
  | a
  | b

theorem b_ne_a : W2.b ≠ W2.a := by
  intro h
  cases h

/-- Two worlds, every world accesses every world. -/
def fullFrame : Frame.{0} where
  World := W2
  access := fun _ _ => True

theorem fullFrame_equivalence : EquivalenceFrame fullFrame :=
  ⟨fun _ => True.intro, fun _ _ _ => True.intro, fun _ _ _ _ _ => True.intro⟩

theorem fullFrame_not_seesOnlyItself : ¬ SeesOnlyItself fullFrame W2.a :=
  fun h => b_ne_a (h W2.b True.intro)

/-! ## NoBackAccess: all of A1-A5 on a reflexive transitive frame -/

namespace NoBackAccess

/-- `a` accesses `a` and `b`; `b` accesses only `b`. -/
def access : W2 → W2 → Prop
  | .b, .a => False
  | _, _ => True

def frame : Frame.{0} where
  World := W2
  access := access

/-- Positive is whatever the one individual has at `b`. -/
def carrier : Carrier frame Unit where
  dom := fun _ _ => True
  positive := fun φ _ => φ () W2.b

theorem reflexive : Reflexive frame := by
  intro w
  cases w <;> exact True.intro

theorem transitive : Transitive frame := by
  intro w v x h₁ h₂
  cases w <;> cases v <;> cases x <;>
    first
      | exact True.intro
      | exact False.elim h₁
      | exact False.elim h₂

theorem accesses_b (w : W2) : frame.access w W2.b := by
  cases w <;> exact True.intro

theorem scottAxioms : ScottAxioms carrier where
  positive_neg := fun _ _ => Iff.rfl
  positive_mono := fun _ _ w hφ hEntails =>
    hEntails W2.b (accesses_b w) () True.intro hφ
  positive_necInstantiated := by
    intro _ φ hEssence v hAccess
    cases v with
    | a => exact False.elim hAccess
    | b => exact ⟨(), True.intro, hEssence.1⟩
  positive_allPositive := fun _ _ hφ => hφ
  positive_rigid := fun _ _ hφ _ _ => hφ

theorem not_backAccess : ¬ BackAccess frame W2.a :=
  fun h => h W2.b True.intro

theorem not_seesOnlyItself : ¬ SeesOnlyItself frame W2.a :=
  fun h => b_ne_a (h W2.b True.intro)

/-- Back-access is strictly weaker than symmetry: it holds at `b` on a frame
that is not symmetric. -/
theorem backAccess_at_b : BackAccess frame W2.b := by
  intro v hAccess
  cases v with
  | a => exact False.elim hAccess
  | b => exact True.intro

theorem not_symmetric : ¬ Symmetric frame :=
  fun h => h (w := W2.a) (v := W2.b) True.intro

end NoBackAccess

/-- Back-access is not redundant: all five axioms on a reflexive and transitive
frame do not force the single-successor frame. -/
theorem backAccess_not_redundant :
    ¬ (∀ (F : Frame.{0}) (Ind : Type) (C : Carrier F Ind) (a : F.World),
        ScottAxioms C → Reflexive F → Transitive F → SeesOnlyItself F a) :=
  fun h =>
    NoBackAccess.not_seesOnlyItself
      (h _ _ NoBackAccess.carrier W2.a
        NoBackAccess.scottAxioms NoBackAccess.reflexive NoBackAccess.transitive)

/-! ## DropA5: A1-A4 on an equivalence frame -/

namespace DropA5

/-- Positive is whatever the one individual has at `a`. -/
def carrier : Carrier fullFrame Unit where
  dom := fun _ _ => True
  positive := fun φ _ => φ () W2.a

theorem positiveNeg : PositiveNeg carrier :=
  fun _ _ => Iff.rfl

theorem positiveMono : PositiveMono carrier :=
  fun _ _ _ hφ hEntails => hEntails W2.a True.intro () True.intro hφ

theorem positiveAllPositive : PositiveAllPositive carrier :=
  fun _ _ hφ => hφ

theorem positiveRigid : PositiveRigid carrier :=
  fun _ _ hφ _ _ => hφ

theorem not_positiveNecInstantiated : ¬ PositiveNecInstantiated carrier :=
  fun h =>
    b_ne_a (seesOnlyItself_of_necInstantiated (C := carrier) (h W2.a) W2.b True.intro)

end DropA5

/-- A5 is not redundant. -/
theorem positiveNecInstantiated_not_redundant :
    ¬ (∀ (F : Frame.{0}) (Ind : Type) (C : Carrier F Ind) (a : F.World),
        PositiveNeg C → PositiveMono C → PositiveAllPositive C → PositiveRigid C →
        EquivalenceFrame F → SeesOnlyItself F a) :=
  fun h =>
    fullFrame_not_seesOnlyItself
      (h _ _ DropA5.carrier W2.a DropA5.positiveNeg DropA5.positiveMono
        DropA5.positiveAllPositive DropA5.positiveRigid fullFrame_equivalence)

/-! ## DropA1: A2-A5 on an equivalence frame -/

namespace DropA1

/-- Everything is positive. -/
def carrier : Carrier fullFrame Unit where
  dom := fun _ _ => True
  positive := fun _ _ => True

theorem positiveMono : PositiveMono carrier :=
  fun _ _ _ _ _ => True.intro

theorem positiveAllPositive : PositiveAllPositive carrier :=
  fun _ => True.intro

theorem positiveRigid : PositiveRigid carrier :=
  fun _ _ _ _ _ => True.intro

theorem positiveNecInstantiated : PositiveNecInstantiated carrier :=
  fun _ => True.intro

theorem not_positiveNeg : ¬ PositiveNeg carrier :=
  fun h => (h (fun _ _ => True) W2.a).1 True.intro True.intro

end DropA1

/-- A1 is not redundant. -/
theorem positiveNeg_not_redundant :
    ¬ (∀ (F : Frame.{0}) (Ind : Type) (C : Carrier F Ind) (a : F.World),
        PositiveMono C → PositiveAllPositive C → PositiveRigid C →
        PositiveNecInstantiated C → EquivalenceFrame F → SeesOnlyItself F a) :=
  fun h =>
    fullFrame_not_seesOnlyItself
      (h _ _ DropA1.carrier W2.a DropA1.positiveMono DropA1.positiveAllPositive
        DropA1.positiveRigid DropA1.positiveNecInstantiated fullFrame_equivalence)

/-! ## DropA2: A1, A3, A4, A5 on an equivalence frame -/

namespace DropA2

/-- Positive is whatever the one individual lacks at `a`. -/
def carrier : Carrier fullFrame Unit where
  dom := fun _ _ => True
  positive := fun φ _ => ¬ φ () W2.a

theorem positiveNeg : PositiveNeg carrier :=
  fun _ _ => Iff.rfl

theorem positiveAllPositive : PositiveAllPositive carrier :=
  fun _ hAll => hAll (fun _ _ => False) (fun hFalse => hFalse)

theorem positiveRigid : PositiveRigid carrier :=
  fun _ _ hφ _ _ => hφ

theorem positiveNecInstantiated : PositiveNecInstantiated carrier :=
  fun _ hNec =>
    b_ne_a (seesOnlyItself_of_necInstantiated (C := carrier) hNec W2.b True.intro)

theorem not_positiveMono : ¬ PositiveMono carrier :=
  fun h =>
    h (fun _ _ => False) (fun _ _ => True) W2.a
      (fun hFalse => hFalse) (fun _ _ _ _ hFalse => False.elim hFalse) True.intro

end DropA2

/-- A2 is not redundant. -/
theorem positiveMono_not_redundant :
    ¬ (∀ (F : Frame.{0}) (Ind : Type) (C : Carrier F Ind) (a : F.World),
        PositiveNeg C → PositiveAllPositive C → PositiveRigid C →
        PositiveNecInstantiated C → EquivalenceFrame F → SeesOnlyItself F a) :=
  fun h =>
    fullFrame_not_seesOnlyItself
      (h _ _ DropA2.carrier W2.a DropA2.positiveNeg DropA2.positiveAllPositive
        DropA2.positiveRigid DropA2.positiveNecInstantiated fullFrame_equivalence)

end GoedelScottModels
end Logos
