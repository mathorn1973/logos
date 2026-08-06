import Logos.Logic.FiniteFrame
import Logos.Logic.Principles
import Logos.Logic.FrameConditions

namespace Logos
namespace FiniteCountermodels

/-! ## T: one dead-end world

Necessity is vacuous at the only world because it accesses nothing. A false
proposition is therefore necessary there but not actual there.
-/

inductive DeadEndWorld where
  | only
  deriving Repr, DecidableEq

def deadEndAccess : DeadEndWorld → DeadEndWorld → Prop :=
  fun _ _ => False

def deadEndFinite : FiniteFrame where
  World := DeadEndWorld
  access := deadEndAccess
  worlds := [.only]
  complete := by
    intro w
    cases w
    exact List.Mem.head _

abbrev deadEndFrame : Frame := deadEndFinite.toFrame

def deadEndFalse : Formula deadEndFrame :=
  fun _ => False

theorem deadEnd_not_reflexive : ¬ Reflexive deadEndFrame := by
  intro h
  exact h .only

theorem deadEnd_symmetric : Symmetric deadEndFrame := by
  intro _ _ h
  exact False.elim h

theorem deadEnd_transitive : Transitive deadEndFrame := by
  intro _ _ _ h _
  exact False.elim h

theorem deadEnd_euclidean : Euclidean deadEndFrame := by
  intro _ _ _ h _
  exact False.elim h

theorem deadEnd_not_serial : ¬ Serial deadEndFrame := by
  intro h
  obtain ⟨_, hedge⟩ := h .only
  exact hedge

def deadEnd_T_countermodel :
    PointedCountermodel deadEndFrame (principleT deadEndFrame deadEndFalse) where
  world := .only
  refutes := by
    intro hT
    have hBox : box deadEndFrame deadEndFalse .only := by
      intro _ hedge
      exact False.elim hedge
    exact hT hBox

theorem deadEnd_refutes_T :
    ¬ Valid deadEndFrame (principleT deadEndFrame deadEndFalse) :=
  not_valid_of_pointed deadEndFrame
    (principleT deadEndFrame deadEndFalse) deadEnd_T_countermodel

/-! ## B: a reflexive one-way preorder

The source accesses the target, but the target cannot return to the source.
A proposition true only at the source is actual there, yet not necessarily
possible there.
-/

inductive ArrowWorld where
  | source
  | target
  deriving Repr, DecidableEq

def arrowAccess : ArrowWorld → ArrowWorld → Prop
  | .source, .source => True
  | .source, .target => True
  | .target, .source => False
  | .target, .target => True

def arrowFinite : FiniteFrame where
  World := ArrowWorld
  access := arrowAccess
  worlds := [.source, .target]
  complete := by
    intro w
    cases w with
    | source => exact List.Mem.head _
    | target => exact List.Mem.tail _ (List.Mem.head _)

abbrev arrowFrame : Frame := arrowFinite.toFrame

def sourceOnly : Formula arrowFrame
  | .source => True
  | .target => False

theorem arrow_reflexive : Reflexive arrowFrame := by
  intro w
  cases w <;> trivial

theorem arrow_transitive : Transitive arrowFrame := by
  intro w v x hwv hvx
  cases w with
  | source =>
      cases v with
      | source =>
          cases x with
          | source => exact True.intro
          | target => exact True.intro
      | target =>
          cases x with
          | source => exact False.elim hvx
          | target => exact True.intro
  | target =>
      cases v with
      | source => exact False.elim hwv
      | target =>
          cases x with
          | source => exact False.elim hvx
          | target => exact True.intro

theorem arrow_serial : Serial arrowFrame := by
  intro w
  cases w
  · exact ⟨.source, True.intro⟩
  · exact ⟨.target, True.intro⟩

theorem arrow_not_symmetric : ¬ Symmetric arrowFrame := by
  intro h
  have hback := h (w := ArrowWorld.source) (v := ArrowWorld.target) True.intro
  exact hback

theorem arrow_not_euclidean : ¬ Euclidean arrowFrame := by
  intro h
  have hback := h
    (w := ArrowWorld.source)
    (v := ArrowWorld.target)
    (x := ArrowWorld.source)
    True.intro True.intro
  exact hback

def arrow_B_countermodel :
    PointedCountermodel arrowFrame (principleB arrowFrame sourceOnly) where
  world := .source
  refutes := by
    intro hB
    have hBoxDia := hB True.intro
    have hDiaTarget := hBoxDia .target True.intro
    obtain ⟨u, htu, hφu⟩ := hDiaTarget
    cases u with
    | source => exact htu
    | target => exact hφu

