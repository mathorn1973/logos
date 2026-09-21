import Logos.Systems.TotalityConstitution.Theorems
import Logos.Models.Grounding.MinimalNecessity

namespace Logos
namespace GroundingModels
namespace TotalityConstitution

open Grounding

/-! # Independence models for TOTALITY-CONSTITUTION-1

Four models under the accepted `TotalityExplanationCore`, separating the
constitution law from the contingency witness `W`, and one reuse of an
accepted model on the foundation side. Section numbers refer to
`TOTALITY-CONSTITUTION-CONTRACT.md`. -/

/-! ## 5.5 Necessitarian: law and core, no witness

Every member exists at every world, so every member is necessary, `W` fails,
and the constituted totality fact is necessary. The frame has two worlds and
every world accesses every world, so `W` fails because nothing is contingent
and not because the frame is degenerate. -/

namespace Necessitarian

inductive World where
  | actual
  | other
  deriving Repr, DecidableEq

inductive Entity where
  | node (n : Nat)
  deriving Repr, DecidableEq

def access : World → World → Prop := fun _ _ => True

def existsAt : World → Entity → Prop := fun _ _ => True

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

def inside : Entity → Prop := fun _ => True

def noGrounds : World → Entity → PUnit.{1} → Prop := fun _ _ _ => False

abbrev F := constitutedFacts M inside noGrounds

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := rfl

theorem members_actual : ∀ x, inside x → Actual M x := fun _ _ => True.intro

def regress : RegressTotality M F :=
  constitutedRegress M inside noGrounds Entity.node regress_step
    (fun _ => True.intro) members_actual

abbrev R := regress

/-- The law holds by construction. -/
theorem law : ConstitutedTotality F R :=
  constitutedRegress_law M inside noGrounds Entity.node regress_step
    (fun _ => True.intro) members_actual

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun _ _ _ => False

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun _ _ _ => False

abbrev E := entityExplanation

theorem node_necessary (n : Nat) : Necessary M (Entity.node n) :=
  fun _ _ => True.intro

/-- The core holds. Nothing explains anything, so the first two conditions
are vacuous, and completeness is vacuous because nothing is non-necessary. -/
def explanationCore : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    exact False.elim hExplain
  adequate_members := by
    intro a hExplain
    exact False.elim hExplain
  covers_nonNecessary := by
    intro x _ hNotNecessary
    cases x with
    | node n => exact False.elim (hNotNecessary (node_necessary n))

/-- `W` fails: every entity is necessary. -/
theorem no_witness : ¬ ContingencyWitness M := by
  rintro ⟨x, _, hNotNecessary⟩
  cases x with
  | node n => exact hNotNecessary (node_necessary n)

/-- The first disjunct holds. -/
theorem totality_necessary : NecessaryFact F R.totality :=
  fun _ _ _ _ => True.intro

/-- T6: the actual world accesses a world other than itself, so the failure
of `W` is not a frame artefact. -/
theorem not_singleSuccessor : ¬ SingleSuccessor M := by
  intro hSingle
  have h := hSingle World.other True.intro
  cases h

end Necessitarian

/-! ## 5.5 BareWitness: witness and core, no law

The totality fact is a designated fact obtaining at every world, while a
member fails to exist at one of them. `W` holds, the core holds, the law
fails, and the first disjunct still holds. The law is what makes `W` bite. -/

namespace BareWitness

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

/-- The designated fact obtains everywhere, regardless of its members. -/
def facts : FactModel M where
  Fact := Fact
  holdsAt := fun _ _ => True
  groundsFact := fun _ _ _ => False

abbrev F := facts

def inside : Entity → Prop
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
  node_inside := fun _ => True.intro

abbrev R := regress

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun _ _ _ => False

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun _ _ _ => False

abbrev E := entityExplanation

theorem root_necessary : Necessary M Entity.root := by
  intro world _
  cases world <;> exact True.intro

def explanationCore : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    exact False.elim hExplain
  adequate_members := by
    intro a hExplain
    exact False.elim hExplain
  covers_nonNecessary := by
    intro x _ hNotNecessary
    cases x with
    | root => exact False.elim (hNotNecessary root_necessary)
    | node n => exact True.intro

/-- `W` holds at `node 0`. -/
theorem witness : ContingencyWitness M :=
  ⟨Entity.node 0, True.intro, fun hNecessary => hNecessary World.stripped True.intro⟩

/-- T7: the forward half of the law fails, at the stripped world and `node 0`. -/
theorem law_fails : ¬ TotalityRequiresMembers F R := by
  intro hLaw
  exact hLaw World.stripped True.intro (Entity.node 0) True.intro

/-- The first disjunct holds despite `W`. -/
theorem totality_necessary : NecessaryFact F R.totality :=
  fun _ _ => True.intro

end BareWitness

/-! ## 5.5 Witnessed: law, core and witness

One model of `M`, `F` and `R`, shared by the two remaining witnesses, which
differ only in the explanatory roles. `root` exists at every world, the nodes
only at the actual world, and the totality is constituted by the nodes. -/

namespace Witnessed

inductive World where
  | actual
  | stripped
  deriving Repr, DecidableEq

inductive Entity where
  | root
  | node (n : Nat)
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

def inside : Entity → Prop
  | .root => False
  | .node _ => True

def noGrounds : World → Entity → PUnit.{1} → Prop := fun _ _ _ => False

abbrev F := constitutedFacts M inside noGrounds

theorem regress_step (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) := rfl

