import Logos.Systems.TotalityConstitution.Law
import Logos.Systems.FactSufficientExplanation.Theorems
import Logos.Systems.AbsoluteGround.Theorems

universe u v w

namespace Logos
namespace Grounding

/-! # Totality constitution

What the totality route says once the totality fact is constituted by its
members, and what each route needs the contingency witness `W` for. The
contract is `TOTALITY-CONSTITUTION-CONTRACT.md`; section numbers below refer
to it. -/

/-! ## 5.1 The law forces membership into the actual world -/

/-- Under the forward half of the law, every represented member actually
exists, because the totality actually obtains. -/
theorem inside_actual_of_totalityRequiresMembers
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : TotalityRequiresMembers F R) :
    ∀ x, R.inside x → Actual M x :=
  fun x hx => hLaw M.actual R.actual_totality x hx

/-! ## 5.2 The first disjunct is member-necessity -/

/-- Forward form, using only the forward half of the law: a non-necessary
member refutes necessity of the totality fact. -/
theorem not_necessaryFact_of_member_not_necessary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : TotalityRequiresMembers F R)
    {x : M.Entity} (hInside : R.inside x) (hNot : ¬ Necessary M x) :
    ¬ NecessaryFact F R.totality := by
  intro hNecessary
  apply hNot
  intro world hAccess
  exact hLaw world (hNecessary world hAccess) x hInside

/-- Under the full law, the totality fact is necessary exactly when every
represented member is necessary. -/
theorem necessaryFact_iff_members_necessary
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : ConstitutedTotality F R) :
    NecessaryFact F R.totality ↔ ∀ x, R.inside x → Necessary M x := by
  constructor
  · intro hNecessary x hInside world hAccess
    exact (hLaw world).1 (hNecessary world hAccess) x hInside
  · intro hMembers world hAccess
    exact (hLaw world).2 (fun x hInside => hMembers x hInside world hAccess)

/-! ## 5.3 Under completeness, the first disjunct is necessitarianism -/

/-- No axioms: a necessary totality fact leaves no actual non-necessary
entity, because completeness would put it inside. -/
theorem not_contingencyWitness_of_necessaryFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : TotalityRequiresMembers F R)
    (hCovers : ∀ x, Actual M x → ¬ Necessary M x → R.inside x)
    (hNecessary : NecessaryFact F R.totality) :
    ¬ ContingencyWitness M := by
  rintro ⟨x, hx, hNot⟩
  exact not_necessaryFact_of_member_not_necessary hLaw (hCovers x hx hNot) hNot hNecessary

/-- Classical: with nothing actual non-necessary, every member is necessary and
so is the constituted totality fact. The classical step is the passage from
`¬ ¬ Necessary` to `Necessary`. -/
theorem necessaryFact_of_not_contingencyWitness
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : ConstitutedTotality F R)
    (hNoWitness : ¬ ContingencyWitness M) :
    NecessaryFact F R.totality := by
  refine (necessaryFact_iff_members_necessary hLaw).2 ?_
  intro x hInside
  have hActual : Actual M x :=
    inside_actual_of_totalityRequiresMembers
      (TotalityRequiresMembers.of_constituted hLaw) x hInside
  apply Classical.byContradiction
  intro hNot
  exact hNoWitness ⟨x, hActual, hNot⟩

/-- Under the law and completeness, the first disjunct of the trichotomy is
exactly the denial of `W`. -/
theorem necessaryFact_iff_not_contingencyWitness
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M} {R : RegressTotality M F}
    (hLaw : ConstitutedTotality F R)
    (hCovers : ∀ x, Actual M x → ¬ Necessary M x → R.inside x) :
    NecessaryFact F R.totality ↔ ¬ ContingencyWitness M :=
  ⟨not_contingencyWitness_of_necessaryFact
      (TotalityRequiresMembers.of_constituted hLaw) hCovers,
    necessaryFact_of_not_contingencyWitness hLaw⟩

/-! ## 5.4 The dichotomy -/

/-- The accepted trichotomy with its first disjunct removed by the law and
`W`. The remaining fork is unchanged: a necessary explanatory source, or a
contingent explanatory absolute. -/
theorem necessary_explainer_or_contingent_absolute
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hLaw : TotalityRequiresMembers F R)
    (hW : ContingencyWitness M) :
    (∃ a, Actual M a ∧ Necessary M a ∧ ActualExplainsFact G a R.totality) ∨
      ContingentExplanatoryAbsoluteFact G R.totality := by
  rcases hW with ⟨x, hx, hNot⟩
  have hNotNecessary : ¬ NecessaryFact F R.totality :=
    not_necessaryFact_of_member_not_necessary hLaw (A.covers_nonNecessary x hx hNot) hNot
  rcases totality_necessary_or_necessary_explainer_or_contingent_absolute A with
    hNecessary | hExplainer | hAbsolute
  · exact absurd hNecessary hNotNecessary
  · exact Or.inl hExplainer
  · exact Or.inr hAbsolute

