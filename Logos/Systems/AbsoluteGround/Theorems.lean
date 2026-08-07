import Logos.Systems.AbsoluteGround.Axioms

universe u v

namespace Logos
namespace Grounding

/-- An actual immediate ground is itself actual. -/
theorem actual_of_actualGrounds
    {M : Model.{u, v}} (A : FoundationAxioms M)
    {a x : M.Entity} (h : ActualGrounds M a x) :
    Actual M a := by
  exact (A.grounds_existents h).1

/-- If an ungrounded entity is the target of a grounding ancestry chain,
then that chain must be reflexive. -/
theorem ancestor_eq_of_ungrounded_target
    {M : Model.{u, v}} {z a : M.Entity}
    (ha : Ungrounded M a)
    (hza : GroundAncestor M z a) :
    z = a := by
  cases hza with
  | refl => rfl
  | extend hprefix hlast =>
      exfalso
      exact ha.2 ⟨_, hlast⟩

/-- A0-A2, recursion form: every accessible node of a well-founded grounding
relation has an ungrounded ancestor. -/
theorem exists_ungrounded_ancestor_of_acc
    {M : Model.{u, v}} (A : FoundationAxioms M)
    {x : M.Entity}
    (hacc : Acc (ActualGrounds M) x) :
    Actual M x → ∃ a, Ungrounded M a ∧ GroundAncestor M a x := by
  induction hacc with
  | intro x hpred ih =>
      intro hx
      by_cases hDerived : Derived M x
      · rcases hDerived with ⟨y, hyx⟩
        have hy : Actual M y := actual_of_actualGrounds A hyx
        rcases ih y hyx hy with ⟨a, ha, hay⟩
        exact ⟨a, ha, GroundAncestor.extend hay hyx⟩
      · exact ⟨x, ⟨hx, hDerived⟩, GroundAncestor.refl x⟩

/-- A0-A2: every actual entity has an ungrounded actual ancestor. -/
theorem exists_ungrounded_ancestor
    {M : Model.{u, v}} (A : FoundationAxioms M)
    {x : M.Entity} (hx : Actual M x) :
    ∃ a, Ungrounded M a ∧ GroundAncestor M a x := by
  exact exists_ungrounded_ancestor_of_acc A
    (A.grounding_wellFounded.apply x) hx

/-- A0-A2: at least one actual ungrounded entity exists. -/
theorem exists_ungrounded
    {M : Model.{u, v}} (A : FoundationAxioms M) :
    ∃ a, Ungrounded M a := by
  rcases A.actual_nonempty with ⟨x, hx⟩
  rcases exists_ungrounded_ancestor A hx with ⟨a, ha, _⟩
  exact ⟨a, ha⟩

/-- A3: two actual ungrounded entities must coincide. -/
theorem ungrounded_unique
    {M : Model.{u, v}} (A : StructuralAxioms M)
    {a b : M.Entity}
    (ha : Ungrounded M a) (hb : Ungrounded M b) :
    a = b := by
  rcases A.common_ground ha.1 hb.1 with ⟨z, _, hza, hzb⟩
  have hzaEq : z = a := ancestor_eq_of_ungrounded_target ha hza
  have hzbEq : z = b := ancestor_eq_of_ungrounded_target hb hzb
  exact hzaEq.symm.trans hzbEq

/-- A0-A3: there exists exactly one actual ungrounded root. -/
theorem exists_unique_ungrounded
    {M : Model.{u, v}} (A : StructuralAxioms M) :
    ∃ a, Ungrounded M a ∧ ∀ b, Ungrounded M b → b = a := by
  rcases exists_ungrounded A.toFoundationAxioms with ⟨a, ha⟩
  exact ⟨a, ha, fun b hb => ungrounded_unique A hb ha⟩

