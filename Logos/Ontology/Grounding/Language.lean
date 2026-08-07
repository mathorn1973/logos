import Logos.Logic.Modal

universe u v

namespace Logos
namespace Grounding

/-- A modal grounding model.

`directGrounds w a x` means that, at world `w`, `a` is an immediate
ontological ground of `x`. This is not a temporal causation relation.
`created` marks membership in the created/derived order; it is intentionally
kept distinct from mere existence at a world.
-/
structure Model where
  frame : Frame.{u}
  Entity : Type v
  actual : frame.World
  existsAt : frame.World → Entity → Prop
  directGrounds : frame.World → Entity → Entity → Prop
  created : Entity → Prop

/-- Existence at the distinguished actual world. -/
def Actual (M : Model) (x : M.Entity) : Prop :=
  M.existsAt M.actual x

/-- Immediate grounding at an arbitrary world. -/
def GroundsAt (M : Model) (w : M.frame.World) (a x : M.Entity) : Prop :=
  M.directGrounds w a x

/-- Immediate grounding at the actual world. -/
def ActualGrounds (M : Model) (a x : M.Entity) : Prop :=
  M.directGrounds M.actual a x

/-- An entity is derived at a world when it has an immediate ground there. -/
def DerivedAt (M : Model) (w : M.frame.World) (x : M.Entity) : Prop :=
  ∃ a, M.directGrounds w a x

/-- Actual derivation. -/
def Derived (M : Model) (x : M.Entity) : Prop :=
  ∃ a, ActualGrounds M a x

/-- An entity exists at `w` and has no immediate ground at `w`. -/
def UngroundedAt (M : Model) (w : M.frame.World) (x : M.Entity) : Prop :=
  M.existsAt w x ∧ ¬ DerivedAt M w x

/-- Actual ungroundedness. This is aseity only at the actual world. -/
def Ungrounded (M : Model) (x : M.Entity) : Prop :=
  UngroundedAt M M.actual x

/-- Necessary existence relative to the accessibility relation from the actual world. -/
def Necessary (M : Model) (x : M.Entity) : Prop :=
  box M.frame (fun w => M.existsAt w x) M.actual

/-- Contingent existence at the actual world: existence and nonexistence are both possible. -/
def Contingent (M : Model) (x : M.Entity) : Prop :=
  ContingentAt M.frame (fun w => M.existsAt w x) M.actual

/-- Reflexive-transitive actual grounding ancestry.

`GroundAncestor M a x` says that `a = x` or that there is a finite chain of
actual immediate grounding steps from `a` to `x`.
-/
inductive GroundAncestor (M : Model) : M.Entity → M.Entity → Prop where
  | refl (x : M.Entity) : GroundAncestor M x x
  | extend {a b c : M.Entity} :
      GroundAncestor M a b →
      ActualGrounds M b c →
      GroundAncestor M a c

/-- Strict finite grounding ancestry. -/
def UltimatelyGrounds (M : Model) (a x : M.Entity) : Prop :=
  GroundAncestor M a x ∧ a ≠ x

/-- An absolute ground in the minimal system.

The predicate deliberately contains only the formal result of the grounding
argument: actual ungroundedness, necessary existence, transcendence of the
created order, and universal finite grounding ancestry. No personal or moral
divine attribute is built into this definition.
-/
def AbsoluteGround (M : Model) (a : M.Entity) : Prop :=
  Ungrounded M a ∧
  Necessary M a ∧
  ¬ M.created a ∧
  ∀ x, Actual M x → GroundAncestor M a x

/-- Necessary aseity: the entity is ungrounded at every accessible world. -/
def NecessarilyAseitic (M : Model) (a : M.Entity) : Prop :=
  box M.frame (fun w => UngroundedAt M w a) M.actual

end Grounding
end Logos