/-- With local sufficient explanation added, the fork closes on the necessary
explanatory source. This is the conditional positive conclusion of the
totality route: law, `W` and local sufficient explanation together. -/
theorem necessary_explainer_of_localEF4
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F} {E : EntityExplanationModel M}
    {R : RegressTotality M F}
    (A : TotalityExplanationCore M F G E R)
    (hLaw : TotalityRequiresMembers F R)
    (hW : ContingencyWitness M)
    (hLocal : LocalFactSufficientExplanation G R.totality) :
    ∃ a, Actual M a ∧ Necessary M a ∧ ActualExplainsFact G a R.totality := by
  rcases necessary_explainer_or_contingent_absolute A hLaw hW with hExplainer | hAbsolute
  · exact hExplainer
  · exact absurd (hLocal hAbsolute.2.1) hAbsolute.2.2

/-! ## 5.6 The foundation route on a degenerate frame -/

/-- On a single-successor frame with `A5`, necessity is actuality. -/
theorem necessary_iff_actual_of_singleSuccessor
    {M : Model.{u, v}}
    (hSingle : SingleSuccessor M)
    (hRefl : M.frame.access M.actual M.actual)
    (x : M.Entity) :
    Necessary M x ↔ Actual M x := by
  constructor
  · intro hNecessary
    exact hNecessary M.actual hRefl
  · intro hx world hAccess
    rw [hSingle world hAccess]
    exact hx

/-- On a single-successor frame nothing is contingent. -/
theorem not_contingent_of_singleSuccessor
    {M : Model.{u, v}}
    (hSingle : SingleSuccessor M) (x : M.Entity) :
    ¬ Contingent M x := by
  rintro ⟨⟨w₁, h₁, hExists⟩, ⟨w₂, h₂, hNotExists⟩⟩
  have e₁ := hSingle w₁ h₁
  have e₂ := hSingle w₂ h₂
  subst e₁
  subst e₂
  exact hNotExists hExists

/-- On a single-successor frame `A4` is vacuous, so `A0`-`A2` with `A5`
already give the full necessity package. -/
theorem necessaryExistenceAxioms_of_foundation_of_singleSuccessor
    {M : Model.{u, v}}
    (hSingle : SingleSuccessor M)
    (hRefl : M.frame.access M.actual M.actual)
    (A : FoundationAxioms M) :
    NecessaryExistenceAxioms M :=
  { toFoundationAxioms := A
    contingent_is_derived := fun x _ hContingent =>
      absurd hContingent (not_contingent_of_singleSuccessor hSingle x)
    actual_reflexive := hRefl }

/-- On a single-successor frame the conclusion of the central theorem says
exactly what `exists_ungrounded` says: the modal conjunct is free. -/
theorem exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor
    {M : Model.{u, v}}
    (hSingle : SingleSuccessor M)
    (hRefl : M.frame.access M.actual M.actual) :
    (∃ a, Ungrounded M a ∧ Necessary M a) ↔ ∃ a, Ungrounded M a := by
  constructor
  · rintro ⟨a, ha, _⟩
    exact ⟨a, ha⟩
  · rintro ⟨a, ha⟩
    exact ⟨a, ha, (necessary_iff_actual_of_singleSuccessor hSingle hRefl a).2 ha.1⟩

/-! ## 5.7 `W` and the frame -/

/-- No axioms: `W` refutes the single-successor frame. -/
theorem not_singleSuccessor_of_contingencyWitness
    {M : Model.{u, v}} (hW : ContingencyWitness M) :
    ¬ SingleSuccessor M := by
  intro hSingle
  rcases hW with ⟨x, hx, hNot⟩
  apply hNot
  intro world hAccess
  rw [hSingle world hAccess]
  exact hx

/-- Classical: `W` supplies an accessible world other than the actual one.
The existential form needs the classical extraction of a world from a failed
necessity; the axiom-free content is `not_singleSuccessor_of_contingencyWitness`. -/
theorem exists_other_world_of_contingencyWitness
    {M : Model.{u, v}} (hW : ContingencyWitness M) :
    ∃ world, M.frame.access M.actual world ∧ world ≠ M.actual := by
  rcases hW with ⟨x, hx, hNot⟩
  rcases possible_nonexistence_of_not_necessary hNot with ⟨world, hAccess, hNotExists⟩
  refine ⟨world, hAccess, ?_⟩
  intro hEq
  apply hNotExists
  rw [hEq]
  exact hx

/-- Under `A5`, `W` is the existence of an actual entity that is contingent in
the original sense. The direction from `W` to `Contingent` is classical. -/
theorem contingencyWitness_iff_contingent_of_reflexive
    {M : Model.{u, v}}
    (hRefl : M.frame.access M.actual M.actual) :
    ContingencyWitness M ↔ ∃ x, Actual M x ∧ Contingent M x := by
  constructor
  · rintro ⟨x, hx, hNot⟩
    exact ⟨x, hx, actual_is_possible_of_reflexive hRefl hx,
      possible_nonexistence_of_not_necessary hNot⟩
  · rintro ⟨x, hx, ⟨_, ⟨world, hAccess, hNotExists⟩⟩⟩
    refine ⟨x, hx, ?_⟩
    intro hNecessary
    exact hNotExists (hNecessary world hAccess)

end Grounding
end Logos
