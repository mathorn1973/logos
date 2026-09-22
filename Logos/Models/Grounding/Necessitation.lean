import Logos.Systems.Necessitation.Theorems
import Logos.Models.Grounding.Independence
import Logos.Models.Grounding.FreeCreation
import Logos.Models.Grounding.FactSufficientExplanation

namespace Logos
namespace GroundingModels
namespace Necessitation

open Grounding

/-! # Models for NECESSITATION-1

Section numbers refer to `NECESSITATION-CONTRACT.md`. Every new model uses two
worlds with universal access unless stated otherwise. Where a model has an
actual entity that is not necessary, that is stated written out as
`∃ x, Actual M x ∧ ¬ Necessary M x`. -/

inductive TwoWorld where
  | actual
  | other
  deriving Repr, DecidableEq

/-! ## 5.4 Foundation side -/

/-! ### UnactualGround: A1 fails

An actual contingent target is grounded at the actual world by an entity that
does not exist there. The ground exists only at a third world, where the target
exists too, so grounding necessitates and does so non-vacuously at that world. -/

namespace UnactualGround

inductive World where
  | actual
  | other
  | third
  deriving Repr, DecidableEq

inductive Entity where
  | ground
  | target
  deriving Repr, DecidableEq

def uExistsAt : World → Entity → Prop
  | .actual, .target => True
  | .third, _ => True
  | _, _ => False

def model : Grounding.Model where
  frame := { World := World, access := fun _ _ => True }
  Entity := Entity
  actual := .actual
  existsAt := uExistsAt
  directGrounds := fun w a x => w = .actual ∧ a = .ground ∧ x = .target
  created := fun _ => False

abbrev M := model

theorem a1_fails :
    ¬ (∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) := by
  intro h
  exact (h (w := World.actual) (a := Entity.ground) (x := Entity.target) ⟨rfl, rfl, rfl⟩).1

theorem a2 : WellFounded (ActualGrounds M) := by
  constructor
  intro x
  have hGround : Acc (ActualGrounds M) Entity.ground := by
    apply Acc.intro
    intro y hy
    exact Entity.noConfusion hy.2.2
  cases x with
  | ground => exact hGround
  | target =>
      apply Acc.intro
      intro y hy
      rcases hy with ⟨_, hy, _⟩
      subst hy
      exact hGround

theorem a4 : ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x hx _
  cases x with
  | ground => exact False.elim hx
  | target => exact ⟨Entity.ground, rfl, rfl, rfl⟩

theorem a5 : M.frame.access M.actual M.actual := True.intro

theorem grounding_necessitates : GroundingNecessitates M := by
  intro x hDerived world _ hGrounds
  rcases hDerived with ⟨a, ha⟩
  rcases ha with ⟨_, ha, hx⟩
  subst ha
  subst hx
  have hGround := hGrounds Entity.ground ⟨rfl, rfl, rfl⟩
  cases world with
  | actual => exact True.intro
  | other => exact False.elim hGround
  | third => exact True.intro

/-- Necessitation is not vacuous here: at the third world the ground exists and
the target exists with it. -/
theorem ground_exists_somewhere :
    M.frame.access M.actual World.third ∧ M.existsAt World.third Entity.ground :=
  ⟨True.intro, True.intro⟩

theorem target_not_necessary : ¬ Necessary M Entity.target := by
  intro hNecessary
  exact hNecessary World.other True.intro

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨Entity.target, True.intro, target_not_necessary⟩

end UnactualGround

/-! ### NecessitatingRegress: A2 fails

Each natural number is grounded by its successor, and every entity exists only
at the actual world. At the other world the grounds are absent, so grounding
necessitates. -/

namespace NecessitatingRegress

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ _ => True }
  Entity := Nat
  actual := .actual
  existsAt := fun w _ => w = .actual
  directGrounds := fun w a x => w = .actual ∧ a = x + 1
  created := fun _ => False

abbrev M := model

theorem a1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x := by
  intro w a x h
  exact ⟨h.1, h.1⟩

