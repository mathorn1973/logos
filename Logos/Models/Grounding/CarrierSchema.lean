import Logos.Systems.CarrierSchema.EntityInstance

namespace Logos
namespace GroundingModels
namespace CarrierSchema

open Grounding

/-! ## The escape, and which condition it exempts

Each model below is a one-item carrier on which a contingent item explains the
designated target.  By `escape_requires_exemption` no such carrier can satisfy
all of `ScopeClosureAxioms`, so each must exempt at least one condition.  The
point of the suite is that the three conditions fail *separately*: each model
drops exactly one and keeps the other two.

The carriers need no worlds, no facts and no regress.  That is itself part of
the result: the escape is available at any structure whatsoever, provided it is
not held to these three conditions. -/

/-- The single item offered as the terminus of explanation. -/
inductive Item where
  | licence
  deriving Repr, DecidableEq

/-! ### 1. Exempt from completeness

The licensing item is actual and contingent but simply declared to fall outside
the represented totality.  This is the shape of the modal-condition escape. -/

namespace CompletenessExempt

def carrier : ScopeCarrier Item where
  Actual := fun _ => True
  Necessary := fun _ => False
  Inside := fun _ => False
  Explains := fun _ => True
  Adequate := fun _ _ => False

theorem licence_actual : carrier.Actual Item.licence := True.intro

theorem licence_not_necessary : ¬ carrier.Necessary Item.licence := fun h => h

theorem licence_explains : carrier.Explains Item.licence := True.intro

/-- A contingent item explains the target, so closure cannot hold. -/
theorem closure_fails : ¬ ScopeClosureAxioms carrier :=
  escape_requires_exemption licence_explains licence_not_necessary

/-- Completeness is what fails. -/
theorem completeness_fails :
    ¬ (∀ a, carrier.Actual a → ¬ carrier.Necessary a → carrier.Inside a) := by
  intro hCovers
  exact hCovers Item.licence True.intro (fun h => h)

/-- The other two conditions hold, so the exemption is completeness and nothing
else. -/
theorem source_actual_holds :
    ∀ {a}, carrier.Explains a → carrier.Actual a := by
  intro a _
  exact True.intro

theorem scope_holds :
    ∀ {a}, carrier.Explains a →
      ∀ {x}, carrier.Inside x → carrier.Actual x → carrier.Adequate a x := by
  intro a _ x hInside _
  exact False.elim hInside

theorem adequacy_holds :
    ∀ {a}, ¬ carrier.Necessary a → ¬ carrier.Adequate a a := by
  intro a _ hAdequate
  exact hAdequate

end CompletenessExempt

/-! ### 2. Exempt from scope

Everything is inside the totality, but the explanation of the target is not
required to reach the members. -/

namespace ScopeExempt

def carrier : ScopeCarrier Item where
  Actual := fun _ => True
  Necessary := fun _ => False
  Inside := fun _ => True
  Explains := fun _ => True
  Adequate := fun _ _ => False

theorem licence_not_necessary : ¬ carrier.Necessary Item.licence := fun h => h

theorem licence_explains : carrier.Explains Item.licence := True.intro

theorem closure_fails : ¬ ScopeClosureAxioms carrier :=
  escape_requires_exemption licence_explains licence_not_necessary

/-- Scope is what fails. -/
theorem scope_fails :
    ¬ (∀ {a}, carrier.Explains a →
      ∀ {x}, carrier.Inside x → carrier.Actual x → carrier.Adequate a x) := by
  intro hScope
  exact hScope (a := Item.licence) True.intro (x := Item.licence) True.intro True.intro

theorem source_actual_holds :
    ∀ {a}, carrier.Explains a → carrier.Actual a := by
  intro a _
  exact True.intro

theorem completeness_holds :
    ∀ a, carrier.Actual a → ¬ carrier.Necessary a → carrier.Inside a := by
  intro a _ _
  exact True.intro

theorem adequacy_holds :
    ∀ {a}, ¬ carrier.Necessary a → ¬ carrier.Adequate a a := by
  intro a _ hAdequate
  exact hAdequate

end ScopeExempt

/-! ### 3. Exempt from adequacy

Completeness and scope both hold, but the item is allowed to count as its own
adequate explanation.  This is contingent self-citation one level up, and it is
exactly the question `SELF-EXPLANATION-1` isolated for entities. -/

namespace AdequacyExempt

def carrier : ScopeCarrier Item where
  Actual := fun _ => True
  Necessary := fun _ => False
  Inside := fun _ => True
  Explains := fun _ => True
  Adequate := fun _ _ => True

theorem licence_not_necessary : ¬ carrier.Necessary Item.licence := fun h => h

theorem licence_explains : carrier.Explains Item.licence := True.intro

theorem closure_fails : ¬ ScopeClosureAxioms carrier :=
  escape_requires_exemption licence_explains licence_not_necessary

/-- Adequacy is what fails. -/
theorem adequacy_fails :
    ¬ (∀ {a}, ¬ carrier.Necessary a → ¬ carrier.Adequate a a) := by
  intro hAdequacy
  exact hAdequacy (a := Item.licence) (fun h => h) True.intro

theorem source_actual_holds :
    ∀ {a}, carrier.Explains a → carrier.Actual a := by
  intro a _
  exact True.intro

theorem completeness_holds :
    ∀ a, carrier.Actual a → ¬ carrier.Necessary a → carrier.Inside a := by
  intro a _ _
  exact True.intro

theorem scope_holds :
    ∀ {a}, carrier.Explains a →
      ∀ {x}, carrier.Inside x → carrier.Actual x → carrier.Adequate a x := by
  intro a _ x _ _
  exact True.intro

end AdequacyExempt

/-! ### The suite as one statement

Each of the three conditions is separately load-bearing: for each one there is
a carrier that drops it, keeps the other two, and lets a contingent item explain
the target. -/

theorem each_condition_is_separately_load_bearing :
    (¬ (∀ a, CompletenessExempt.carrier.Actual a →
          ¬ CompletenessExempt.carrier.Necessary a →
          CompletenessExempt.carrier.Inside a))
    ∧ (¬ (∀ {a}, ScopeExempt.carrier.Explains a →
          ∀ {x}, ScopeExempt.carrier.Inside x → ScopeExempt.carrier.Actual x →
            ScopeExempt.carrier.Adequate a x))
    ∧ (¬ (∀ {a}, ¬ AdequacyExempt.carrier.Necessary a →
          ¬ AdequacyExempt.carrier.Adequate a a)) :=
  ⟨CompletenessExempt.completeness_fails,
   ScopeExempt.scope_fails,
   AdequacyExempt.adequacy_fails⟩

end CarrierSchema
end GroundingModels
end Logos
