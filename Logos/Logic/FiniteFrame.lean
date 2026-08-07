import Logos.Logic.Frame

universe u

namespace Logos

/-- A Kripke frame equipped with an explicit exhaustive list of worlds.

The list is evidence used by the laboratory and by human review. Modal truth
continues to be interpreted through `toFrame`; enumeration itself adds no
accessibility edge and no logical axiom.
-/
structure FiniteFrame where
  World : Type u
  access : World → World → Prop
  worlds : List World
  complete : ∀ w, List.Mem w worlds

namespace FiniteFrame

/-- Forget the enumeration and retain the underlying Kripke frame. -/
def toFrame (F : FiniteFrame.{u}) : Frame.{u} where
  World := F.World
  access := F.access

end FiniteFrame

/-- A formula is refuted at a designated world when it is false there. -/
def RefutesAt (F : Frame.{u}) (φ : Formula F) (w : F.World) : Prop :=
  ¬ φ w

/-- Pointed refutation data for a formula on a fixed frame. -/
structure PointedCountermodel (F : Frame.{u}) (φ : Formula F) where
  world : F.World
  refutes : RefutesAt F φ world

/-- Any pointed refutation witnesses failure of global validity. -/
theorem not_valid_of_pointed
    (F : Frame.{u}) (φ : Formula F) (C : PointedCountermodel F φ) :
    ¬ Valid F φ := by
  intro hValid
  exact C.refutes (hValid C.world)

end Logos