theorem members_actual : ∀ x, inside x → Actual M x := by
  intro x hInside
  cases x with
  | root => exact False.elim hInside
  | node n => exact True.intro

def regress : RegressTotality M F :=
  constitutedRegress M inside noGrounds Entity.node regress_step
    (fun _ => True.intro) members_actual

abbrev R := regress

theorem law : ConstitutedTotality F R :=
  constitutedRegress_law M inside noGrounds Entity.node regress_step
    (fun _ => True.intro) members_actual

theorem root_necessary : Necessary M Entity.root := by
  intro world _
  cases world <;> exact True.intro

theorem node_not_necessary (n : Nat) : ¬ Necessary M (Entity.node n) :=
  fun hNecessary => hNecessary World.stripped True.intro

theorem witness : ContingencyWitness M :=
  ⟨Entity.node 0, True.intro, node_not_necessary 0⟩

/-- The constituted totality fact is not necessary, through the general
theorem and not by inspection. -/
theorem totality_not_necessary : ¬ NecessaryFact F R.totality :=
  not_necessaryFact_of_member_not_necessary
    (TotalityRequiresMembers.of_constituted law) (x := Entity.node 0)
    True.intro (node_not_necessary 0)

theorem totality_actual : ActualFact F R.totality := members_actual

theorem covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x := by
  intro x _ hNotNecessary
  cases x with
  | root => exact False.elim (hNotNecessary root_necessary)
  | node n => exact True.intro

/-! ### NecessaryExplainer: the middle disjunct is inhabited -/

namespace NecessaryExplainer

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun world a _ =>
    match world, a with
    | .actual, .root => True
    | _, _ => False

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .node _ => True
    | _, _, _ => False

abbrev E := entityExplanation

theorem root_explains : ActualExplainsFact G Entity.root R.totality := True.intro

def explanationCore : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    cases a with
    | root => exact True.intro
    | node n => exact False.elim hExplain
  adequate_members := by
    intro a hExplain x hInside _
    cases a with
    | root =>
        cases x with
        | root => exact False.elim hInside
        | node n => exact ⟨True.intro, by intro _ hEq; cases hEq⟩
    | node n => exact False.elim hExplain
  covers_nonNecessary := covers_nonNecessary

/-- The dichotomy lands on its first disjunct here. -/
theorem middle_disjunct :
    ∃ a, Actual M a ∧ Necessary M a ∧ ActualExplainsFact G a R.totality :=
  ⟨Entity.root, True.intro, root_necessary, root_explains⟩

theorem not_contingent_absolute : ¬ ContingentExplanatoryAbsoluteFact G R.totality :=
  fun hAbsolute => hAbsolute.2.2 ⟨Entity.root, root_explains⟩

theorem local_ef4_holds : LocalFactSufficientExplanation G R.totality :=
  fun _ => ⟨Entity.root, root_explains⟩

end NecessaryExplainer

/-! ### ContingentAbsolute: the third disjunct is inhabited -/

namespace ContingentAbsolute

def roles : FactGroundingRoles M F where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun _ _ _ => False

abbrev G := roles

def entityExplanation : EntityExplanationModel M where
  explainsEntity := fun _ _ _ => False

abbrev E := entityExplanation

def explanationCore : TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    exact False.elim hExplain
  adequate_members := by
    intro a hExplain
    exact False.elim hExplain
  covers_nonNecessary := covers_nonNecessary

theorem unexplained : ¬ ExplainedFact G R.totality :=
  fun ⟨_, hExplain⟩ => hExplain

/-- The dichotomy lands on its second disjunct here. -/
theorem third_disjunct : ContingentExplanatoryAbsoluteFact G R.totality :=
  ⟨totality_actual, totality_not_necessary, unexplained⟩

theorem no_necessary_explainer :
    ¬ ∃ a, Actual M a ∧ Necessary M a ∧ ActualExplainsFact G a R.totality :=
  fun ⟨_, _, _, hExplain⟩ => hExplain

theorem local_ef4_fails : ¬ LocalFactSufficientExplanation G R.totality :=
  fun hLocal => unexplained (hLocal totality_not_necessary)

end ContingentAbsolute

end Witnessed

/-! ## 5.8 An accepted model is degenerate

`twoRootModel` has one world, so it is a single-successor frame. Its two
necessary ungrounded roots are necessary in the degenerate sense, and `W`
fails there. This records what that model's `Necessary` means; it does not
touch what the model was accepted for, which is the independence of `A3`. -/

namespace TwoRootDegenerate

open Independence

theorem twoRoot_singleSuccessor : SingleSuccessor TRM := by
  intro world _
  cases world
  rfl

theorem twoRoot_reflexive : TRM.frame.access TRM.actual TRM.actual := True.intro

theorem twoRoot_necessary_iff_actual (x : TRM.Entity) :
    Necessary TRM x ↔ Actual TRM x :=
  necessary_iff_actual_of_singleSuccessor twoRoot_singleSuccessor twoRoot_reflexive x

theorem twoRoot_no_witness : ¬ ContingencyWitness TRM := by
  intro hW
  exact not_singleSuccessor_of_contingencyWitness hW twoRoot_singleSuccessor

/-- In that model the central theorem's conclusion is the conclusion of
`exists_ungrounded`. -/
theorem twoRoot_necessity_is_free :
    (∃ e, Ungrounded TRM e ∧ Necessary TRM e) ↔ ∃ e, Ungrounded TRM e :=
  exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor
    twoRoot_singleSuccessor twoRoot_reflexive

end TwoRootDegenerate

end TotalityConstitution
end GroundingModels
end Logos
