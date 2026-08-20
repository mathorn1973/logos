import Logos

/-! Axiom audit for A4-FACT-INDEPENDENCE-1.

Both directions and the joint statement. Nothing here may depend on a custom
axiom, and every model must be exhibited rather than assumed. -/

-- 5.1 entity level regular, fact level brute
#print axioms Logos.GroundingModels.A4FactIndependence.FactBruteEntityRegular.a4_holds
#print axioms Logos.GroundingModels.A4FactIndependence.FactBruteEntityRegular.totality_not_necessary
#print axioms Logos.GroundingModels.A4FactIndependence.FactBruteEntityRegular.local_ef4_fails

-- 5.2 fact level regular, entity level brute
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.explanationCore
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.local_ef4_holds
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.local_ef4_antecedent_met
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.local_ef4_consequent_met
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.stray_actual
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.stray_not_necessary
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.stray_not_derived
#print axioms Logos.GroundingModels.A4FactIndependence.EntityBruteFactRegular.a4_fails

-- 5.3 joint statement
#print axioms Logos.GroundingModels.A4FactIndependence.a4_and_localEF4_are_independent