theorem a2_fails : ¬ WellFounded (ActualGrounds M) := by
  intro hWellFounded
  exact hWellFounded.induction (C := fun _ => False) (0 : Nat)
    (fun x ih => ih (Nat.succ x) ⟨rfl, rfl⟩)

theorem a4 : ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x _ _
  exact ⟨Nat.succ x, rfl, rfl⟩

theorem a5 : M.frame.access M.actual M.actual := True.intro

theorem grounding_necessitates : GroundingNecessitates M := by
  intro x _ world _ hGrounds
  exact hGrounds (Nat.succ x) ⟨rfl, rfl⟩

theorem zero_not_necessary : ¬ Necessary M (0 : Nat) := by
  intro hNecessary
  exact TwoWorld.noConfusion (hNecessary TwoWorld.other True.intro)

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨(0 : Nat), rfl, zero_not_necessary⟩

end NecessitatingRegress

/-! ### bruteModel: A4 fails

The accepted model from `Logos.Models.Grounding.Independence`. Nothing is
derived, so grounding necessitates vacuously. -/

namespace Brute

abbrev M := Independence.BM

theorem a1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x := by
  intro w a x h
  exact False.elim h

theorem a2 : WellFounded (ActualGrounds M) := Independence.brute_wellFounded

theorem a4_fails : ¬ (∀ x, Actual M x → Contingent M x → Derived M x) := by
  intro h
  exact Independence.brute_ungrounded.2
    (h Independence.BruteEntity.brute Independence.brute_ungrounded.1
      Independence.brute_contingent)

theorem a5 : M.frame.access M.actual M.actual := True.intro

theorem grounding_necessitates : GroundingNecessitates M := by
  intro x hDerived
  cases x
  exact absurd hDerived Independence.brute_ungrounded.2

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨Independence.BruteEntity.brute, Independence.brute_ungrounded.1,
    Independence.brute_not_necessary⟩

end Brute

/-! ### NoSelfAccess: A5 fails

The actual world accesses only the other world, where nothing exists. The single
entity is actual and not necessary, and it is not contingent either, because
its existence is not possible from the actual world. So A4 holds vacuously. -/

namespace NoSelfAccess

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ w => w = .other }
  Entity := Unit
  actual := .actual
  existsAt := fun w _ => w = .actual
  directGrounds := fun _ _ _ => False
  created := fun _ => False

abbrev M := model

theorem a1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x := by
  intro w a x h
  exact False.elim h

theorem a2 : WellFounded (ActualGrounds M) := by
  constructor
  intro x
  apply Acc.intro
  intro y hy
  exact False.elim hy

theorem a4 : ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x _ hContingent
  rcases hContingent.1 with ⟨v, hAccess, hExists⟩
  have hv : v = TwoWorld.other := hAccess
  subst hv
  exact TwoWorld.noConfusion hExists

theorem a5_fails : ¬ M.frame.access M.actual M.actual := by
  intro h
  exact TwoWorld.noConfusion h

theorem grounding_necessitates : GroundingNecessitates M := by
  intro x hDerived
  rcases hDerived with ⟨_, h⟩
  exact False.elim h

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x := by
  refine ⟨(), rfl, ?_⟩
  intro hNecessary
  exact TwoWorld.noConfusion (hNecessary TwoWorld.other rfl)

end NoSelfAccess

/-! ### Non-redundancy of the four hypotheses of 5.2 -/

theorem a1_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}),
        WellFounded (ActualGrounds M) →
        (∀ x, Actual M x → Contingent M x → Derived M x) →
        M.frame.access M.actual M.actual →
        GroundingNecessitates M →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases UnactualGround.witness with ⟨x, hx, hNot⟩
  exact hNot (h UnactualGround.M UnactualGround.a2 UnactualGround.a4 UnactualGround.a5
    UnactualGround.grounding_necessitates x hx)

