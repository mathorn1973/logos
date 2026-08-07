import Logos.Systems.TotalityRegress.Theorems

namespace Logos
namespace GroundingModels
namespace TotalityRegress

open Grounding

/-! ## Positive model: contingent infinite regress with a necessary external ground -/

inductive World where
  | actual
  | stripped
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

inductive Entity where
  | root
  | node (n : Nat)
  deriving Repr, DecidableEq

def existsAt : World → Entity → Prop
  | _, .root => True
  | .actual, .node _ => True
  | .stripped, .node _ => False

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
  | .stripped, .regressTotality => False

def groundsFact : World → Entity → Fact → Prop
  | .actual, .root, .regressTotality => True
  | _, _, _ => False

def factModel : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := factModel

def inside : Entity → Prop
  | .root => False
  | .node _ => True

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := by
  change directGrounds World.actual (Entity.node (Nat.succ n)) (Entity.node n)
  exact rfl

def regressTotality : RegressTotality M F where
  node := Entity.node
  step := regress_step
  totality := Fact.regressTotality
  actual_totality := True.intro
  inside := inside
  node_inside := by
    intro n
    exact True.intro

abbrev R := regressTotality

theorem root_actual : Actual M Entity.root := True.intro

theorem root_necessary : Necessary M Entity.root := by
  intro world _
  cases world <;> exact True.intro

theorem totality_grounded_by_root :
    ActualGroundsFact F Entity.root R.totality := True.intro

theorem totality_not_necessary :
    ¬ NecessaryFact F R.totality := by
  intro h
  exact h World.stripped True.intro

def completeTotalityAxioms : CompleteContingentTotalityAxioms M F R where
  groundsFact_existents := by
    intro a p h
    cases a with
    | root =>
        cases p
        exact ⟨root_actual, True.intro⟩
    | node n =>
        cases p
        exact False.elim h

  nonNecessaryFact_is_derived := by
    intro p hp hNot
    cases p
    exact ⟨Entity.root, totality_grounded_by_root⟩

  totality_ground_external := by
    intro a hGround
    cases a with
    | root =>
        intro hInside
        exact hInside
    | node n =>
        exact False.elim hGround

  covers_nonNecessary := by
    intro x hx hNotNecessary
    cases x with
    | root =>
        exact False.elim (hNotNecessary root_necessary)
    | node n =>
        exact True.intro

/-- The right branch of the totality dichotomy is inhabited: the totality fact
is contingent and has a necessary external entity-ground. -/
theorem positive_totality_forces_external_necessary_ground :
    ∃ a, Actual M a ∧ Necessary M a ∧
      ActualGroundsFact F a R.totality ∧ ¬ R.inside a := by
  rcases contingent_totality_forces_necessary_reality completeTotalityAxioms with
      hFact | hEntity
  · exact False.elim (totality_not_necessary hFact)
  · exact hEntity

/-! ## Countermodel: without externality, pure contingency survives -/

namespace InternalGround

inductive IWorld where
  | actual
  | absent
  deriving Repr, DecidableEq

def iAccess : IWorld → IWorld → Prop := fun _ _ => True

inductive IEntity where
  | node (n : Nat)
  deriving Repr, DecidableEq

def iExistsAt : IWorld → IEntity → Prop
  | .actual, _ => True
  | .absent, _ => False

def iDirectGrounds : IWorld → IEntity → IEntity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def iEntityModel : Grounding.Model where
  frame := { World := IWorld, access := iAccess }
  Entity := IEntity
  actual := .actual
  existsAt := iExistsAt
  directGrounds := iDirectGrounds
  created := fun _ => False

abbrev IM := iEntityModel

inductive IFact where
  | regressTotality
  deriving Repr, DecidableEq

def iHoldsAt : IWorld → IFact → Prop
  | .actual, .regressTotality => True
  | .absent, .regressTotality => False

def iGroundsFact : IWorld → IEntity → IFact → Prop
  | .actual, .node 0, .regressTotality => True
  | _, _, _ => False

def iFactModel : FactModel IM where
  Fact := IFact
  holdsAt := iHoldsAt
  groundsFact := iGroundsFact

abbrev IFM := iFactModel

def iInside : IEntity → Prop := fun _ => True

theorem iRegressStep (n : Nat) :
    ActualGrounds IM (IEntity.node (n + 1)) (IEntity.node n) := by
  change iDirectGrounds IWorld.actual (IEntity.node (Nat.succ n)) (IEntity.node n)
  exact rfl

def iRegressTotality : RegressTotality IM IFM where
  node := IEntity.node
  step := iRegressStep
  totality := IFact.regressTotality
  actual_totality := True.intro
  inside := iInside
  node_inside := by intro n; exact True.intro

abbrev IR := iRegressTotality

def iFactAxioms : FactGroundingAxioms IM IFM where
  groundsFact_existents := by
    intro a p h
    cases a with
    | node n =>
        cases n with
        | zero =>
            cases p
            exact ⟨True.intro, True.intro⟩
        | succ n =>
            cases p
            exact False.elim h

  nonNecessaryFact_is_derived := by
    intro p hp hNot
    cases p
    exact ⟨IEntity.node 0, True.intro⟩

theorem internal_totality_not_necessary :
    ¬ NecessaryFact IFM IR.totality := by
  intro h
  exact h IWorld.absent True.intro

theorem every_internal_entity_nonNecessary :
    ∀ x, Actual IM x → ¬ Necessary IM x := by
  intro x hx hNecessary
  exact hNecessary IWorld.absent True.intro

theorem internal_ground_is_inside : IR.inside (IEntity.node 0) := True.intro

theorem node0_grounds_totality :
    ActualGroundsFact IFM (IEntity.node 0) IR.totality := True.intro

/-- The externality principle is genuinely additional: here the totality is
grounded by a member of the regress itself. -/
theorem externality_fails :
    ¬ (∀ {a}, ActualGroundsFact IFM a IR.totality → ¬ IR.inside a) := by
  intro hExternal
  exact hExternal node0_grounds_totality internal_ground_is_inside

/-- With fact-level A4' but without externality, a fully contingent entity
carrier and a contingent totality fact are jointly satisfiable. -/
theorem pure_contingency_survives_without_externality :
    (¬ NecessaryFact IFM IR.totality) ∧
      (∀ x, Actual IM x → ¬ Necessary IM x) :=
  ⟨internal_totality_not_necessary, every_internal_entity_nonNecessary⟩

end InternalGround

end TotalityRegress
end GroundingModels
end Logos
