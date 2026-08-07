import Logos.Systems.TotalityExternality.Axioms

namespace Logos
namespace GroundingModels
namespace TotalityExternalityComparison

open Grounding

/-! ## R1-R3: role separation and externality ordering -/

namespace MixedRoles

inductive World where
  | actual
  | stripped
  deriving Repr, DecidableEq

inductive Entity where
  | root
  | node (n : Nat)
  deriving Repr, DecidableEq

inductive Fact where
  | totality
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def existsAt : World → Entity → Prop
  | _, .root => True
  | .actual, .node _ => True
  | .stripped, .node _ => False

def directGrounds : World → Entity → Entity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def model : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := existsAt
  directGrounds := directGrounds
  created := fun _ => False

abbrev M := model

def holdsAt : World → Fact → Prop
  | .actual, .totality => True
  | .stripped, .totality => False

/-- Generic grounding contains both the external root and an internal member. -/
def groundsFact : World → Entity → Fact → Prop
  | .actual, .root, .totality => True
  | .actual, .node 0, .totality => True
  | _, _, _ => False

def facts : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := facts

def inside : Entity → Prop
  | .root => False
  | .node _ => True

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := by
  change directGrounds World.actual (Entity.node (Nat.succ n)) (Entity.node n)
  exact rfl

def regress : RegressTotality M F where
  node := Entity.node
  step := regress_step
  totality := Fact.totality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regress

/-- Internal nodes constitute; only the root explains. -/
def roles : FactGroundingRoles M F where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .totality => True
    | _, _, _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .root, .totality => True
    | _, _, _ => False

abbrev G := roles

/-- R1: constitutive support without explanation. -/
theorem node0_constitutes :
    ActualConstitutesFact G (Entity.node 0) R.totality := True.intro

theorem node0_not_explains :
    ¬ ActualExplainsFact G (Entity.node 0) R.totality := by
  intro h
  exact h

/-- R2: explanation without constitutive support. -/
theorem root_explains :
    ActualExplainsFact G Entity.root R.totality := True.intro

theorem root_not_constitutes :
    ¬ ActualConstitutesFact G Entity.root R.totality := by
  intro h
  exact h

/-- G holds: every registered explainer in this model is also a generic fact ground. -/
theorem explanation_implies_grounding : ExplanationImpliesGrounding G := by
  intro a p hExplain
  cases a with
  | root =>
      cases p
      exact True.intro
  | node n =>
      cases p
      exact False.elim hExplain

theorem node0_generic_ground :
    ActualGroundsFact F (Entity.node 0) R.totality := True.intro

/-- Old E fails because an internal member is a generic ground. -/
theorem old_externality_fails : ¬ GenericTotalityExternality F R := by
  intro hOld
  exact hOld node0_generic_ground True.intro

/-- R3a: revised explanatory externality holds in the same model. -/
theorem explanatory_externality_holds :
    ExplanatoryTotalityExternality G R := by
  intro a hExplain
  cases a with
  | root =>
      intro hInside
      exact hInside
  | node n =>
      exact False.elim hExplain

/-- Under G this model witnesses strict weakening on the externality axis. -/
theorem bridged_externality_strictness_witness :
    ExplanationImpliesGrounding G ∧
      ExplanatoryTotalityExternality G R ∧
      ¬ GenericTotalityExternality F R :=
  ⟨explanation_implies_grounding,
    explanatory_externality_holds,
    old_externality_fails⟩

end MixedRoles

/-! ## R3b: old E does not imply E_expl without bridge G -/

namespace EWithoutEExpl

open MixedRoles

/-- Alternate generic fact model: only the external root is a generic ground. -/
def facts : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .root, .totality => True
    | _, _, _ => False

abbrev F := facts

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := MixedRoles.regress_step n

def regress : RegressTotality M F where
  node := Entity.node
  step := regress_step
  totality := Fact.totality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regress

/-- An internal node is registered as explaining the totality while not being a generic ground. -/
def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node 0, .totality => True
    | _, _, _ => False

abbrev G := roles

theorem generic_externality_holds : GenericTotalityExternality F R := by
  intro a hGround
  cases a with
  | root =>
      intro hInside
      exact hInside
  | node n =>
      exact False.elim hGround

theorem node0_explains :
    ActualExplainsFact G (Entity.node 0) R.totality := True.intro