theorem a2_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}),
        (∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) →
        (∀ x, Actual M x → Contingent M x → Derived M x) →
        M.frame.access M.actual M.actual →
        GroundingNecessitates M →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases NecessitatingRegress.witness with ⟨x, hx, hNot⟩
  exact hNot (h NecessitatingRegress.M NecessitatingRegress.a1 NecessitatingRegress.a4
    NecessitatingRegress.a5 NecessitatingRegress.grounding_necessitates x hx)

theorem a4_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}),
        (∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) →
        WellFounded (ActualGrounds M) →
        M.frame.access M.actual M.actual →
        GroundingNecessitates M →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases Brute.witness with ⟨x, hx, hNot⟩
  exact hNot (h Brute.M Brute.a1 Brute.a2 Brute.a5 Brute.grounding_necessitates x hx)

theorem a5_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}),
        (∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) →
        WellFounded (ActualGrounds M) →
        (∀ x, Actual M x → Contingent M x → Derived M x) →
        GroundingNecessitates M →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases NoSelfAccess.witness with ⟨x, hx, hNot⟩
  exact hNot (h NoSelfAccess.M NoSelfAccess.a1 NoSelfAccess.a2 NoSelfAccess.a4
    NoSelfAccess.grounding_necessitates x hx)

/-! ### Both sides of the equivalence of 5.2 -/

/-! #### freeCreationModel: the non-necessitating side

The accepted model from `Logos.Models.Grounding.FreeCreation`. A1, A2, A4 and
A5 are proved here directly from its definitions. -/

namespace FreeCreation

abbrev M := FCM

theorem a1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x := by
  intro w a x h
  cases w <;> cases a <;> cases x <;>
    first
    | exact ⟨True.intro, True.intro⟩
    | exact False.elim h

theorem a2 : WellFounded (ActualGrounds M) := free_grounding_wellFounded

theorem a4 : ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x _ hContingent
  cases x with
  | ground =>
      rcases hContingent.2 with ⟨v, _, hNotExists⟩
      exact False.elim (hNotExists True.intro)
  | creature => exact ⟨FreeEntity.ground, free_ground_grounds_creature⟩

theorem a5 : M.frame.access M.actual M.actual := True.intro

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨FreeEntity.creature, free_creature_actual, free_creature_not_necessary⟩

/-- The accepted model of a necessary ground with a contingent creature has
grounding that does not necessitate. -/
theorem not_grounding_necessitates : ¬ GroundingNecessitates M := by
  intro hN
  rcases witness with ⟨x, hx, hNot⟩
  exact hNot (actual_necessary_of_groundingNecessitates a1 a2 a4 a5 hN x hx)

end FreeCreation

/-- Without necessitation the four hypotheses of 5.2 do not collapse
contingency: the accepted `freeCreationModel`. -/
theorem groundingNecessitates_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}),
        (∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) →
        WellFounded (ActualGrounds M) →
        (∀ x, Actual M x → Contingent M x → Derived M x) →
        M.frame.access M.actual M.actual →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases FreeCreation.witness with ⟨x, hx, hNot⟩
  exact hNot (h FreeCreation.M FreeCreation.a1 FreeCreation.a2 FreeCreation.a4
    FreeCreation.a5 x hx)

/-! #### NecessaryCreation: the necessitating side

A root grounds a dependent entity, both exist at both worlds, and both worlds
are accessible from the actual one. Necessity is stipulated by the model, but it
is not degenerate: the actual world accesses a second world. The name refers to
grounding only; the model's `created` predicate is empty. -/

namespace NecessaryCreation

inductive Entity where
  | root
  | creature
  deriving Repr, DecidableEq

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ _ => True }
  Entity := Entity
  actual := .actual
  existsAt := fun _ _ => True
  directGrounds := fun w a x => w = .actual ∧ a = .root ∧ x = .creature
  created := fun _ => False

abbrev M := model

theorem a1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x := by
  intro w a x _
  exact ⟨True.intro, True.intro⟩

