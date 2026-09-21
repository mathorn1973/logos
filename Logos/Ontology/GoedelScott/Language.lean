/-
Logos / Ontology / GoedelScott / Language.lean

SCOTT-COLLAPSE-1. The language of Scott's version of the ontological argument,
stated over a LOGOS frame.

This line imports the logic layer and nothing else. It shares no carrier with
the grounding line or with the semantic self-reference line.

Property variables range over every function `Ind → F.World → Prop`, including
functions that mention a particular world. That is full comprehension. It is a
commitment, and it is the commitment the cut turns on; see
SCOTT-COLLAPSE-CONTRACT.md sections 3 and 7.

Names are structural. `AllPositive` is definition D1 of the source and
`NecInstantiated` is D3. No theorem uses any reading of either.
-/

import Logos.Logic.FrameConditions

universe u v

namespace Logos
namespace GoedelScott

/-- An intensional property of individuals: its extension may vary by world. -/
abbrev Property (F : Frame.{u}) (Ind : Type v) := Ind → F.World → Prop

/-- The carrier of the line: a domain of individual quantification at each
world, and a primitive, uninterpreted positivity predicate on properties.

`dom` constantly true is possibilist quantification. Over a grounding model,
`dom := M.existsAt` is actualist quantification. -/
structure Carrier (F : Frame.{u}) (Ind : Type v) where
  dom : F.World → Ind → Prop
  positive : Property F Ind → F.World → Prop

variable {F : Frame.{u}} {Ind : Type v}

/-- Pointwise negation of a property. -/
def pNot (φ : Property F Ind) : Property F Ind :=
  fun x w => ¬ φ x w

/-- `φ` necessarily entails `ψ` at `w`, over the domain of each accessible world. -/
def NecEntails (C : Carrier F Ind) (φ ψ : Property F Ind) (w : F.World) : Prop :=
  ∀ v, F.access w v → ∀ x, C.dom v x → φ x v → ψ x v

/-- D1: having every positive property. -/
def AllPositive (C : Carrier F Ind) : Property F Ind :=
  fun x w => ∀ φ, C.positive φ w → φ x w

/-- D2, with Scott's conjunct: `φ` is an essence of `x` at `w` when `x` has it
and it necessarily entails every property `x` has. -/
def Essence (C : Carrier F Ind) (φ : Property F Ind) (x : Ind) (w : F.World) : Prop :=
  φ x w ∧ ∀ ψ : Property F Ind, ψ x w → NecEntails C φ ψ w

/-- D3: every essence of `x` is instantiated at every accessible world. -/
def NecInstantiated (C : Carrier F Ind) : Property F Ind :=
  fun x w => ∀ φ, Essence C φ x w → ∀ v, F.access w v → ∃ y, C.dom v y ∧ φ y v

/-- The world accesses nothing but itself. Over a grounding model at the actual
world this is `SingleSuccessor`. -/
def SeesOnlyItself (F : Frame.{u}) (w : F.World) : Prop :=
  ∀ v, F.access w v → v = w

/-- Symmetry at one world: whatever `w` accesses accesses it back. -/
def BackAccess (F : Frame.{u}) (w : F.World) : Prop :=
  ∀ v, F.access w v → F.access v w

/-- Global symmetry gives back-access at every world. The converse fails. -/
theorem backAccess_of_symmetric (hSymm : Symmetric F) (w : F.World) :
    BackAccess F w :=
  fun _ hAccess => hSymm hAccess

end GoedelScott
end Logos
