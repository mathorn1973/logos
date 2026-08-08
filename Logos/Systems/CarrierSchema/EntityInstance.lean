import Logos.Systems.CarrierSchema.Theorems
import Logos.Systems.FactSufficientExplanation.Axioms

universe u v w

namespace Logos
namespace Grounding

/-- The carrier the accepted route actually uses: entities, with the totality
fact as the designated target. -/
def entityScopeCarrier
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F)
    (E : EntityExplanationModel M)
    (R : RegressTotality M F) :
    ScopeCarrier M.Entity where
  Actual := Actual M
  Necessary := Necessary M
  Inside := R.inside
  Explains := fun a => ActualExplainsFact G a R.totality
  Adequate := AdequateExplainsEntity M E

/-- `TotalityExplanationCore` is the closure record at the entity carrier.

The first three fields transfer unchanged.  The fourth, which has to be assumed
at an arbitrary carrier, is discharged here because `AdequateExplainsEntity`
builds the contingent-propriety condition into its definition. -/
def TotalityExplanationCore.toScopeClosureAxioms
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R) :
    ScopeClosureAxioms (entityScopeCarrier G E R) where
  explains_source_actual := by
    intro a hExplains
    exact A.explains_source_actual hExplains
  covers_nonNecessary := by
    intro a ha hNotNecessary
    exact A.covers_nonNecessary a ha hNotNecessary
  adequate_members := by
    intro a hExplains x hInside hx
    exact A.adequate_members hExplains hInside hx
  adequacy_excludes_contingent_self := by
    intro a hNotNecessary hAdequate
    exact hAdequate.2 hNotNecessary rfl

/-- The accepted theorem is the schema read at the entity carrier.

This is the load-bearing claim of the cut: `totality_explainer_is_necessary_from_core`
is not merely analogous to the carrier-neutral engine, it is that engine
instantiated.  Anything the schema says therefore already applies to the
accepted route. -/
theorem totality_explainer_is_necessary_via_schema
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality) :
    Necessary M a :=
  closure_explainer_is_necessary A.toScopeClosureAxioms hExplain

/-- Corollary at the entity carrier: a contingent explainer of the totality
fact refutes the core outright. -/
theorem contingent_totality_explainer_refutes_core
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    {a : M.Entity}
    (hExplain : ActualExplainsFact G a R.totality)
    (hNotNecessary : ¬ Necessary M a) :
    ¬ TotalityExplanationCore M F G E R :=
  fun A => hNotNecessary (totality_explainer_is_necessary_via_schema A hExplain)

end Grounding
end Logos