/-- A0-A3: the unique ungrounded root is a grounding ancestor of every actual entity. -/
theorem ungrounded_ancestor_all
    {M : Model.{u, v}} (A : StructuralAxioms M)
    {a : M.Entity} (ha : Ungrounded M a) :
    ∀ x, Actual M x → GroundAncestor M a x := by
  intro x hx
  rcases exists_ungrounded_ancestor A.toFoundationAxioms hx with ⟨b, hb, hbx⟩
  have hba : b = a := ungrounded_unique A hb ha
  cases hba
  exact hbx

/-- A0-A3: every other actual entity is strictly grounded in the unique root. -/
theorem ungrounded_ultimately_grounds_other
    {M : Model.{u, v}} (A : StructuralAxioms M)
    {a x : M.Entity} (ha : Ungrounded M a)
    (hx : Actual M x) (hne : a ≠ x) :
    UltimatelyGrounds M a x := by
  exact ⟨ungrounded_ancestor_all A ha x hx, hne⟩

/-- A5 in isolation: actual existence is possible whenever the actual world
accesses itself. -/
theorem actual_is_possible_of_reflexive
    {M : Model.{u, v}} {x : M.Entity}
    (hRefl : M.frame.access M.actual M.actual)
    (hx : Actual M x) :
    diamond M.frame (fun w => M.existsAt w x) M.actual := by
  exact ⟨M.actual, hRefl, hx⟩

/-- A5 packaged inside the minimal necessity axioms. -/
theorem actual_is_possible
    {M : Model.{u, v}} (A : NecessaryExistenceAxioms M)
    {x : M.Entity} (hx : Actual M x) :
    diamond M.frame (fun w => M.existsAt w x) M.actual := by
  exact actual_is_possible_of_reflexive A.actual_reflexive hx

/-- In classical Kripke semantics, failure of necessity supplies an accessible
world of nonexistence. -/
theorem possible_nonexistence_of_not_necessary
    {M : Model.{u, v}} {x : M.Entity}
    (h : ¬ Necessary M x) :
    diamond M.frame (mNot M.frame (fun w => M.existsAt w x)) M.actual := by
  apply Classical.byContradiction
  intro hPossible
  apply h
  intro w haw
  apply Classical.byContradiction
  intro hNotExists
  apply hPossible
  exact ⟨w, haw, hNotExists⟩

/-- A4 plus A5 imply the cleaner A4' reading: any actual but non-necessary
entity is derived. -/
theorem nonNecessary_is_derived
    {M : Model.{u, v}} (A : NecessaryExistenceAxioms M) :
    NonNecessaryIsDerived M := by
  intro x hx hNotNecessary
  have hPossibleExists := actual_is_possible A hx
  have hPossibleNot := possible_nonexistence_of_not_necessary hNotNecessary
  exact A.contingent_is_derived x hx ⟨hPossibleExists, hPossibleNot⟩

