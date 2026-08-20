import Logos.Systems.FactSufficientExplanation.Theorems
import Logos.Models.Grounding.TotalityExternality

namespace Logos
namespace GroundingModels
namespace FactSufficientExplanation

open Grounding

/-! ## Global EF4 is stronger than needed -/

namespace LocalNotGlobal

open TotalityExternalityComparison.MixedRoles

/-- Two facts: the regress totality and an unrelated contingent brute fact. -/
inductive LFact where
  | totality
  | irrelevant
  deriving Repr, DecidableEq

def lHoldsAt : World → LFact → Prop
  | .actual, _ => True
  | .stripped, _ => False

def lGroundsFact : World → Entity → LFact → Prop
  | .actual, .root, .totality => True
  | _, _, _ => False

def lFactModel : FactModel M where
  Fact := LFact
  holdsAt := lHoldsAt
  groundsFact := lGroundsFact

abbrev LF := lFactModel

def lRoles : FactGroundingRoles M LF where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .totality => True
    | _, _, _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .root, .totality => True
    | _, _, _ => False

abbrev LG := lRoles

def lEntityExplanation : EntityExplanationModel M where
  explainsEntity := fun world a x =>
    match world, a, x with
    | .actual, .root, .node _ => True
    | _, _, _ => False

abbrev LE := lEntityExplanation

theorem lRegressStep (n : Nat) :
    ActualGrounds M (Entity.node (n + 1)) (Entity.node n) :=
  regress_step n

def lRegress : RegressTotality M LF where
  node := Entity.node
  step := lRegressStep
  totality := LFact.totality
  actual_totality := True.intro
  inside := inside
  node_inside := by intro n; exact True.intro

abbrev LR := lRegress

theorem lRootExplainsTotality :
    ActualExplainsFact LG Entity.root LR.totality := True.intro

theorem irrelevant_actual : ActualFact LF LFact.irrelevant := True.intro

theorem irrelevant_notNecessary :
    ¬ NecessaryFact LF LFact.irrelevant := by
  intro hNecessary
  exact hNecessary World.stripped True.intro

theorem irrelevant_notExplained :
    ¬ ExplainedFact LG LFact.irrelevant := by
  intro h
  rcases h with ⟨a, ha⟩
  cases a with
  | root => exact ha
  | node n => exact ha

/-- The old global EF4 field fails because the unrelated fact is brute. -/
theorem global_fact_EF4_fails :
    ¬ (∀ p, ActualFact LF p → ¬ NecessaryFact LF p → ExplainedFact LG p) := by
  intro hGlobal
  exact irrelevant_notExplained
    (hGlobal LFact.irrelevant irrelevant_actual irrelevant_notNecessary)

def localCore : TotalityExplanationCore M LF LG LE LR where
  explains_source_actual := by
    intro a hExplain
    cases a with
    | root => exact TotalityExternality.Positive.root_actual
    | node n => exact False.elim hExplain

  adequate_members := by
    intro a hExplain x hInside hx
    cases a with
    | root =>
        cases x with
        | root => exact False.elim hInside
        | node n =>
            constructor
            · exact True.intro
            · intro hNot hEq
              cases hEq
    | node n => exact False.elim hExplain

  covers_nonNecessary := by
    intro x hx hNotNecessary
    cases x with
    | root => exact False.elim (hNotNecessary TotalityExternality.Positive.root_necessary)
    | node n => exact True.intro

theorem local_totality_EF4_holds :
    LocalFactSufficientExplanation LG LR.totality := by
  intro hNotNecessary
  exact ⟨Entity.root, lRootExplainsTotality⟩

def localAxioms :
    LocalTotalitySufficientExplanationAxioms M LF LG LE LR where
  toTotalityExplanationCore := localCore
  totality_sufficient := local_totality_EF4_holds

/-- The necessary-reality result needs only local EF4 even though global EF4
fails elsewhere in the same fact language. -/
theorem necessary_reality_survives_global_EF4_failure :
    NecessaryFact LF LR.totality ∨
      ∃ a, Actual M a ∧ Necessary M a ∧
        ActualExplainsFact LG a LR.totality :=
  local_totality_sufficient_explanation_forces_necessary_reality localAxioms

end LocalNotGlobal

/-! ## Rejecting local EF4 produces a contingent explanatory absolute -/

namespace BruteTotality

open TotalityRegress.InternalGround
open TotalityExternality.NoIrreflexivity

/-- Keep the same genuinely infinite contingent entity regress but remove every
explanatory source for its totality fact. -/
def noExplanationRoles : FactGroundingRoles IM IFM where
  constitutesFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .node _, .regressTotality => True
    | _, _, _ => False
  explainsFact := fun _ _ _ => False

abbrev BG := noExplanationRoles

/-- The raw entity explanation graph is irrelevant here; no entity explains the
totality fact.  We reuse the existing self-citation graph to stress that the
core does not globally regulate explanation. -/
abbrev BE := E

def bruteCore : TotalityExplanationCore IM IFM BG BE IR where
  explains_source_actual := by
    intro a hExplain
    exact False.elim hExplain

  adequate_members := by
    intro a hExplain x hInside hx
    exact False.elim hExplain

  covers_nonNecessary := by
    intro x hx hNotNecessary
    exact True.intro

theorem totality_notExplained :
    ¬ ExplainedFact BG IR.totality := by
  intro h
  rcases h with ⟨a, ha⟩
  exact ha

theorem contingent_explanatory_absolute_totality :
    ContingentExplanatoryAbsoluteFact BG IR.totality :=
  ⟨IR.actual_totality, internal_totality_not_necessary, totality_notExplained⟩

/-- Local EF4 fails exactly because the contingent totality is accepted as an
unexplained ultimate fact. -/
theorem local_totality_EF4_fails :
    ¬ LocalFactSufficientExplanation BG IR.totality := by
  exact (not_localFactSufficientExplanation_iff_contingentAbsolute
    (G := BG) IR.actual_totality).2 contingent_explanatory_absolute_totality

/-- All entities remain non-necessary in the brute-totality model. -/
theorem all_entities_nonNecessary :
    ∀ x, Actual IM x → ¬ Necessary IM x :=
  every_internal_entity_nonNecessary

/-- The abstract theorem reconstructs the same result: if one insists on pure
contingency, the totality fact must become a contingent explanatory absolute. -/
theorem pure_contingency_relocates_ultimacy_to_totality_fact :
    ContingentExplanatoryAbsoluteFact BG IR.totality :=
  pure_contingency_forces_contingent_explanatory_absolute
    bruteCore internal_totality_not_necessary all_entities_nonNecessary

end BruteTotality

end FactSufficientExplanation
end GroundingModels
end Logos
