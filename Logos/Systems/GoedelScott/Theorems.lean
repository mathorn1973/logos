/-
Logos / Systems / GoedelScott / Theorems.lean

SCOTT-COLLAPSE-1. Section numbers refer to SCOTT-COLLAPSE-CONTRACT.md.

The route to the frame collapse goes through D3 alone. D1, A3 and A4 are not
used until T3, and A4 is not used at all.
-/

import Logos.Systems.GoedelScott.Axioms

universe u v

namespace Logos
namespace GoedelScott

variable {F : Frame.{u}} {Ind : Type v}

/-! ## 5.1 D3 is a frame condition -/

/-- Being `x` at `w`. Under full comprehension this is a property like any other. -/
def haecceity (x : Ind) (w : F.World) : Property F Ind :=
  fun y v => y = x ∧ v = w

/-- The haecceity of `x` at `w` is an essence of `x` at `w`, for every carrier. -/
theorem essence_haecceity (C : Carrier F Ind) (x : Ind) (w : F.World) :
    Essence C (haecceity x w) x w := by
  refine ⟨⟨rfl, rfl⟩, ?_⟩
  intro ψ hψ v _ y _ hy
  obtain ⟨hyx, hvw⟩ := hy
  subst hyx
  subst hvw
  exact hψ

/-- No axiom record among the hypotheses: D3 holds of `x` at `w` exactly when
`w` accesses nothing but itself and, if it accesses anything, `x` is in its
domain. -/
theorem necInstantiated_iff (C : Carrier F Ind) (x : Ind) (w : F.World) :
    NecInstantiated C x w ↔ ∀ v, F.access w v → v = w ∧ C.dom w x := by
  constructor
  · intro hNec v hAccess
    obtain ⟨y, hDom, hyx, hvw⟩ := hNec (haecceity x w) (essence_haecceity C x w) v hAccess
    subst hyx
    subst hvw
    exact ⟨rfl, hDom⟩
  · intro hFrame φ hEssence v hAccess
    obtain ⟨hvw, hDom⟩ := hFrame v hAccess
    subst hvw
    exact ⟨x, hDom, hEssence.1⟩

/-- Corollary of 5.1. -/
theorem seesOnlyItself_of_necInstantiated {C : Carrier F Ind} {x : Ind} {w : F.World}
    (hNec : NecInstantiated C x w) :
    SeesOnlyItself F w :=
  fun v hAccess => ((necInstantiated_iff C x w).1 hNec v hAccess).1

/-! ## 5.2 T1 from A1 and A2 -/

/-- T1: a positive property is possibly exemplified. Classical: the argument
refutes the absence of a witness and then needs the witness. -/
theorem possibly_exemplified {C : Carrier F Ind}
    (hNeg : PositiveNeg C) (hMono : PositiveMono C)
    {φ : Property F Ind} {w : F.World} (hPos : C.positive φ w) :
    ∃ v, F.access w v ∧ ∃ x, C.dom v x ∧ φ x v := by
  apply Classical.byContradiction
  intro hNone
  have hEntails : NecEntails C φ (pNot φ) w :=
    fun v hAccess x hDom hφ => (hNone ⟨v, hAccess, x, hDom, hφ⟩).elim
  exact (hNeg φ w).1 (hMono φ (pNot φ) w hPos hEntails) hPos

/-! ## 5.3 The core package forces the single-successor frame -/

/-- A1, A2 and A5 with back-access at `a` force `a` to access itself and
nothing else. A3 and A4 are not available to this proof. -/
theorem seesOnlyItself_of_scottCore {C : Carrier F Ind} {a : F.World}
    (A : ScottCoreAxioms C) (hBack : BackAccess F a) :
    SeesOnlyItself F a ∧ F.access a a := by
  obtain ⟨v, hAccess, x, _, hNec⟩ :=
    possibly_exemplified A.positive_neg A.positive_mono (A.positive_necInstantiated a)
  have hOnly : SeesOnlyItself F v := seesOnlyItself_of_necInstantiated hNec
  have hav : a = v := hOnly a (hBack v hAccess)
  subst hav
  exact ⟨hOnly, hAccess⟩

/-! ## 5.4 What follows on that frame -/

/-- Modal collapse at `a`, as a corollary of 5.3 and not a separate argument. -/
theorem collapse {C : Carrier F Ind} {a : F.World}
    (A : ScottCoreAxioms C) (hBack : BackAccess F a)
    (p : Formula F) (hp : p a) :
    box F p a := by
  intro v hAccess
  have hva : v = a := (seesOnlyItself_of_scottCore A hBack).1 v hAccess
  subst hva
  exact hp

/-- On the forced frame the box adds nothing to the plain existential. No A3. -/
theorem necessarily_allPositive_iff_actually {C : Carrier F Ind} {a : F.World}
    (A : ScottCoreAxioms C) (hBack : BackAccess F a) :
    box F (fun v => ∃ x, C.dom v x ∧ AllPositive C x v) a ↔
      ∃ x, C.dom a x ∧ AllPositive C x a := by
  have hFrame := seesOnlyItself_of_scottCore A hBack
  constructor
  · intro hBox
    exact hBox a hFrame.2
  · intro hActual
    exact collapse A hBack (fun v => ∃ x, C.dom v x ∧ AllPositive C x v) hActual

/-- T3, with A3 as a separate hypothesis so that A4 is visibly absent. -/
theorem necessarily_allPositive {C : Carrier F Ind} {a : F.World}
    (A : ScottCoreAxioms C) (hAll : PositiveAllPositive C) (hBack : BackAccess F a) :
    box F (fun v => ∃ x, C.dom v x ∧ AllPositive C x v) a := by
  have hFrame := seesOnlyItself_of_scottCore A hBack
  obtain ⟨v, hAccess, x, hDom, hx⟩ :=
    possibly_exemplified A.positive_neg A.positive_mono (hAll a)
  have hva : v = a := hFrame.1 v hAccess
  subst hva
  exact (necessarily_allPositive_iff_actually A hBack).2 ⟨x, hDom, hx⟩

end GoedelScott
end Logos
