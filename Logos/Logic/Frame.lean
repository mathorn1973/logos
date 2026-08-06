universe u

namespace Logos

/-- A Kripke frame. `World` and `access` carry no metaphysical interpretation by themselves. -/
structure Frame where
  World : Type u
  access : World → World → Prop

/-- A proposition whose truth may vary by world. -/
abbrev Formula (F : Frame.{u}) := F.World → Prop

/-- Truth at every world of a frame. -/
def Valid (F : Frame.{u}) (φ : Formula F) : Prop :=
  ∀ w, φ w

/-- Truth at at least one world of a frame. -/
def Satisfiable (F : Frame.{u}) (φ : Formula F) : Prop :=
  ∃ w, φ w

/-- Semantic entailment inside one fixed frame. -/
def Entails (F : Frame.{u}) (Γ : Formula F → Prop) (φ : Formula F) : Prop :=
  ∀ w, (∀ ψ, Γ ψ → ψ w) → φ w

end Logos
