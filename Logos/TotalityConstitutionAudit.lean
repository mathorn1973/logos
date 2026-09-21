import Logos

/-! Axiom audit for TOTALITY-CONSTITUTION-1.

Section numbers refer to `TOTALITY-CONSTITUTION-CONTRACT.md`. The results the
contract predicts axiom-free are listed under their own headings so that a
regression to a classical proof is visible. Nothing here may depend on a
custom axiom, and every model is exhibited rather than assumed. -/

-- 5.1, predicted axiom-free
#print axioms Logos.Grounding.inside_actual_of_totalityRequiresMembers

-- 5.2, predicted axiom-free
#print axioms Logos.Grounding.not_necessaryFact_of_member_not_necessary
#print axioms Logos.Grounding.necessaryFact_iff_members_necessary

-- 5.3, forward direction predicted axiom-free, backward classical
#print axioms Logos.Grounding.not_contingencyWitness_of_necessaryFact
#print axioms Logos.Grounding.necessaryFact_of_not_contingencyWitness
#print axioms Logos.Grounding.necessaryFact_iff_not_contingencyWitness

-- 5.4, classical through the accepted trichotomy
#print axioms Logos.Grounding.necessary_explainer_or_contingent_absolute
#print axioms Logos.Grounding.necessary_explainer_of_localEF4

-- construction
#print axioms Logos.Grounding.constitutedFacts
#print axioms Logos.Grounding.constitutedFacts_holdsAt
#print axioms Logos.Grounding.constitutedRegress
#print axioms Logos.Grounding.constitutedRegress_law

-- 5.5 Necessitarian: law and core, no witness
#print axioms Logos.GroundingModels.TotalityConstitution.Necessitarian.law
#print axioms Logos.GroundingModels.TotalityConstitution.Necessitarian.explanationCore
#print axioms Logos.GroundingModels.TotalityConstitution.Necessitarian.no_witness
#print axioms Logos.GroundingModels.TotalityConstitution.Necessitarian.totality_necessary
#print axioms Logos.GroundingModels.TotalityConstitution.Necessitarian.not_singleSuccessor

-- 5.5 BareWitness: witness and core, no law
#print axioms Logos.GroundingModels.TotalityConstitution.BareWitness.explanationCore
#print axioms Logos.GroundingModels.TotalityConstitution.BareWitness.witness
#print axioms Logos.GroundingModels.TotalityConstitution.BareWitness.law_fails
#print axioms Logos.GroundingModels.TotalityConstitution.BareWitness.totality_necessary

-- 5.5 Witnessed: shared model
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.law
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.witness
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.totality_not_necessary
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.totality_actual

-- 5.5 NecessaryExplainer: middle disjunct
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.NecessaryExplainer.explanationCore
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.NecessaryExplainer.middle_disjunct
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.NecessaryExplainer.not_contingent_absolute
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.NecessaryExplainer.local_ef4_holds

-- 5.5 ContingentAbsolute: third disjunct
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.ContingentAbsolute.explanationCore
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.ContingentAbsolute.third_disjunct
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.ContingentAbsolute.no_necessary_explainer
#print axioms Logos.GroundingModels.TotalityConstitution.Witnessed.ContingentAbsolute.local_ef4_fails

-- 5.6, predicted axiom-free
#print axioms Logos.Grounding.necessary_iff_actual_of_singleSuccessor
#print axioms Logos.Grounding.not_contingent_of_singleSuccessor
#print axioms Logos.Grounding.necessaryExistenceAxioms_of_foundation_of_singleSuccessor
#print axioms Logos.Grounding.exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor

-- 5.7, first axiom-free, the other two classical
#print axioms Logos.Grounding.not_singleSuccessor_of_contingencyWitness
#print axioms Logos.Grounding.exists_other_world_of_contingencyWitness
#print axioms Logos.Grounding.contingencyWitness_iff_contingent_of_reflexive

-- 5.8, reuse of the accepted twoRootModel
#print axioms Logos.GroundingModels.TotalityConstitution.TwoRootDegenerate.twoRoot_singleSuccessor
#print axioms Logos.GroundingModels.TotalityConstitution.TwoRootDegenerate.twoRoot_necessary_iff_actual
#print axioms Logos.GroundingModels.TotalityConstitution.TwoRootDegenerate.twoRoot_no_witness
#print axioms Logos.GroundingModels.TotalityConstitution.TwoRootDegenerate.twoRoot_necessity_is_free