theorem a2 : WellFounded (ActualGrounds M) := by
  constructor
  intro x
  have hRoot : Acc (ActualGrounds M) Entity.root := by
    apply Acc.intro
    intro y hy
    exact Entity.noConfusion hy.2.2
  cases x with
  | root => exact hRoot
  | creature =>
      apply Acc.intro
      intro y hy
      rcases hy with ⟨_, hy, _⟩
      subst hy
      exact hRoot

theorem a4 : ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x _ hContingent
  rcases hContingent.2 with ⟨v, _, hNotExists⟩
  exact False.elim (hNotExists True.intro)

theorem a5 : M.frame.access M.actual M.actual := True.intro

theorem all_necessary : ∀ x, Actual M x → Necessary M x :=
  fun _ _ _ _ => True.intro

theorem grounding_necessitates : GroundingNecessitates M :=
  groundingNecessitates_of_actual_necessary a1 all_necessary

theorem creature_derived : Derived M Entity.creature :=
  ⟨Entity.root, rfl, rfl, rfl⟩

theorem two_accessible_worlds :
    M.frame.access M.actual TwoWorld.actual ∧
      M.frame.access M.actual TwoWorld.other ∧
      TwoWorld.actual ≠ TwoWorld.other :=
  ⟨True.intro, True.intro, fun h => TwoWorld.noConfusion h⟩

end NecessaryCreation

/-! ## 5.5 Totality side

The three new totality models share one entity type: a root and an infinite
chain of nodes, each grounded at the actual world by the next. The totality
fact has a single inhabitant. -/

inductive TEntity where
  | root
  | node (n : Nat)
  deriving Repr, DecidableEq

def tDirectGrounds : TwoWorld → TEntity → TEntity → Prop
  | .actual, .node (Nat.succ n), .node m => m = n
  | _, _, _ => False

def tInsideNodes : TEntity → Prop
  | .root => False
  | .node _ => True

/-! ### NonNecessitatingExplainer: necessitation fails

The root exists at both worlds and the nodes only at the actual world. The
totality fact holds only at the actual world, and the root explains it there.
This has the shape of the accepted `Witnessed.NecessaryExplainer`. -/

namespace NonNecessitatingExplainer

def tExistsAt : TwoWorld → TEntity → Prop
  | _, .root => True
  | .actual, .node _ => True
  | .other, .node _ => False

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ _ => True }
  Entity := TEntity
  actual := .actual
  existsAt := tExistsAt
  directGrounds := tDirectGrounds
  created := fun _ => False

abbrev M := model

def facts : FactModel M where
  Fact := Unit
  holdsAt := fun w _ => w = .actual
  groundsFact := fun _ _ _ => False

abbrev F := facts

def regress : RegressTotality M F where
  node := TEntity.node
  step := fun n => show tDirectGrounds TwoWorld.actual (TEntity.node (n + 1)) (TEntity.node n)
    from rfl
  totality := ()
  actual_totality := rfl
  inside := tInsideNodes
  node_inside := fun _ => True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun w a _ => w = .actual ∧ a = .root

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun w a _ => w = .actual ∧ a = .root

abbrev E := entityExplanation

theorem root_necessary : Necessary M TEntity.root := fun _ _ => True.intro

theorem node_not_necessary (n : Nat) : ¬ Necessary M (TEntity.node n) := by
  intro hNecessary
  exact hNecessary TwoWorld.other True.intro

def core : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    rcases hExplain with ⟨_, ha⟩
    subst ha
    exact True.intro
  adequate_members := by
    intro a hExplain x hInside _
    rcases hExplain with ⟨_, ha⟩
    subst ha
    cases x with
    | root => exact False.elim hInside
    | node n => exact ⟨⟨rfl, rfl⟩, fun _ hEq => TEntity.noConfusion hEq⟩
  covers_nonNecessary := by
    intro x _ hNot
    cases x with
    | root => exact False.elim (hNot root_necessary)
    | node _ => exact True.intro

theorem local_sufficient : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨TEntity.root, rfl, rfl⟩

theorem totality_not_necessary : ¬ NecessaryFact F R.totality := by
  intro hNecessary
  exact TwoWorld.noConfusion (hNecessary TwoWorld.other True.intro)

