import Logos.Ontology.Grounding.FactLanguage

universe u v w

namespace Logos
namespace Grounding

/-- An explicit infinite grounding regress together with a fact representing
that regress as a totality.

The `inside` predicate is intentionally supplied as data.  LOGOS does not
silently identify membership in a regress with membership in an entity carrier.
-/
structure RegressTotality
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M) where
  node : Nat → M.Entity
  step : ∀ n, ActualGrounds M (node (n + 1)) (node n)
  totality : F.Fact
  actual_totality : ActualFact F totality
  inside : M.Entity → Prop
  node_inside : ∀ n, inside (node n)

/-- Fact-level sufficient-ground commitments.

`nonNecessaryFact_is_derived` is the exact fact analogue of A4': an actual fact
that is not necessary has an entity-ground. -/
structure FactGroundingAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M) : Prop where
  groundsFact_existents :
    ∀ {a p}, ActualGroundsFact F a p → Actual M a ∧ ActualFact F p
  nonNecessaryFact_is_derived :
    ∀ p, ActualFact F p → ¬ NecessaryFact F p → DerivedFact F p

/-- Any entity grounding the regress-totality fact lies outside that regress.

This is the substantive non-circularity/externality bridge.  It is not built
into the definition of a totality fact. -/
structure ExternalRegressTotalityAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (R : RegressTotality M F) : Prop
    extends FactGroundingAxioms M F where
  totality_ground_external :
    ∀ {a}, ActualGroundsFact F a R.totality → ¬ R.inside a

/-- Stronger totality principle: every actual non-necessary entity is inside
the represented totality.

For the intended application, the regress is being tested as a candidate
*totality of contingent reality*, not merely as one local chain among others.
-/
structure CompleteContingentTotalityAxioms
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M)
    (R : RegressTotality M F) : Prop
    extends ExternalRegressTotalityAxioms M F R where
  covers_nonNecessary :
    ∀ x, Actual M x → ¬ Necessary M x → R.inside x

end Grounding
end Logos
