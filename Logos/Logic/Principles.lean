import Logos.Logic.Modal

universe u

namespace Logos

/-- Modal principle T: necessity implies actuality. -/
def principleT (F : Frame.{u}) (φ : Formula F) : Formula F :=
  mImp F (box F φ) φ

/-- Modal principle B: actuality implies necessary possibility. -/
def principleB (F : Frame.{u}) (φ : Formula F) : Formula F :=
  mImp F φ (box F (diamond F φ))

/-- Modal principle 4: necessity implies necessary necessity. -/
def principle4 (F : Frame.{u}) (φ : Formula F) : Formula F :=
  mImp F (box F φ) (box F (box F φ))

/-- Modal principle 5: possibility implies necessary possibility. -/
def principle5 (F : Frame.{u}) (φ : Formula F) : Formula F :=
  mImp F (diamond F φ) (box F (diamond F φ))

end Logos