theorem not_explanation_necessitates : ¬ ExplanationNecessitates G R.totality := by
  intro hN
  have hOther := hN ⟨TEntity.root, rfl, rfl⟩ TwoWorld.other True.intro
    (fun a ha => by
      rcases ha with ⟨_, ha⟩
      subst ha
      exact True.intro)
  exact TwoWorld.noConfusion hOther

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨TEntity.node 0, True.intro, node_not_necessary 0⟩

end NonNecessitatingExplainer

/-! ### SelfCitingExplainer: the core fails

The root exists at no world; the nodes exist only at the actual world, and node
`0` explains the totality fact. Wherever node `0` exists the totality fact holds,
so the explanation necessitates. Source actuality and completeness hold; the core
fails only at adequacy, because node `0` is not necessary and would have to
explain itself adequately. -/

namespace SelfCitingExplainer

def tExistsAt : TwoWorld → TEntity → Prop
  | _, .root => False
  | .actual, .node _ => True
  | .other, .node _ => False

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ _ => True }
  Entity := TEntity
  actual := .actual
  existsAt := tExistsAt
  directGrounds := tDirectGrounds
  created := fun _ => False

abbrev M := model

def facts : FactModel M where
  Fact := Unit
  holdsAt := fun w _ => w = .actual
  groundsFact := fun _ _ _ => False

abbrev F := facts

def regress : RegressTotality M F where
  node := TEntity.node
  step := fun n => show tDirectGrounds TwoWorld.actual (TEntity.node (n + 1)) (TEntity.node n)
    from rfl
  totality := ()
  actual_totality := rfl
  inside := tInsideNodes
  node_inside := fun _ => True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun w a _ => w = .actual ∧ a = .node 0

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun _ _ _ => True

abbrev E := entityExplanation

theorem node_not_necessary (n : Nat) : ¬ Necessary M (TEntity.node n) := by
  intro hNecessary
  exact hNecessary TwoWorld.other True.intro

theorem explanation_necessitates : ExplanationNecessitates G R.totality := by
  intro _ world _ hSources
  have hNode := hSources (TEntity.node 0) ⟨rfl, rfl⟩
  cases world with
  | actual => rfl
  | other => exact False.elim hNode

theorem local_sufficient : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨TEntity.node 0, rfl, rfl⟩

theorem totality_not_necessary : ¬ NecessaryFact F R.totality := by
  intro hNecessary
  exact TwoWorld.noConfusion (hNecessary TwoWorld.other True.intro)

theorem not_core : ¬ TotalityExplanationCore M F G E R := by
  intro A
  exact node_not_necessary 0
    (totality_explainer_is_necessary_from_core A (a := TEntity.node 0) ⟨rfl, rfl⟩)

theorem explains_source_actual_holds :
    ∀ {a}, ActualExplainsFact G a R.totality → Actual M a := by
  intro a hExplain
  rcases hExplain with ⟨_, ha⟩
  subst ha
  exact True.intro

theorem covers_nonNecessary_holds :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x := by
  intro x hx _
  cases x with
  | root => exact False.elim hx
  | node _ => exact True.intro

/-- The field of the core that fails: node `0` cannot adequately explain itself. -/
theorem adequacy_fails :
    ¬ (∀ {a}, ActualExplainsFact G a R.totality →
        ∀ {x}, R.inside x → Actual M x → AdequateExplainsEntity M E a x) := by
  intro h
  exact (h (a := TEntity.node 0) ⟨rfl, rfl⟩ (x := TEntity.node 0) True.intro True.intro).2
    (node_not_necessary 0) rfl

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨TEntity.node 0, True.intro, node_not_necessary 0⟩

end SelfCitingExplainer

/-! ### BruteTotality: local sufficient explanation fails

The accepted model from `Logos.Models.Grounding.FactSufficientExplanation`. The
totality fact is unexplained, so necessitation holds vacuously. -/

namespace BruteTotalityReuse

