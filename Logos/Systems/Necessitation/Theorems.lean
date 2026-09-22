import Logos.Ontology.Grounding.Necessitation
import Logos.Systems.AbsoluteGround.Theorems
import Logos.Systems.FactSufficientExplanation.Theorems

universe u v w

namespace Logos
namespace Grounding

/-! # NECESSITATION-1: theorems

Section numbers refer to `NECESSITATION-CONTRACT.md`. The foundation-side
hypotheses are the fields A1, A2, A4 and A5 of the accepted records, stated
separately with the same types, so that A0 is visibly absent. -/

/-! ## 5.1 A necessitating link from necessary sources -/

/-- A derived entity whose actual immediate grounds are all necessary is itself
necessary, when grounding necessitates. -/
theorem necessary_of_groundingNecessitates
    {M : Model.{u, v}} (hN : GroundingNecessitates M)
    {x : M.Entity} (hDerived : Derived M x)
    (hGrounds : ∀ a, ActualGrounds M a x → Necessary M a) :
    Necessary M x :=
  fun world hAccess =>
    hN x hDerived world hAccess (fun a ha => hGrounds a ha world hAccess)

/-- An explained fact whose actual explanatory sources are all necessary is
itself necessary, when its explanation necessitates. -/
theorem necessaryFact_of_explanationNecessitates
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (hN : ExplanationNecessitates G p) (hExplained : ExplainedFact G p)
    (hSources : ∀ a, ActualExplainsFact G a p → Necessary M a) :
    NecessaryFact F p :=
  fun world hAccess =>
    hN hExplained world hAccess (fun a ha => hSources a ha world hAccess)

/-! ## 5.2 Foundation route: necessitating grounding is necessitarianism -/

/-- A1, A2, A4 and A5 make every actual entity necessary as soon as grounding
necessitates at the links that leave necessary grounds. By well-founded
induction along A2: a derived entity whose actual grounds are necessary is
necessary by the link hypothesis, and an ungrounded one is necessary by A4 and
A5. A0 is not used. The link hypothesis is weaker than `GroundingNecessitates`:
it asks for necessitation only where every actual ground is already necessary. -/
theorem actual_necessary_of_necessary_links
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hA2 : WellFounded (ActualGrounds M))
    (hA4 : ∀ x, Actual M x → Contingent M x → Derived M x)
    (hA5 : M.frame.access M.actual M.actual)
    (hLinks : ∀ x, Derived M x → (∀ a, ActualGrounds M a x → Necessary M a) →
      box M.frame
        (fun world => (∀ a, ActualGrounds M a x → M.existsAt world a) → M.existsAt world x)
        M.actual) :
    ∀ x, Actual M x → Necessary M x := by
  intro x
  refine hA2.induction (C := fun x => Actual M x → Necessary M x) x ?_
  intro x ih hx
  by_cases hDerived : Derived M x
  · have hGrounds : ∀ a, ActualGrounds M a x → Necessary M a :=
      fun a ha => ih a ha (hA1 ha).1
    exact fun world hAccess =>
      hLinks x hDerived hGrounds world hAccess (fun a ha => hGrounds a ha world hAccess)
  · apply Classical.byContradiction
    intro hNotNecessary
    have hPossible : diamond M.frame (fun w => M.existsAt w x) M.actual :=
      ⟨M.actual, hA5, hx⟩
    have hPossibleNot := possible_nonexistence_of_not_necessary hNotNecessary
    exact hDerived (hA4 x hx ⟨hPossible, hPossibleNot⟩)

/-- A1, A2, A4 and A5 with necessitating grounding make every actual entity
necessary. A0 is not used. -/
theorem actual_necessary_of_groundingNecessitates
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hA2 : WellFounded (ActualGrounds M))
    (hA4 : ∀ x, Actual M x → Contingent M x → Derived M x)
    (hA5 : M.frame.access M.actual M.actual)
    (hN : GroundingNecessitates M) :
    ∀ x, Actual M x → Necessary M x :=
  actual_necessary_of_necessary_links hA1 hA2 hA4 hA5 (fun x hDerived _ => hN x hDerived)

/-- Conversely, under A1 alone, if every actual entity is necessary then
grounding necessitates. -/
theorem groundingNecessitates_of_actual_necessary
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hAll : ∀ x, Actual M x → Necessary M x) :
    GroundingNecessitates M := by
  intro x hDerived world hAccess _
  rcases hDerived with ⟨a, ha⟩
  exact hAll x (hA1 ha).2 world hAccess