theorem arrow_refutes_B :
    ¬ Valid arrowFrame (principleB arrowFrame sourceOnly) :=
  not_valid_of_pointed arrowFrame
    (principleB arrowFrame sourceOnly) arrow_B_countermodel

/-! ## 4 and 5: a reflexive symmetric three-world path

The path `left — center — right` has all self-loops and both directions on
both displayed edges, but no edge between `left` and `right`. It is reflexive,
symmetric, and serial, while transitivity and Euclideanness fail.
-/

inductive PathWorld where
  | left
  | center
  | right
  deriving Repr, DecidableEq

def pathAccess : PathWorld → PathWorld → Prop
  | .left, .left => True
  | .left, .center => True
  | .left, .right => False
  | .center, .left => True
  | .center, .center => True
  | .center, .right => True
  | .right, .left => False
  | .right, .center => True
  | .right, .right => True

def pathFinite : FiniteFrame where
  World := PathWorld
  access := pathAccess
  worlds := [.left, .center, .right]
  complete := by
    intro w
    cases w with
    | left => exact List.Mem.head _
    | center => exact List.Mem.tail _ (List.Mem.head _)
    | right =>
        exact List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _))

abbrev pathFrame : Frame := pathFinite.toFrame

theorem path_reflexive : Reflexive pathFrame := by
  intro w
  cases w <;> trivial

theorem path_symmetric : Symmetric pathFrame := by
  intro w v hwv
  cases w with
  | left =>
      cases v with
      | left => exact True.intro
      | center => exact True.intro
      | right => exact False.elim hwv
  | center =>
      cases v with
      | left => exact True.intro
      | center => exact True.intro
      | right => exact True.intro
  | right =>
      cases v with
      | left => exact False.elim hwv
      | center => exact True.intro
      | right => exact True.intro

theorem path_serial : Serial pathFrame := by
  intro w
  exact ⟨w, path_reflexive w⟩

theorem path_not_transitive : ¬ Transitive pathFrame := by
  intro h
  have hlr := h
    (w := PathWorld.left)
    (v := PathWorld.center)
    (x := PathWorld.right)
    True.intro True.intro
  exact hlr

theorem path_not_euclidean : ¬ Euclidean pathFrame := by
  intro h
  have hlr := h
    (w := PathWorld.center)
    (v := PathWorld.left)
    (x := PathWorld.right)
    True.intro True.intro
  exact hlr

def nearLeft : Formula pathFrame
  | .left => True
  | .center => True
  | .right => False

def path_4_countermodel :
    PointedCountermodel pathFrame (principle4 pathFrame nearLeft) where
  world := .left
  refutes := by
    intro h4
    have hBox : box pathFrame nearLeft .left := by
      intro v hlv
      cases v with
      | left => exact True.intro
      | center => exact True.intro
      | right => exact False.elim hlv
    have hBoxBox := h4 hBox
    have hBoxAtCenter := hBoxBox .center True.intro
    exact hBoxAtCenter .right True.intro

theorem path_refutes_4 :
    ¬ Valid pathFrame (principle4 pathFrame nearLeft) :=
  not_valid_of_pointed pathFrame
    (principle4 pathFrame nearLeft) path_4_countermodel

def leftOnly : Formula pathFrame
  | .left => True
  | .center => False
  | .right => False

def path_5_countermodel :
    PointedCountermodel pathFrame (principle5 pathFrame leftOnly) where
  world := .center
  refutes := by
    intro h5
    have hDia : diamond pathFrame leftOnly .center :=
      ⟨.left, True.intro, True.intro⟩
    have hBoxDia := h5 hDia
    have hDiaRight := hBoxDia .right True.intro
    obtain ⟨u, hru, hφu⟩ := hDiaRight
    cases u with
    | left => exact hru
    | center => exact hφu
    | right => exact hφu

theorem path_refutes_5 :
    ¬ Valid pathFrame (principle5 pathFrame leftOnly) :=
  not_valid_of_pointed pathFrame
    (principle5 pathFrame leftOnly) path_5_countermodel

/-- The same finite path supports genuine contingency at its center. -/
theorem path_has_contingency :
    ContingentAt pathFrame leftOnly .center := by
  constructor
  · exact ⟨.left, True.intro, True.intro⟩
  · exact ⟨.right, True.intro, by intro h; exact h⟩

end FiniteCountermodels
end Logos
