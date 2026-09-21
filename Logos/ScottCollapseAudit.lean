import Logos

/-! Axiom audit for SCOTT-COLLAPSE-1.

Section numbers refer to `SCOTT-COLLAPSE-CONTRACT.md`. The results the contract
predicts axiom-free are listed under their own heading so that a regression to
a classical proof is visible. Nothing here may depend on a custom axiom, and
every model is exhibited rather than assumed. -/

-- 5.1, predicted axiom-free, and with no axiom record among the hypotheses
#print axioms Logos.GoedelScott.essence_haecceity
#print axioms Logos.GoedelScott.necInstantiated_iff
#print axioms Logos.GoedelScott.seesOnlyItself_of_necInstantiated

-- frame lemma
#print axioms Logos.GoedelScott.backAccess_of_symmetric

-- 5.2, predicted classical
#print axioms Logos.GoedelScott.possibly_exemplified

-- 5.3, predicted classical through 5.2
#print axioms Logos.GoedelScott.seesOnlyItself_of_scottCore

-- 5.4, corollaries of 5.3
#print axioms Logos.GoedelScott.collapse
#print axioms Logos.GoedelScott.necessarily_allPositive_iff_actually
#print axioms Logos.GoedelScott.necessarily_allPositive

-- 5.5, consistency witness
#print axioms Logos.GoedelScottModels.OneWorld.scottAxioms
#print axioms Logos.GoedelScottModels.OneWorld.backAccess

-- 5.5, NoBackAccess
#print axioms Logos.GoedelScottModels.NoBackAccess.scottAxioms
#print axioms Logos.GoedelScottModels.NoBackAccess.reflexive
#print axioms Logos.GoedelScottModels.NoBackAccess.transitive
#print axioms Logos.GoedelScottModels.NoBackAccess.not_backAccess
#print axioms Logos.GoedelScottModels.NoBackAccess.not_seesOnlyItself
#print axioms Logos.GoedelScottModels.NoBackAccess.backAccess_at_b
#print axioms Logos.GoedelScottModels.NoBackAccess.not_symmetric
#print axioms Logos.GoedelScottModels.backAccess_not_redundant

-- 5.5, DropA5
#print axioms Logos.GoedelScottModels.DropA5.positiveNeg
#print axioms Logos.GoedelScottModels.DropA5.positiveMono
#print axioms Logos.GoedelScottModels.DropA5.positiveAllPositive
#print axioms Logos.GoedelScottModels.DropA5.positiveRigid
#print axioms Logos.GoedelScottModels.DropA5.not_positiveNecInstantiated
#print axioms Logos.GoedelScottModels.positiveNecInstantiated_not_redundant

-- 5.5, DropA1
#print axioms Logos.GoedelScottModels.DropA1.positiveMono
#print axioms Logos.GoedelScottModels.DropA1.positiveAllPositive
#print axioms Logos.GoedelScottModels.DropA1.positiveRigid
#print axioms Logos.GoedelScottModels.DropA1.positiveNecInstantiated
#print axioms Logos.GoedelScottModels.DropA1.not_positiveNeg
#print axioms Logos.GoedelScottModels.positiveNeg_not_redundant

-- 5.5, DropA2
#print axioms Logos.GoedelScottModels.DropA2.positiveNeg
#print axioms Logos.GoedelScottModels.DropA2.positiveAllPositive
#print axioms Logos.GoedelScottModels.DropA2.positiveRigid
#print axioms Logos.GoedelScottModels.DropA2.positiveNecInstantiated
#print axioms Logos.GoedelScottModels.DropA2.not_positiveMono
#print axioms Logos.GoedelScottModels.positiveMono_not_redundant

-- shared frame facts
#print axioms Logos.GoedelScottModels.fullFrame_equivalence
#print axioms Logos.GoedelScottModels.fullFrame_not_seesOnlyItself

-- 5.6, the seam; classical through 5.3
#print axioms Logos.Models.Seam.ScottGrounding.singleSuccessor_of_scottCore
#print axioms Logos.Models.Seam.ScottGrounding.actual_reflexive_of_scottCore
#print axioms Logos.Models.Seam.ScottGrounding.not_contingencyWitness_of_scottCore
#print axioms Logos.Models.Seam.ScottGrounding.necessary_iff_actual_of_scottCore
#print axioms Logos.Models.Seam.ScottGrounding.necessaryExistenceAxioms_of_foundation_of_scottCore
#print axioms Logos.Models.Seam.ScottGrounding.exists_necessary_ungrounded_iff_exists_ungrounded_of_scottCore

-- 5.7, one grounding model, two carriers
#print axioms Logos.Models.Seam.ScottGrounding.necessaryExistenceAxioms
#print axioms Logos.Models.Seam.ScottGrounding.scottAxioms_carrierAt
#print axioms Logos.Models.Seam.ScottGrounding.rootCarrier_joint
#print axioms Logos.Models.Seam.ScottGrounding.leafCarrier_joint