theorem explanatory_externality_fails :
    ¬ ExplanatoryTotalityExternality G R := by
  intro hEExpl
  exact hEExpl node0_explains True.intro

/-- As intended, bridge G fails in this unbridged independence model. -/
theorem explanation_implies_grounding_fails :
    ¬ ExplanationImpliesGrounding G := by
  intro hBridge
  have hGround := hBridge node0_explains
  exact hGround

end EWithoutEExpl

/-! ## R4: generic F4 does not imply EF4, even when bridge G holds -/

namespace F4NotEF4

inductive World where
  | actual
  | absent
  deriving Repr, DecidableEq

inductive Entity where
  | source
  deriving Repr, DecidableEq

inductive Fact where
  | p
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def model : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := fun world _ => world = World.actual
  directGrounds := fun _ _ _ => False
  created := fun _ => False

abbrev M := model

def facts : FactModel M where
  Fact := Fact
  holdsAt := fun world _ => world = World.actual
  groundsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .source, .p => True
    | _, _, _ => False

abbrev F := facts

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun _ _ _ => False

abbrev G := roles

theorem p_actual : ActualFact F Fact.p := rfl

theorem p_not_necessary : ¬ NecessaryFact F Fact.p := by
  intro hNecessary
  have hImpossible : World.absent = World.actual :=
    hNecessary World.absent True.intro
  cases hImpossible

/-- Bridge G holds vacuously because there are no registered explanations. -/
theorem explanation_implies_grounding : ExplanationImpliesGrounding G := by
  intro a p hExplain
  cases a
  cases p
  exact False.elim hExplain

/-- R4 positive side: old generic F4 holds. -/
theorem generic_F4_holds : GenericFactSufficientGround F := by
  intro p hp hNotNecessary
  cases p
  exact ⟨Entity.source, True.intro⟩

/-- R4 negative side: EF4 fails. -/
theorem explanatory_F4_fails : ¬ ExplanatoryFactSufficientGround G := by
  intro hEF4
  rcases hEF4 Fact.p p_actual p_not_necessary with ⟨a, hExplain⟩
  cases a
  exact hExplain

/-- With G fixed, F4 still does not imply EF4. -/
theorem bridged_F4_not_EF4 :
    ExplanationImpliesGrounding G ∧
      GenericFactSufficientGround F ∧
      ¬ ExplanatoryFactSufficientGround G :=
  ⟨explanation_implies_grounding, generic_F4_holds, explanatory_F4_fails⟩

end F4NotEF4

/-! ## R5: EF4 does not imply generic F4 without bridge G -/

namespace EF4NotF4

inductive World where
  | actual
  | absent
  deriving Repr, DecidableEq

inductive Entity where
  | source
  deriving Repr, DecidableEq

inductive Fact where
  | p
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def model : Grounding.Model where
  frame := { World := World, access := access }
  Entity := Entity
  actual := .actual
  existsAt := fun world _ => world = World.actual
  directGrounds := fun _ _ _ => False
  created := fun _ => False

abbrev M := model

def facts : FactModel M where
  Fact := Fact
  holdsAt := fun world _ => world = World.actual
  groundsFact := fun _ _ _ => False

abbrev F := facts

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .source, .p => True
    | _, _, _ => False

abbrev G := roles

theorem p_actual : ActualFact F Fact.p := rfl

theorem p_not_necessary : ¬ NecessaryFact F Fact.p := by
  intro hNecessary
  have hImpossible : World.absent = World.actual :=
    hNecessary World.absent True.intro
  cases hImpossible

/-- R5 positive side: EF4 holds. -/
theorem explanatory_F4_holds : ExplanatoryFactSufficientGround G := by
  intro p hp hNotNecessary
  cases p
  exact ⟨Entity.source, True.intro⟩

/-- R5 negative side: old generic F4 fails. -/
theorem generic_F4_fails : ¬ GenericFactSufficientGround F := by
  intro hF4
  rcases hF4 Fact.p p_actual p_not_necessary with ⟨a, hGround⟩
  cases a
  exact hGround

/-- Bridge G necessarily fails here: the explainer is not a generic ground. -/
theorem explanation_implies_grounding_fails :
    ¬ ExplanationImpliesGrounding G := by
  intro hBridge
  have hGround : ActualGroundsFact F Entity.source Fact.p :=
    hBridge (a := Entity.source) (p := Fact.p) True.intro
  exact hGround

end EF4NotF4

end TotalityExternalityComparison
end GroundingModels
end Logos
