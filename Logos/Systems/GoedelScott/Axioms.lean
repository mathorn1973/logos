/-
Logos / Systems / GoedelScott / Axioms.lean

SCOTT-COLLAPSE-1. Scott's five axioms as explicit assumption records. Each is
asserted valid, that is, at every world. Source labels are those of
SCOTT-COLLAPSE-CONTRACT.md section 4.

The records are premises passed to theorems. They are not global axioms and
nothing here establishes them.
-/

import Logos.Ontology.GoedelScott.Language

universe u v

namespace Logos
namespace GoedelScott

variable {F : Frame.{u}} {Ind : Type v}

/-- A1: of a property and its negation exactly one is positive. -/
def PositiveNeg (C : Carrier F Ind) : Prop :=
  ∀ (φ : Property F Ind) (w : F.World), C.positive (pNot φ) w ↔ ¬ C.positive φ w

/-- A2: what a positive property necessarily entails is positive. -/
def PositiveMono (C : Carrier F Ind) : Prop :=
  ∀ (φ ψ : Property F Ind) (w : F.World),
    C.positive φ w → NecEntails C φ ψ w → C.positive ψ w

/-- A3: having every positive property is positive. -/
def PositiveAllPositive (C : Carrier F Ind) : Prop :=
  ∀ w : F.World, C.positive (AllPositive C) w

/-- A4: positivity is rigid along accessibility. -/
def PositiveRigid (C : Carrier F Ind) : Prop :=
  ∀ (φ : Property F Ind) (w : F.World),
    C.positive φ w → ∀ v, F.access w v → C.positive φ v

/-- A5: D3 is positive. -/
def PositiveNecInstantiated (C : Carrier F Ind) : Prop :=
  ∀ w : F.World, C.positive (NecInstantiated C) w

/-- A1, A2 and A5. The record the frame collapse is stated against. -/
structure ScottCoreAxioms (C : Carrier F Ind) : Prop where
  positive_neg : PositiveNeg C
  positive_mono : PositiveMono C
  positive_necInstantiated : PositiveNecInstantiated C

/-- The full package A1-A5. -/
structure ScottAxioms (C : Carrier F Ind) : Prop extends ScottCoreAxioms C where
  positive_allPositive : PositiveAllPositive C
  positive_rigid : PositiveRigid C

end GoedelScott
end Logos
