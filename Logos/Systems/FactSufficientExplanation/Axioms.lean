import Logos.Ontology.Grounding.ExplanatoryAbsolute
import Logos.Systems.SelfExplanation.AdequateScopeAxioms

universe u v w

namespace Logos
namespace Grounding

/-- The explanation-theoretic core needed once a source for the totality fact
is available.  It deliberately contains no principle asserting that such a
source must exist. -/
structure TotalityExplanationCore
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop where
  /-- Any source that explains the actual totality fact is itself actual. -/
  explains_source_actual :
    ∀ {a}, ActualExplainsFact G a R.totality → Actual M a

  /-- The explanations delivered by the totality explanation are locally adequate. -/
  adequate_members :
    ∀ {a}, ActualExplainsFact G a R.totality →
      ∀ {x}, R.inside x → Actual M x →
        AdequateExplainsEntity M E a x

  /-- The represented totality contains every actual non-necessary entity. -/
  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

/-- Add only the local sufficient-explanation principle for the designated
totality fact.  No claim about unrelated facts is included. -/
structure LocalTotalitySufficientExplanationAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) : Prop
    extends TotalityExplanationCore M F G E R where
  totality_sufficient : LocalFactSufficientExplanation G R.totality

/-- The previous EF4-based local-adequacy package implies the EF4-free core. -/
def AdequateTotalityScopeAxioms.toTotalityExplanationCore
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : AdequateTotalityScopeAxioms M F G E R) :
    TotalityExplanationCore M F G E R where
  explains_source_actual := by
    intro a hExplain
    exact (A.explains_existents hExplain).1
  adequate_members := A.adequate_members
  covers_nonNecessary := A.covers_nonNecessary

/-- Global fact-level EF4 implies the much weaker local principle for the one
totality fact used by the argument. -/
def AdequateTotalityScopeAxioms.toLocalTotalitySufficientExplanationAxioms
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : AdequateTotalityScopeAxioms M F G E R) :
    LocalTotalitySufficientExplanationAxioms M F G E R where
  toTotalityExplanationCore := A.toTotalityExplanationCore
  totality_sufficient := by
    intro hNotNecessary
    exact A.nonNecessaryFact_is_explained
      R.totality R.actual_totality hNotNecessary

end Grounding
end Logos
