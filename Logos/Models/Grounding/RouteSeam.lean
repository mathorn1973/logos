import Logos.Systems.RouteSeam.Theorems
import Logos.Systems.TotalityExternality.ScopeTheorems
import Logos.Models.Grounding.TotalityExternality

namespace Logos
namespace GroundingModels
namespace RouteSeam

open Grounding

/-! ## Countermodel: the totality explainer may itself be grounded

The deep accepted package EF4 + S + I + C is satisfied, the explainer is actual,
necessary and outside the represented regress, and it is nevertheless derived. -/

namespace GroundedExplainer

inductive World where
  | actual
  | stripped
  deriving Repr, DecidableEq

/-- `over` grounds the explanatory root without explaining anything itself. -/
inductive Entity where
  | over
  | root
  | node (n : Nat)
  deriving Repr, DecidableEq

inductive Fact where
  | totality
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def existsAt : World → Entity → Prop
  | _, .over => True
  | _, .root => True
  | .actual, .node _ => True
  | .stripped, .node _ => False

def directGrounds : World → Entity → Entity → Prop
  | .actual, .over, .root => True
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

def groundsFact : World → Entity → Fact → Prop
  | .actual, .node _, .totality => True
  | _, _, _ => False

def facts : FactModel M where
  Fact := Fact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev F := facts

def inside : Entity → Prop
  | .over => False
  | .root => False
  | .node _ => True

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := rfl

def regress : RegressTotality M F where
  node := Entity.node
  step := regress_step
  totality := Fact.totality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev R := regress

/-- Internal members constitute the totality fact; only `root` explains it. -/
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

/-- `root` explains every represented member and nothing else. -/
def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .node _ => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem root_actual : Actual M Entity.root := True.intro

theorem over_actual : Actual M Entity.over := True.intro

theorem root_explains : ActualExplainsFact G Entity.root R.totality := True.intro

theorem root_necessary : Necessary M Entity.root := by
  intro world _; cases world <;> exact True.intro

theorem over_necessary : Necessary M Entity.over := by
  intro world _; cases world <;> exact True.intro

theorem totality_not_necessary : ¬ NecessaryFact F R.totality := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

theorem root_outside : ¬ R.inside Entity.root := by
  intro hInside; exact hInside

theorem over_grounds_root : ActualGrounds M Entity.over Entity.root := True.intro

theorem root_derived : Derived M Entity.root := ⟨Entity.over, over_grounds_root⟩

/-- The load-bearing negative fact of this model. -/
theorem root_not_ungrounded : ¬ Ungrounded M Entity.root := by
  intro hUngrounded
  exact hUngrounded.2 root_derived

/-- The deep accepted package EF4 + S + I + C is satisfied here. -/
def completeScopedAxioms : CompleteScopedExplanationAxioms M F G E R where
  explains_existents := by
    intro a p hExplain
    cases a with
    | over => cases p; exact False.elim hExplain
    | root => cases p; exact ⟨root_actual, True.intro⟩
    | node n => cases p; exact False.elim hExplain
  nonNecessaryFact_is_explained := by
    intro p _ _
    cases p
    exact ⟨Entity.root, root_explains⟩
  explains_members := by
    intro a hExplain x hInside
    cases a with
    | over => exact False.elim hExplain
    | root =>
        cases x with
        | over => exact False.elim hInside
        | root => exact False.elim hInside
        | node n => exact True.intro
    | node n => exact False.elim hExplain
  explanation_irreflexive := by
    intro a _ hSelf
    cases a with
    | over => exact hSelf
    | root => exact hSelf
    | node n => exact hSelf
  covers_nonNecessary := by
    intro x _ hNotNecessary
    cases x with
    | over => exact False.elim (hNotNecessary over_necessary)
    | root => exact False.elim (hNotNecessary root_necessary)
    | node n => exact True.intro

/-- The accepted deep theorem fires in this model. -/
theorem deep_route_has_necessary_explainer :
    ∃ a, Actual M a ∧ Necessary M a ∧
      ActualExplainsFact G a R.totality ∧ ¬ R.inside a := by
  rcases contingent_totality_forces_necessary_reality_from_scope completeScopedAxioms with
      hFact | hEntity
  · exact False.elim (totality_not_necessary hFact)
  · exact hEntity

