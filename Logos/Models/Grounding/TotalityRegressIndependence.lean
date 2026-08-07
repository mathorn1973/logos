import Logos.Models.Grounding.TotalityRegress

namespace Logos
namespace GroundingModels
namespace TotalityRegressIndependence

open Grounding

/-! ## Completeness: external but contingent ground outside an incomplete regress -/

namespace IncompleteCoverage

inductive World where
  | actual
  | absent
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

inductive Entity where
  | external
  | node (n : Nat)
  deriving Repr, DecidableEq

def existsAt : World → Entity → Prop
  | .actual, _ => True
  | .absent, _ => False

def directGrounds : World → Entity → Entity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def entityModel : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := existsAt
  directGrounds := directGrounds
  created := fun _ => False

abbrev M := entityModel

inductive Fact where
  | regressTotality
  deriving Repr, DecidableEq

def holdsAt : World → Fact → Prop
  | .actual, .regressTotality => True
  | .absent, .regressTotality => False

def groundsFact : World → Entity → Fact → Prop
  | .actual, .external, .regressTotality => True
  | _, _, _ => False

def factModel : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := factModel

def inside : Entity → Prop
  | .external => False
  | .node _ => True

theorem step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := by
  change directGrounds World.actual (Entity.node (Nat.succ n)) (Entity.node n)
  exact rfl

def regressTotality : RegressTotality M F where
  node := Entity.node
  step := step
  totality := Fact.regressTotality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regressTotality

theorem external_actual : Actual M Entity.external := True.intro

theorem external_nonNecessary : ¬ Necessary M Entity.external := by
  intro h
  exact h World.absent True.intro

theorem external_grounds_totality :
    ActualGroundsFact F Entity.external R.totality := True.intro

def externalAxioms : ExternalRegressTotalityAxioms M F R where
  groundsFact_existents := by
    intro a p h
    cases a with
    | external =>
        cases p
        exact ⟨external_actual, True.intro⟩
    | node n =>
        cases p
        exact False.elim h
  nonNecessaryFact_is_derived := by
    intro p hp hNot
    cases p
    exact ⟨Entity.external, external_grounds_totality⟩
  totality_ground_external := by
    intro a hGround
    cases a with
    | external =>
        intro hInside
        exact hInside
    | node n =>
        exact False.elim hGround

theorem every_entity_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x := by
  intro x hx hNecessary
  exact hNecessary World.absent True.intro

theorem totality_nonNecessary : ¬ NecessaryFact F R.totality := by
  intro h
  exact h World.absent True.intro

/-- Completeness is genuinely additional: the external ground is itself
non-necessary but lies outside the represented regress. -/
theorem completeness_fails :
    ¬ (∀ x, Actual M x → ¬ Necessary M x → R.inside x) := by
  intro hCover
  exact hCover Entity.external external_actual external_nonNecessary

/-- Fact A4' and externality alone do not eliminate pure contingency. -/
theorem pure_contingency_survives_without_completeness :
    (¬ NecessaryFact F R.totality) ∧
      (∀ x, Actual M x → ¬ Necessary M x) :=
  ⟨totality_nonNecessary, every_entity_nonNecessary⟩

end IncompleteCoverage

/-! ## Fact-level A4': a contingent ungrounded totality fact -/

namespace NoFactSufficientGround

inductive World where
  | actual
  | absent
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

inductive Entity where
  | node (n : Nat)
  deriving Repr, DecidableEq

def existsAt : World → Entity → Prop
  | .actual, _ => True
  | .absent, _ => False

def directGrounds : World → Entity → Entity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def entityModel : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := existsAt
  directGrounds := directGrounds
  created := fun _ => False

abbrev M := entityModel

inductive Fact where
  | regressTotality
  deriving Repr, DecidableEq

def holdsAt : World → Fact → Prop
  | .actual, .regressTotality => True
  | .absent, .regressTotality => False

def groundsFact : World → Entity → Fact → Prop := fun _ _ _ => False

def factModel : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := factModel

def inside : Entity → Prop := fun _ => True

theorem step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := by
  change directGrounds World.actual (Entity.node (Nat.succ n)) (Entity.node n)
  exact rfl

def regressTotality : RegressTotality M F where
  node := Entity.node
  step := step
  totality := Fact.regressTotality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regressTotality

theorem totality_nonNecessary : ¬ NecessaryFact F R.totality := by
  intro h
  exact h World.absent True.intro

theorem totality_not_derived : ¬ DerivedFact F R.totality := by
  intro hDerived
  rcases hDerived with ⟨a, ha⟩
  cases a with
  | node n => exact ha

theorem every_entity_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x := by
  intro x hx hNecessary
  exact hNecessary World.absent True.intro

theorem completeness_holds :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x := by
  intro x hx hNot
  exact True.intro

theorem externality_holds :
    ∀ {a}, ActualGroundsFact F a R.totality → ¬ R.inside a := by
  intro a hGround
  exact False.elim hGround

/-- Fact-level A4' fails: the actual non-necessary totality fact has no ground. -/
theorem fact_A4Prime_fails :
    ¬ (∀ p, ActualFact F p → ¬ NecessaryFact F p → DerivedFact F p) := by
  intro hA4
  have hDerived := hA4 R.totality R.actual_totality totality_nonNecessary
  exact totality_not_derived hDerived

/-- Even completeness and externality do not eliminate pure contingency if the
sufficient-ground principle is not extended from entities to facts. -/
theorem pure_contingency_survives_without_fact_A4Prime :
    (¬ NecessaryFact F R.totality) ∧
      (∀ x, Actual M x → ¬ Necessary M x) :=
  ⟨totality_nonNecessary, every_entity_nonNecessary⟩

end NoFactSufficientGround

end TotalityRegressIndependence
end GroundingModels
end Logos