/-- Conversely, the cleaner A4' rule already excludes every actual contingent
brute fact.  This direction does not need A5. -/
theorem contingent_is_derived_of_nonNecessary
    {M : Model.{u, v}} (hA4' : NonNecessaryIsDerived M) :
    ∀ x, Actual M x → Contingent M x → Derived M x := by
  intro x hx hContingent
  apply hA4' x hx
  intro hNecessary
  rcases hContingent.2 with ⟨w, haw, hNotExists⟩
  exact hNotExists (hNecessary w haw)

/-- Under A5, the original A4 and the cleaner `actual ∧ not necessary -> derived`
formulation are equivalent. -/
theorem a4_iff_nonNecessary_is_derived
    {M : Model.{u, v}}
    (hRefl : M.frame.access M.actual M.actual) :
    (∀ x, Actual M x → Contingent M x → Derived M x) ↔
      NonNecessaryIsDerived M := by
  constructor
  · intro hA4 x hx hNotNecessary
    have hPossibleExists := actual_is_possible_of_reflexive hRefl hx
    have hPossibleNot := possible_nonexistence_of_not_necessary hNotNecessary
    exact hA4 x hx ⟨hPossibleExists, hPossibleNot⟩
  · exact contingent_is_derived_of_nonNecessary

/-- A4-A5: an actually ungrounded entity cannot be non-necessary and therefore
exists necessarily.  A3 is not used. -/
theorem ungrounded_is_necessary
    {M : Model.{u, v}} (A : NecessaryExistenceAxioms M)
    {a : M.Entity} (ha : Ungrounded M a) :
    Necessary M a := by
  apply Classical.byContradiction
  intro hNecessary
  have hDerived := nonNecessary_is_derived A a ha.1 hNecessary
  exact ha.2 hDerived

/-- Central minimal theorem: A0-A2 plus A4-A5 force the existence of some
necessary ungrounded being.  No unity/common-ground axiom A3 is assumed. -/
theorem exists_necessary_ungrounded
    {M : Model.{u, v}} (A : NecessaryExistenceAxioms M) :
    ∃ a, Ungrounded M a ∧ Necessary M a := by
  rcases exists_ungrounded A.toFoundationAxioms with ⟨a, ha⟩
  exact ⟨a, ha, ungrounded_is_necessary A ha⟩

/-- A6: an actually ungrounded entity is not a member of the created order. -/
theorem ungrounded_not_created
    {M : Model.{u, v}} (A : TranscendenceAxioms M)
    {a : M.Entity} (ha : Ungrounded M a) :
    ¬ M.created a := by
  intro hCreated
  have hDerived := A.created_is_derived a ha.1 hCreated
  exact ha.2 hDerived

/-- A0-A6: the grounding system has exactly one absolute ground.
A3 is used here for uniqueness/universality; A7 is not needed. -/
theorem exists_unique_absoluteGround
    {M : Model.{u, v}} (A : TranscendenceAxioms M) :
    ∃ a, AbsoluteGround M a ∧ ∀ b, AbsoluteGround M b → b = a := by
  let N : NecessaryGroundAxioms M := A.toNecessaryGroundAxioms
  let E : NecessaryExistenceAxioms M := N.toNecessaryExistenceAxioms
  let S : StructuralAxioms M := N.toStructuralAxioms
  rcases exists_ungrounded E.toFoundationAxioms with ⟨a, ha⟩
  have hNecessary : Necessary M a := ungrounded_is_necessary E ha
  have hNotCreated : ¬ M.created a := ungrounded_not_created A ha
  have hUniversal : ∀ x, Actual M x → GroundAncestor M a x :=
    ungrounded_ancestor_all S ha
  have hAbsolute : AbsoluteGround M a :=
    ⟨ha, hNecessary, hNotCreated, hUniversal⟩
  refine ⟨a, hAbsolute, ?_⟩
  intro b hb
  exact ungrounded_unique S hb.1 ha

/-- A8 plus necessary existence upgrades actual aseity to necessary aseity. -/
theorem absoluteGround_is_necessarilyAseitic
    {M : Model.{u, v}} (A : EssentialAseityAxioms M)
    {a : M.Entity} (ha : AbsoluteGround M a) :
    NecessarilyAseitic M a := by
  intro w haw
  have hExists : M.existsAt w a := ha.2.1 w haw
  have hNoGround : ¬ DerivedAt M w a :=
    A.aseity_essential a ha.1 w haw hExists
  exact ⟨hExists, hNoGround⟩

/-- A0-A6 plus A8: there is exactly one absolute ground and it is necessarily
aseitic. A7 is again logically independent of this conclusion. -/
theorem exists_unique_necessarilyAseitic_absoluteGround
    {M : Model.{u, v}} (A : EssentialAseityAxioms M) :
    ∃ a,
      (AbsoluteGround M a ∧ NecessarilyAseitic M a) ∧
      ∀ b, (AbsoluteGround M b ∧ NecessarilyAseitic M b) → b = a := by
  rcases exists_unique_absoluteGround A.toTranscendenceAxioms with ⟨a, ha, hUnique⟩
  have hAseitic := absoluteGround_is_necessarilyAseitic A ha
  exact ⟨a, ⟨ha, hAseitic⟩, fun b hb => hUnique b hb.1⟩

end Grounding
end Logos
