import Logos.Models.Grounding.Independence

namespace Logos
namespace GroundingModels
namespace MinimalNecessity

open Grounding
open Independence

/-!
This file isolates the exact role of A3.

The disconnected two-root model satisfies A0-A2 and A4-A5, so the minimal
necessity theorem applies without any common-ground/unity assumption.  In fact
both roots are necessary and ungrounded.  A3 is therefore not needed for the
existence of a necessary foundation; it is needed to collapse fundamental
plurality to one universal root.
-/

def twoRootNecessaryExistenceAxioms : NecessaryExistenceAxioms TRM where
  actual_nonempty := ⟨TwoRootEntity.a, True.intro⟩
  grounds_existents := by
    intro w a x h
    exact False.elim h
  grounding_wellFounded := twoRoot_wellFounded
  contingent_is_derived := by
    intro x hx hContingent
    exfalso
    rcases hContingent.2 with ⟨w, _, hNotExists⟩
    cases w
    exact hNotExists True.intro
  actual_reflexive := True.intro

/-- The minimal A0-A2+A4-A5 theorem applies even though A3 fails. -/
theorem twoRoot_minimal_necessity_holds :
    ∃ a, Ungrounded TRM a ∧ Necessary TRM a :=
  exists_necessary_ungrounded twoRootNecessaryExistenceAxioms

theorem twoRoot_a_necessary :
    Necessary TRM TwoRootEntity.a := by
  intro w haw
  cases w
  exact True.intro

theorem twoRoot_b_necessary :
    Necessary TRM TwoRootEntity.b := by
  intro w haw
  cases w
  exact True.intro

/-- Without A3, two distinct necessary ungrounded roots can coexist. -/
theorem twoRoot_two_necessary_ungrounded :
    (Ungrounded TRM TwoRootEntity.a ∧ Necessary TRM TwoRootEntity.a) ∧
    (Ungrounded TRM TwoRootEntity.b ∧ Necessary TRM TwoRootEntity.b) ∧
    TwoRootEntity.a ≠ TwoRootEntity.b := by
  exact ⟨
    ⟨twoRoot_a_ungrounded, twoRoot_a_necessary⟩,
    ⟨twoRoot_b_ungrounded, twoRoot_b_necessary⟩,
    twoRoot_distinct
  ⟩

/-- The brute-fact countermodel also refutes the cleaner A4' formulation. -/
theorem brute_A4Prime_fails :
    ¬ NonNecessaryIsDerived BM := by
  intro hA4Prime
  have hDerived := hA4Prime
    BruteEntity.brute brute_ungrounded.1 brute_not_necessary
  exact brute_ungrounded.2 hDerived

/-- In the brute model, original A4 and A4' are extensionally equivalent under
actual reflexivity, and both fail. -/
theorem brute_A4_iff_A4Prime :
    (∀ x, Actual BM x → Contingent BM x → Derived BM x) ↔
      NonNecessaryIsDerived BM :=
  a4_iff_nonNecessary_is_derived (M := BM) True.intro

end MinimalNecessity
end GroundingModels
end Logos