/-- Under A1, A2, A4 and A5, necessitating grounding is equivalent to every
actual entity being necessary. -/
theorem groundingNecessitates_iff_actual_necessary
    {M : Model.{u, v}}
    (hA1 : ∀ {w a x}, M.directGrounds w a x → M.existsAt w a ∧ M.existsAt w x)
    (hA2 : WellFounded (ActualGrounds M))
    (hA4 : ∀ x, Actual M x → Contingent M x → Derived M x)
    (hA5 : M.frame.access M.actual M.actual) :
    GroundingNecessitates M ↔ ∀ x, Actual M x → Necessary M x :=
  ⟨actual_necessary_of_groundingNecessitates hA1 hA2 hA4 hA5,
    groundingNecessitates_of_actual_necessary hA1⟩

/-- The first direction of 5.2 stated against the accepted record. The record
also carries A0, which the proof does not use. -/
theorem actual_necessary_of_necessaryExistenceAxioms_of_groundingNecessitates
    {M : Model.{u, v}} (A : NecessaryExistenceAxioms M)
    (hN : GroundingNecessitates M) :
    ∀ x, Actual M x → Necessary M x :=
  actual_necessary_of_groundingNecessitates
    (fun h => A.grounds_existents h) A.grounding_wellFounded
    A.contingent_is_derived A.actual_reflexive hN

/-! ## 5.3 Totality route: necessitating explanation is necessity of the
totality fact -/

/-- Under the core, necessitating explanation merges the middle disjunct of the
accepted trichotomy into the first. -/
theorem necessaryFact_or_contingentAbsolute_of_explanationNecessitates
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hN : ExplanationNecessitates G R.totality) :
    NecessaryFact F R.totality ∨ ContingentExplanatoryAbsoluteFact G R.totality := by
  rcases totality_necessary_or_necessary_explainer_or_contingent_absolute A with
    hNecessary | ⟨a, _, _, hExplain⟩ | hAbsolute
  · exact Or.inl hNecessary
  · exact Or.inl
      (necessaryFact_of_explanationNecessitates hN ⟨a, hExplain⟩
        (fun b hb => totality_explainer_is_necessary_from_core A hb))
  · exact Or.inr hAbsolute

/-- Under the core, necessitating explanation of the totality fact says no more
than that the totality fact, if explained, is necessary. The core already makes
every explainer necessary, so the antecedent of the necessitation premise holds
at every accessible world; rigid sources and the plurality of sources do no work
on this route. -/
theorem explanationNecessitates_iff_explained_imp_necessaryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R) :
    ExplanationNecessitates G R.totality ↔
      (ExplainedFact G R.totality → NecessaryFact F R.totality) :=
  ⟨fun hN hExplained =>
      necessaryFact_of_explanationNecessitates hN hExplained
        (fun _ hb => totality_explainer_is_necessary_from_core A hb),
    fun hImp hExplained world hAccess _ => hImp hExplained world hAccess⟩

/-- Under the core and local sufficient explanation, necessitating explanation
makes the totality fact necessary. -/
theorem necessaryFact_of_localSufficientExplanation_of_explanationNecessitates
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hN : ExplanationNecessitates G R.totality)
    (hLocal : LocalFactSufficientExplanation G R.totality) :
    NecessaryFact F R.totality := by
  rcases necessaryFact_or_contingentAbsolute_of_explanationNecessitates A hN with
    hNecessary | hAbsolute
  · exact hNecessary
  · exact absurd (hLocal hAbsolute.2.1) hAbsolute.2.2

/-- A necessary fact satisfies explanatory necessitation, with no premise. -/
theorem explanationNecessitates_of_necessaryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {p : F.Fact}
    (hNecessary : NecessaryFact F p) :
    ExplanationNecessitates G p :=
  fun _ world hAccess _ => hNecessary world hAccess

/-- Under the core and local sufficient explanation, necessitating explanation
of the totality fact is equivalent to its necessity. -/
theorem explanationNecessitates_iff_necessaryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hLocal : LocalFactSufficientExplanation G R.totality) :
    ExplanationNecessitates G R.totality ↔ NecessaryFact F R.totality :=
  ⟨fun hN => necessaryFact_of_localSufficientExplanation_of_explanationNecessitates A hN hLocal,
    explanationNecessitates_of_necessaryFact⟩

end Grounding
end Logos
