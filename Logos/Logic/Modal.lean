import Logos.Logic.Frame

universe u

namespace Logos

/-- Truth at every world. -/
def mTop (F : Frame.{u}) : Formula F :=
  fun _ => True

/-- Falsehood at every world. -/
def mBot (F : Frame.{u}) : Formula F :=
  fun _ => False

/-- Pointwise negation. -/
def mNot (F : Frame.{u}) (φ : Formula F) : Formula F :=
  fun w => ¬ φ w

/-- Pointwise conjunction. -/
def mAnd (F : Frame.{u}) (φ ψ : Formula F) : Formula F :=
  fun w => φ w ∧ ψ w

/-- Pointwise disjunction. -/
def mOr (F : Frame.{u}) (φ ψ : Formula F) : Formula F :=
  fun w => φ w ∨ ψ w

/-- Pointwise implication. -/
def mImp (F : Frame.{u}) (φ ψ : Formula F) : Formula F :=
  fun w => φ w → ψ w

/-- Necessity relative to the frame accessibility relation. -/
def box (F : Frame.{u}) (φ : Formula F) : Formula F :=
  fun w => ∀ v, F.access w v → φ v

/-- Possibility relative to the frame accessibility relation. -/
def diamond (F : Frame.{u}) (φ : Formula F) : Formula F :=
  fun w => ∃ v, F.access w v ∧ φ v

/-- A proposition is contingent at a world when it and its negation are both possible there. -/
def ContingentAt (F : Frame.{u}) (φ : Formula F) (w : F.World) : Prop :=
  diamond F φ w ∧ diamond F (mNot F φ) w

/-- Necessitation is semantically valid on every frame. -/
theorem valid_box_of_valid (F : Frame.{u}) (φ : Formula F)
    (h : Valid F φ) : Valid F (box F φ) := by
  intro w v _
  exact h v

/-- Distribution axiom K is semantically valid on every frame. -/
theorem valid_K (F : Frame.{u}) (φ ψ : Formula F) :
    Valid F
      (mImp F
        (box F (mImp F φ ψ))
        (mImp F (box F φ) (box F ψ))) := by
  intro w hImp hBox v hwv
  exact hImp v hwv (hBox v hwv)

end Logos
