import Logos.Logic.Modal

universe u

namespace Logos

/-- Every world accesses itself. -/
def Reflexive (F : Frame.{u}) : Prop :=
  ∀ w, F.access w w

/-- Accessibility is symmetric. -/
def Symmetric (F : Frame.{u}) : Prop :=
  ∀ ⦃w v⦄, F.access w v → F.access v w

/-- Accessibility is transitive. -/
def Transitive (F : Frame.{u}) : Prop :=
  ∀ ⦃w v x⦄, F.access w v → F.access v x → F.access w x

/-- Every world accesses at least one world. -/
def Serial (F : Frame.{u}) : Prop :=
  ∀ w, ∃ v, F.access w v

/-- Worlds accessible from the same source access one another in the directed Euclidean sense. -/
def Euclidean (F : Frame.{u}) : Prop :=
  ∀ ⦃w v x⦄, F.access w v → F.access w x → F.access v x

/-- The frame conditions usually associated with S5. -/
def EquivalenceFrame (F : Frame.{u}) : Prop :=
  Reflexive F ∧ Symmetric F ∧ Transitive F

/-- Principle T requires reflexivity. -/
theorem valid_T (F : Frame.{u}) (hRefl : Reflexive F) (φ : Formula F) :
    Valid F (mImp F (box F φ) φ) := by
  intro w hBox
  exact hBox w (hRefl w)

/-- Principle B requires symmetry. -/
theorem valid_B (F : Frame.{u}) (hSymm : Symmetric F) (φ : Formula F) :
    Valid F (mImp F φ (box F (diamond F φ))) := by
  intro w hφ v hwv
  exact ⟨w, hSymm hwv, hφ⟩

/-- Principle 4 requires transitivity. -/
theorem valid_4 (F : Frame.{u}) (hTrans : Transitive F) (φ : Formula F) :
    Valid F (mImp F (box F φ) (box F (box F φ))) := by
  intro w hBox v hwv x hvx
  exact hBox x (hTrans hwv hvx)

/-- Principle 5 requires Euclideanness. -/
theorem valid_5 (F : Frame.{u}) (hEucl : Euclidean F) (φ : Formula F) :
    Valid F (mImp F (diamond F φ) (box F (diamond F φ))) := by
  intro w hDia v hwv
  obtain ⟨x, hwx, hφ⟩ := hDia
  exact ⟨x, hEucl hwv hwx, hφ⟩

end Logos
