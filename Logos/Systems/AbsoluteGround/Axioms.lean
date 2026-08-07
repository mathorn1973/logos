import Logos.Ontology.Grounding.Language

universe u v

namespace Logos
namespace Grounding

/-- A0-A2: the minimal foundation commitments needed to obtain an actual
ungrounded root.  Unity is deliberately absent. -/
structure FoundationAxioms (M : Model.{u, v}) : Prop where
  /-- A0: something actually exists. -/
  actual_nonempty : ∃ x, Actual M x

  /-- A1: grounding relates entities that exist at the world in question. -/
  grounds_existents :
    ∀ {w a x}, M.directGrounds w a x →
      M.existsAt w a ∧ M.existsAt w x

  /-- A2: actual grounding has no infinite descent toward ever deeper grounds. -/
  grounding_wellFounded : WellFounded (ActualGrounds M)

/-- A0-A3: foundation plus the unity/common-ground commitment. -/
structure StructuralAxioms (M : Model.{u, v}) : Prop extends FoundationAxioms M where
  /-- A3: any two actual entities have a common actual grounding ancestor. -/
  common_ground :
    ∀ {x y}, Actual M x → Actual M y →
      ∃ z, Actual M z ∧ GroundAncestor M z x ∧ GroundAncestor M z y

/-- Structural assumptions may always be forgotten down to A0-A2. -/
instance {M : Model.{u, v}} : Coe (StructuralAxioms M) (FoundationAxioms M) where
  coe := StructuralAxioms.toFoundationAxioms

/-- The cleaner A4' formulation used in the philosophical audit:
what actually exists but is not necessary is derived. -/
def NonNecessaryIsDerived (M : Model.{u, v}) : Prop :=
  ∀ x, Actual M x → ¬ Necessary M x → Derived M x

/-- A0-A2 plus A4-A5.  This is the exact package needed for existence of
some necessary ungrounded being.  It contains no unity axiom A3. -/
structure NecessaryExistenceAxioms (M : Model.{u, v}) : Prop extends FoundationAxioms M where
  /-- A4: no actually existing contingent entity is an ungrounded brute fact. -/
  contingent_is_derived :
    ∀ x, Actual M x → Contingent M x → Derived M x

  /-- A5: the distinguished actual world accesses itself. -/
  actual_reflexive : M.frame.access M.actual M.actual

/-- A0-A5: the necessity package plus A3, used when one also wants uniqueness
and universal grounding ancestry. -/
structure NecessaryGroundAxioms (M : Model.{u, v}) : Prop extends StructuralAxioms M where
  /-- A4: no actually existing contingent entity is an ungrounded brute fact. -/
  contingent_is_derived :
    ∀ x, Actual M x → Contingent M x → Derived M x

  /-- A5: the distinguished actual world accesses itself. -/
  actual_reflexive : M.frame.access M.actual M.actual

/-- Forget A3 while retaining exactly A0-A2 and A4-A5. -/
def NecessaryGroundAxioms.toNecessaryExistenceAxioms
    {M : Model.{u, v}} (A : NecessaryGroundAxioms M) :
    NecessaryExistenceAxioms M where
  toFoundationAxioms := A.toStructuralAxioms.toFoundationAxioms
  contingent_is_derived := A.contingent_is_derived
  actual_reflexive := A.actual_reflexive

/-- A0-A6: necessary-ground commitments plus the created-implies-derived bridge. -/
structure TranscendenceAxioms (M : Model.{u, v}) : Prop extends NecessaryGroundAxioms M where
  /-- A6: every actually existing created entity is derived. -/
  created_is_derived :
    ∀ x, Actual M x → M.created x → Derived M x

/-- A0-A7: transcendence commitments plus a nonempty created order. -/
structure CreationAxioms (M : Model.{u, v}) : Prop extends TranscendenceAxioms M where
  /-- A7: at least one actually existing entity belongs to the created order. -/
  created_nonempty :
    ∃ x, Actual M x ∧ M.created x

/-- A0-A6 plus A8. A7 is deliberately absent because necessary aseity does
not require the created order to be nonempty. -/
structure EssentialAseityAxioms (M : Model.{u, v}) : Prop extends TranscendenceAxioms M where
  /-- A8: actual ungroundedness is essential wherever the entity exists. -/
  aseity_essential :
    ∀ x, Ungrounded M x →
      box M.frame
        (fun w => M.existsAt w x → ¬ DerivedAt M w x)
        M.actual

end Grounding
end Logos