/-- And no explainer it can deliver is ungrounded. -/
theorem no_explainer_is_ungrounded :
    ∀ a, ActualExplainsFact G a R.totality → ¬ Ungrounded M a := by
  intro a hExplain
  cases a with
  | over => exact False.elim hExplain
  | root => exact root_not_ungrounded
  | node n => exact False.elim hExplain

end GroundedExplainer

/-! ## Contrast: in the accepted positive model the explainer is ungrounded

Read off the model already on `main`. Together with `GroundedExplainer` this
shows the deep package settles nothing about groundedness of its witness. -/

namespace UngroundedExplainer

open TotalityExternalityComparison.MixedRoles

theorem root_not_derived : ¬ Derived M Entity.root := by
  intro hDerived
  rcases hDerived with ⟨a, hGrounds⟩
  cases a with
  | root => exact hGrounds
  | node n =>
      cases n with
      | zero => exact hGrounds
      | succ k => exact hGrounds

theorem root_ungrounded : Ungrounded M Entity.root :=
  ⟨TotalityExternality.Positive.root_actual, root_not_derived⟩

theorem explainer_is_ungrounded_here :
    ActualExplainsFact G Entity.root R.totality ∧ Ungrounded M Entity.root :=
  ⟨root_explains, root_ungrounded⟩

end UngroundedExplainer

/-- Summary of the independence: the deep package neither forces nor forbids
groundedness of the explanatory source it delivers. -/
theorem explainer_groundedness_undetermined :
    (∀ a, ActualExplainsFact GroundedExplainer.G a GroundedExplainer.R.totality →
        ¬ Ungrounded GroundedExplainer.M a) ∧
    Ungrounded TotalityExternalityComparison.MixedRoles.M
      TotalityExternalityComparison.MixedRoles.Entity.root :=
  ⟨GroundedExplainer.no_explainer_is_ungrounded, UngroundedExplainer.root_ungrounded⟩

/-! ## The regress-totality structure is cheap

`regressTotality_refutes_wellFoundedness` makes the two routes exclusive.  This
section makes the dichotomy exhaustive as well, and then shows immediately why
that costs the argument nothing: the witness it constructs satisfies the
totality route's conclusion by its trivial disjunct. -/

namespace BareRegress

open Grounding

universe u v

/-- A fact layer supplying nothing but one always-obtaining fact.  Nothing
grounds it and nothing explains it. -/
def bareFactModel (M : Grounding.Model.{u, v}) : FactModel.{u, v, 0} M where
  Fact := Unit
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

/-- Any actual descending chain can be dressed as a regress totality.  The fact
carrier, the designated totality fact and the `inside` predicate are free data,
so a negation does not have to supply them. -/
def regressOfChain {M : Grounding.Model.{u, v}}
    (f : Nat → M.Entity) (hf : ∀ n, ActualGrounds M (f (n + 1)) (f n)) :
    RegressTotality M (bareFactModel M) where
  node := f
  step := hf
  totality := ()
  actual_totality := True.intro
  inside := fun _ => True
  node_inside := fun _ => True.intro

/-- Structural dichotomy.  Exclusive by `regressTotality_refutes_wellFoundedness`,
exhaustive by this theorem. -/
theorem wellFounded_or_regressTotality (M : Grounding.Model.{u, v}) :
    WellFounded (ActualGrounds M) ∨
      Nonempty (RegressTotality M (bareFactModel M)) := by
  by_cases hWellFounded : WellFounded (ActualGrounds M)
  · exact Or.inl hWellFounded
  · right
    rcases exists_descending_chain_of_not_wellFounded hWellFounded with ⟨f, hf⟩
    exact ⟨regressOfChain f hf⟩

/-- The deflation.  In the freely constructed witness the totality fact is
necessary, so the totality route's disjunctive conclusion holds by its first
disjunct without any explanatory premise doing work.

Exhaustiveness of the structural dichotomy therefore carries no argumentative
weight: all the content of the totality route sits in EF4, S, I and C, not in
the availability of a regress totality. -/
theorem bare_totality_necessary
    {M : Grounding.Model.{u, v}} (R : RegressTotality M (bareFactModel M)) :
    NecessaryFact (bareFactModel M) R.totality := by
  intro _ _
  exact True.intro

end BareRegress

end RouteSeam
end GroundingModels
end Logos
