import Logos.Systems.ContingentAbsolute.Theorems
import Logos.Models.Grounding.FactSufficientExplanation
import Logos.Models.Grounding.TotalityExternality

namespace Logos
namespace GroundingModels
namespace ContingentAbsolute

open Grounding

/-! ## Explanatory absoluteness does not imply modal necessity -/

namespace BruteTotality

open FactSufficientExplanation.BruteTotality
open TotalityExternality.InternalExplanation
open TotalityExplanationScope.SelfExplanation

/-- The existing brute-totality model is explanatorily absolute. -/
theorem explanatory_absolute :
    ExplanatorilyAbsoluteFact BG IR.totality :=
  contingentAbsolute_is_explanatorilyAbsolute
    contingent_explanatory_absolute_totality

/-- But it is explicitly not necessary. -/
theorem not_modally_necessary :
    ¬ NecessaryFact IFM IR.totality := totality_nonNecessary

/-- Hence explanatory ultimacy alone does not imply modal necessity in the
current semantics. -/
theorem ultimacy_does_not_imply_necessity :
    ¬ UltimateModalStabilityAt BG IR.totality := by
  intro hStability
  exact not_modally_necessary (hStability explanatory_absolute)

/-- The same model realizes the more explicit brute-modal-asymmetry reading. -/
theorem brute_modal_asymmetry :
    BruteModalAsymmetryFact BG IR.totality :=
  contingentAbsolute_iff_bruteModalAsymmetry.mp
    contingent_explanatory_absolute_totality

end BruteTotality

/-! ## Modal necessity does not imply explanatory absoluteness -/

namespace NecessaryExplained

open TotalityExternality

inductive NFact where
  | stable
  deriving Repr, DecidableEq

/-- A fact that holds in every world of the existing two-world model. -/
def holdsAt : World → NFact → Prop := fun _ _ => True

def groundsFact : World → Entity → NFact → Prop
  | .actual, .root, .stable => True
  | _, _, _ => False

def factModel : FactModel M where
  Fact := NFact
  holdsAt := holdsAt
  groundsFact := groundsFact

abbrev NF := factModel

def roles : FactGroundingRoles M NF where
  constitutesFact := fun _ _ _ => False
  explainsFact := fun world entity fact =>
    match world, entity, fact with
    | .actual, .root, .stable => True
    | _, _, _ => False

abbrev NG := roles

theorem stable_actual : ActualFact NF NFact.stable := True.intro

theorem stable_necessary : NecessaryFact NF NFact.stable := by
  intro world hAccess
  exact True.intro

theorem stable_modally_absolute : ModallyAbsoluteFact (F := NF) NFact.stable :=
  ⟨stable_actual, stable_necessary⟩

theorem root_explains_stable :
    ActualExplainsFact NG Entity.root NFact.stable := True.intro

theorem stable_not_explanatorily_absolute :
    ¬ ExplanatorilyAbsoluteFact NG NFact.stable := by
  intro hAbsolute
  exact hAbsolute.2 ⟨Entity.root, root_explains_stable⟩

end NecessaryExplained

end ContingentAbsolute
end GroundingModels
end Logos
