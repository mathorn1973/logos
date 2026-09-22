import Logos

/-! # NECESSITATION-1 audit

Boundary pins: if a statement below is strengthened, for instance by adding A0,
the constitution law or `W` to a hypothesis list, the wrapper stops elaborating.
Then the axioms of every result of the cut are printed. -/

universe u v w

namespace Logos
namespace Grounding

/-- 5.2 needs A1, A2, A4 and A5 and nothing else; A0 is absent. -/
theorem audit_necessitation_foundation_boundary
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hA2 : WellFounded (ActualGrounds M))
    (hA4 : ∀ x, Actual M x → Contingent M x → Derived M x)
    (hA5 : M.frame.access M.actual M.actual) :
    GroundingNecessitates M ↔ ∀ x, Actual M x → Necessary M x :=
  groundingNecessitates_iff_actual_necessary hA1 hA2 hA4 hA5

/-- The weaker link form: necessitation only at links out of necessary grounds. -/
theorem audit_necessitation_links_boundary
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hA2 : WellFounded (ActualGrounds M))
    (hA4 : ∀ x, Actual M x → Contingent M x → Derived M x)
    (hA5 : M.frame.access M.actual M.actual)
    (hLinks : ∀ x, Derived M x → (∀ a, ActualGrounds M a x → Necessary M a) →
      box M.frame
        (fun world => (∀ a, ActualGrounds M a x → M.existsAt world a) → M.existsAt world x)
        M.actual) :
    ∀ x, Actual M x → Necessary M x :=
  actual_necessary_of_necessary_links hA1 hA2 hA4 hA5 hLinks

/-- The converse of 5.2 needs A1 only. -/
theorem audit_necessitation_foundation_converse_boundary
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x) :
    (∀ x, Actual M x → Necessary M x) → GroundingNecessitates M :=
  groundingNecessitates_of_actual_necessary hA1

/-- 5.3 needs the core and local sufficient explanation; no law, no `W`, no A2. -/
theorem audit_necessitation_totality_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hLocal : LocalFactSufficientExplanation G R.totality) :
    ExplanationNecessitates G R.totality ↔ NecessaryFact F R.totality :=
  explanationNecessitates_iff_necessaryFact A hLocal

/-- The first statement of 5.3 needs the core only. -/
theorem audit_necessitation_totality_core_boundary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R) :
    ExplanationNecessitates G R.totality →
      NecessaryFact F R.totality ∨ ContingentExplanatoryAbsoluteFact G R.totality :=
  necessaryFact_or_contingentAbsolute_of_explanationNecessitates A

end Grounding
end Logos

-- 5.1, predicted axiom-free
#print axioms Logos.Grounding.necessary_of_groundingNecessitates
#print axioms Logos.Grounding.necessaryFact_of_explanationNecessitates

-- 5.2
#print axioms Logos.Grounding.actual_necessary_of_necessary_links
#print axioms Logos.Grounding.actual_necessary_of_groundingNecessitates
#print axioms Logos.Grounding.groundingNecessitates_of_actual_necessary
#print axioms Logos.Grounding.groundingNecessitates_iff_actual_necessary
#print axioms Logos.Grounding.actual_necessary_of_necessaryExistenceAxioms_of_groundingNecessitates

-- 5.3
#print axioms Logos.Grounding.necessaryFact_or_contingentAbsolute_of_explanationNecessitates
#print axioms Logos.Grounding.explanationNecessitates_iff_explained_imp_necessaryFact
#print axioms Logos.Grounding.necessaryFact_of_localSufficientExplanation_of_explanationNecessitates
#print axioms Logos.Grounding.explanationNecessitates_of_necessaryFact
#print axioms Logos.Grounding.explanationNecessitates_iff_necessaryFact

-- 5.4
#print axioms Logos.GroundingModels.Necessitation.a1_needed
#print axioms Logos.GroundingModels.Necessitation.a2_needed
#print axioms Logos.GroundingModels.Necessitation.a4_needed
#print axioms Logos.GroundingModels.Necessitation.a5_needed
#print axioms Logos.GroundingModels.Necessitation.groundingNecessitates_needed
#print axioms Logos.GroundingModels.Necessitation.UnactualGround.ground_exists_somewhere
#print axioms Logos.GroundingModels.Necessitation.UnactualGround.a1_fails
#print axioms Logos.GroundingModels.Necessitation.NecessitatingRegress.a2_fails
#print axioms Logos.GroundingModels.Necessitation.Brute.a4_fails
#print axioms Logos.GroundingModels.Necessitation.NoSelfAccess.a5_fails
#print axioms Logos.GroundingModels.Necessitation.FreeCreation.not_grounding_necessitates
#print axioms Logos.GroundingModels.Necessitation.NecessaryCreation.grounding_necessitates
#print axioms Logos.GroundingModels.Necessitation.NecessaryCreation.all_necessary
#print axioms Logos.GroundingModels.Necessitation.NecessaryCreation.two_accessible_worlds

-- 5.5
#print axioms Logos.GroundingModels.Necessitation.explanationNecessitates_needed
#print axioms Logos.GroundingModels.Necessitation.localSufficientExplanation_needed
#print axioms Logos.GroundingModels.Necessitation.core_needed
#print axioms Logos.GroundingModels.Necessitation.NonNecessitatingExplainer.not_explanation_necessitates
#print axioms Logos.GroundingModels.Necessitation.SelfCitingExplainer.not_core
#print axioms Logos.GroundingModels.Necessitation.SelfCitingExplainer.explanation_necessitates
#print axioms Logos.GroundingModels.Necessitation.NecessaryTotality.core
#print axioms Logos.GroundingModels.Necessitation.NecessaryTotality.explanation_necessitates
#print axioms Logos.GroundingModels.Necessitation.SelfCitingExplainer.explains_source_actual_holds
#print axioms Logos.GroundingModels.Necessitation.SelfCitingExplainer.covers_nonNecessary_holds
#print axioms Logos.GroundingModels.Necessitation.SelfCitingExplainer.adequacy_fails

-- added after review: the W reading on the totality route needs the constitution law
#print axioms Logos.GroundingModels.Necessitation.LawlessNecessitation.core
#print axioms Logos.GroundingModels.Necessitation.law_needed_for_W_reading
