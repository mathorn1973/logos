import Logos.Systems.GroundedModality.Theorems
import Logos.Models.Grounding.FactSufficientExplanation
import Logos.Models.Grounding.TotalityExternality

namespace Logos
namespace GroundingModels
namespace GroundedModality

open Grounding

/-! ## 1. Fully unconditioned but contingent if brute modal edges are allowed -/

namespace BruteUnlicensed

open FactSufficientExplanation.BruteTotality
open TotalityExternality.InternalExplanation
open TotalityExplanationScope.SelfExplanation

inductive NoCondition

/-- No modal condition exists at all.  Raw Kripke accessibility remains exactly
as in the contingent brute-totality model. -/
def variationModel : ModalVariationModel IM IFM where
  Condition := NoCondition
  availableAt := fun _ c => nomatch c
  licensesFailure := fun c _ _ => nomatch c

abbrev V := variationModel

theorem modally_unconditioned :
    ModallyUnconditionedFact V IR.totality := by
  constructor
  · exact IR.actual_totality
  · intro hGrounded
    rcases hGrounded with ⟨world, hAccess, hNotHolds, c, hcActual, hcLicense⟩
    exact nomatch c

/-- The totality is explanatorily absolute in the existing brute model. -/
theorem explanatorily_absolute :
    ExplanatorilyAbsoluteFact BG IR.totality :=
  contingentAbsolute_is_explanatorilyAbsolute
    contingent_explanatory_absolute_totality

/-- Hence it is fully unconditioned according to the two structural notions,
yet still not necessary because the accessible counterexample is brute. -/
theorem fully_unconditioned :
    FullyUnconditionedFact BG V IR.totality :=
  ⟨explanatorily_absolute, modally_unconditioned⟩

theorem not_necessary :
    ¬ NecessaryFact IFM IR.totality := totality_nonNecessary

/-- No-brute-modality fails exactly at the `absent` world. -/
theorem noBruteModalVariation_fails :
    ¬ NoBruteModalVariationAt V IR.totality := by
  intro hNoBrute
  have hAccess : IM.frame.access IM.actual IWorld.absent := True.intro
  have hNotHolds : ¬ IFM.holdsAt IWorld.absent IR.totality := by
    intro h
    exact h
  rcases hNoBrute IWorld.absent hAccess hNotHolds with ⟨c, hcActual, hcLicense⟩
  exact nomatch c

end BruteUnlicensed

/-! ## 2. No-brute modality does not imply sufficient explanation -/

namespace ConditionedBrute

open FactSufficientExplanation.BruteTotality
open TotalityExternality.InternalExplanation
open TotalityExplanationScope.SelfExplanation

inductive Condition where
  | absenceLicense
  deriving Repr, DecidableEq

/-- The alternative where the totality fact fails is explicitly licensed by a
modal condition.  The explanatory relation remains empty. -/
def variationModel : ModalVariationModel IM IFM where
  Condition := Condition
  availableAt := fun world _ => world = IWorld.actual
  licensesFailure := fun condition fact world =>
    match condition, fact, world with
    | .absenceLicense, .totality, .absent => True
    | _, _, _ => False

abbrev V := variationModel

theorem no_brute_modal_variation :
    NoBruteModalVariationAt V IR.totality := by
  intro world hAccess hNotHolds
  cases world with
  | actual =>
      exact False.elim (hNotHolds IR.actual_totality)
  | absent =>
      refine ⟨Condition.absenceLicense, ?_, ?_⟩
      · rfl
      · exact True.intro

theorem grounded_failure_possible :
    GroundedFailurePossible V IR.totality := by
  refine ⟨IWorld.absent, True.intro, ?_, Condition.absenceLicense, rfl, True.intro⟩
  intro h
  exact h

/-- The fact remains explanatorily absolute and non-necessary.  Thus grounded
modal variation by itself does not supply an explanation of actuality. -/
theorem explanatorily_absolute :
    ExplanatorilyAbsoluteFact BG IR.totality :=
  contingentAbsolute_is_explanatorilyAbsolute
    contingent_explanatory_absolute_totality

theorem local_EF4_fails :
    ¬ LocalFactSufficientExplanation BG IR.totality :=
  local_totality_EF4_fails

theorem not_necessary :
    ¬ NecessaryFact IFM IR.totality := totality_nonNecessary

end ConditionedBrute

/-! ## 3. Sufficient explanation does not imply no-brute modality -/

namespace ExplainedButBruteModal

open TotalityExternality

inductive NoCondition

/-- Remove all modal conditions from the positive explained-totality model. -/
def variationModel : ModalVariationModel M F where
  Condition := NoCondition
  availableAt := fun _ c => nomatch c
  licensesFailure := fun c _ _ => nomatch c

abbrev V := variationModel

/-- The totality fact has an explanatory source whenever it is non-necessary. -/
theorem local_EF4_holds : LocalFactSufficientExplanation G R.totality := by
  intro hNotNecessary
  exact ⟨Entity.root, root_explains⟩

/-- Yet no-brute-modality fails because the stripped alternative has no modal
condition at all. -/
theorem noBruteModalVariation_fails :
    ¬ NoBruteModalVariationAt V R.totality := by
  intro hNoBrute
  have hAccess : M.frame.access M.actual World.stripped := True.intro
  have hNotHolds : ¬ F.holdsAt World.stripped R.totality := by
    intro h
    exact h
  rcases hNoBrute World.stripped hAccess hNotHolds with ⟨c, hcActual, hcLicense⟩
  exact nomatch c

end ExplainedButBruteModal

end GroundedModality
end GroundingModels
end Logos