abbrev M := TotalityRegress.InternalGround.IM
abbrev F := TotalityRegress.InternalGround.IFM
abbrev R := TotalityRegress.InternalGround.IR
abbrev G := FactSufficientExplanation.BruteTotality.BG
abbrev E := FactSufficientExplanation.BruteTotality.BE

theorem core : TotalityExplanationCore M F G E R :=
  FactSufficientExplanation.BruteTotality.bruteCore

theorem explanation_necessitates : ExplanationNecessitates G R.totality :=
  fun hExplained =>
    absurd hExplained FactSufficientExplanation.BruteTotality.totality_notExplained

theorem not_local_sufficient : ¬ LocalFactSufficientExplanation G R.totality :=
  FactSufficientExplanation.BruteTotality.local_totality_EF4_fails

theorem totality_not_necessary : ¬ NecessaryFact F R.totality :=
  FactSufficientExplanation.BruteTotality.contingent_explanatory_absolute_totality.2.1

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  ⟨TotalityRegress.InternalGround.IEntity.node 0, True.intro,
    FactSufficientExplanation.BruteTotality.all_entities_nonNecessary _ True.intro⟩

end BruteTotalityReuse

/-! ### Non-redundancy of the three hypotheses of 5.3 -/

theorem explanationNecessitates_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}) (F : FactModel.{0, 0, 0} M)
        (G : FactGroundingRoles M F) (E : EntityExplanationModel M)
        (R : RegressTotality M F),
        TotalityExplanationCore M F G E R →
        LocalFactSufficientExplanation G R.totality →
        NecessaryFact F R.totality) := by
  intro h
  exact NonNecessitatingExplainer.totality_not_necessary
    (h _ _ _ _ _ NonNecessitatingExplainer.core NonNecessitatingExplainer.local_sufficient)

theorem localSufficientExplanation_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}) (F : FactModel.{0, 0, 0} M)
        (G : FactGroundingRoles M F) (E : EntityExplanationModel M)
        (R : RegressTotality M F),
        TotalityExplanationCore M F G E R →
        ExplanationNecessitates G R.totality →
        NecessaryFact F R.totality) := by
  intro h
  exact BruteTotalityReuse.totality_not_necessary
    (h _ _ _ _ _ BruteTotalityReuse.core BruteTotalityReuse.explanation_necessitates)

theorem core_needed :
    ¬ (∀ (M : Grounding.Model.{0, 0}) (F : FactModel.{0, 0, 0} M)
        (G : FactGroundingRoles M F) (R : RegressTotality M F),
        ExplanationNecessitates G R.totality →
        LocalFactSufficientExplanation G R.totality →
        NecessaryFact F R.totality) := by
  intro h
  exact SelfCitingExplainer.totality_not_necessary
    (h SelfCitingExplainer.M SelfCitingExplainer.F SelfCitingExplainer.G
      SelfCitingExplainer.R
      SelfCitingExplainer.explanation_necessitates SelfCitingExplainer.local_sufficient)

/-! ### Both sides of the equivalence of 5.3

`NonNecessitatingExplainer` is the non-necessitating side. `NecessaryTotality`
is the other: everything exists at both worlds, the totality fact holds at both,
and the root explains it. -/

namespace NecessaryTotality

def model : Grounding.Model where
  frame := { World := TwoWorld, access := fun _ _ => True }
  Entity := TEntity
  actual := .actual
  existsAt := fun _ _ => True
  directGrounds := tDirectGrounds
  created := fun _ => False

abbrev M := model

def facts : FactModel M where
  Fact := Unit
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

abbrev F := facts

def regress : RegressTotality M F where
  node := TEntity.node
  step := fun n => show tDirectGrounds TwoWorld.actual (TEntity.node (n + 1)) (TEntity.node n)
    from rfl
  totality := ()
  actual_totality := True.intro
  inside := tInsideNodes
  node_inside := fun _ => True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun w a _ => w = .actual ∧ a = .root

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun w a _ => w = .actual ∧ a = .root

abbrev E := entityExplanation

def core : TotalityExplanationCore M F G E R where
  explains_source_actual := fun _ => True.intro
  adequate_members := by
    intro a hExplain x _ _
    rcases hExplain with ⟨_, ha⟩
    subst ha
    exact ⟨⟨rfl, rfl⟩, fun hNot => absurd (fun _ _ => True.intro) hNot⟩
  covers_nonNecessary := by
    intro x _ hNot
    exact absurd (fun _ _ => True.intro) hNot

theorem local_sufficient : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨TEntity.root, rfl, rfl⟩

theorem totality_necessary : NecessaryFact F R.totality := fun _ _ => True.intro

theorem explanation_necessitates : ExplanationNecessitates G R.totality :=
  explanationNecessitates_of_necessaryFact totality_necessary

theorem explained : ExplainedFact G R.totality := ⟨TEntity.root, rfl, rfl⟩

theorem all_necessary : ∀ x, Actual M x → Necessary M x :=
  fun _ _ _ _ => True.intro

end NecessaryTotality

/-! ### LawlessNecessitation: W survives on the totality route without the law

Same entities and frame as `NonNecessitatingExplainer`, but the totality fact
holds at both worlds although the nodes exist only at the actual one. Without a
law tying the totality fact to its members, the core, local sufficient
explanation and necessitating explanation all hold while some actual entity is
not necessary. So on the totality route the step from 5.3 to the denial of `W`
needs the constitution law, as section 5.6 of the contract says. -/

namespace LawlessNecessitation

abbrev M := NonNecessitatingExplainer.M

def facts : FactModel M where
  Fact := Unit
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

abbrev F := facts

def regress : RegressTotality M F where
  node := TEntity.node
  step := fun n => show tDirectGrounds TwoWorld.actual (TEntity.node (n + 1)) (TEntity.node n)
    from rfl
  totality := ()
  actual_totality := True.intro
  inside := tInsideNodes
  node_inside := fun _ => True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun w a _ => w = .actual ∧ a = .root

abbrev G := roles

abbrev E := NonNecessitatingExplainer.E

def core : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    rcases hExplain with ⟨_, ha⟩
    subst ha
    exact True.intro
  adequate_members := by
    intro a hExplain x hInside _
    rcases hExplain with ⟨_, ha⟩
    subst ha
    cases x with
    | root => exact False.elim hInside
    | node n => exact ⟨⟨rfl, rfl⟩, fun _ hEq => TEntity.noConfusion hEq⟩
  covers_nonNecessary := by
    intro x _ hNot
    cases x with
    | root => exact False.elim (hNot NonNecessitatingExplainer.root_necessary)
    | node _ => exact True.intro

theorem local_sufficient : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨TEntity.root, rfl, rfl⟩

theorem totality_necessary : NecessaryFact F R.totality := fun _ _ => True.intro

theorem explanation_necessitates : ExplanationNecessitates G R.totality :=
  explanationNecessitates_of_necessaryFact totality_necessary

theorem witness : ∃ x, Actual M x ∧ ¬ Necessary M x :=
  NonNecessitatingExplainer.witness

end LawlessNecessitation

/-- The core, local sufficient explanation and necessitating explanation do not
make every actual entity necessary. On the totality route the collapse reaches
the totality fact (5.3) and stops there unless the fact is tied to its members. -/
theorem law_needed_for_W_reading :
    ¬ (∀ (M : Grounding.Model.{0, 0}) (F : FactModel.{0, 0, 0} M)
        (G : FactGroundingRoles M F) (E : EntityExplanationModel M)
        (R : RegressTotality M F),
        TotalityExplanationCore M F G E R →
        LocalFactSufficientExplanation G R.totality →
        ExplanationNecessitates G R.totality →
        ∀ x, Actual M x → Necessary M x) := by
  intro h
  rcases LawlessNecessitation.witness with ⟨x, hx, hNot⟩
  exact hNot (h _ _ _ _ _ LawlessNecessitation.core LawlessNecessitation.local_sufficient
    LawlessNecessitation.explanation_necessitates x hx)

end Necessitation
end GroundingModels
end Logos
