import Logos

/-! Axiom audit for ROUTE-SEAM-1.

Every load-bearing statement of the cut is listed. The seam theorems must not
depend on any custom axiom, and the countermodel must be exhibited rather than
assumed. -/

-- 5.1 and 5.2: the two routes cannot share a model
#print axioms Logos.Grounding.regressTotality_refutes_wellFoundedness
#print axioms Logos.Grounding.regressTotality_refutes_foundationAxioms
#print axioms Logos.Grounding.regressTotality_refutes_necessaryExistenceAxioms
#print axioms Logos.Grounding.seam_bridge_is_vacuous

-- 5.3: the deep package is satisfied while the explainer is grounded
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.completeScopedAxioms
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.totality_not_necessary
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.root_necessary
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.root_outside
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.root_derived
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.root_not_ungrounded
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.deep_route_has_necessary_explainer
#print axioms Logos.GroundingModels.RouteSeam.GroundedExplainer.no_explainer_is_ungrounded

-- 5.3, other direction: the accepted positive model has an ungrounded explainer
#print axioms Logos.GroundingModels.RouteSeam.UngroundedExplainer.root_ungrounded
#print axioms Logos.GroundingModels.RouteSeam.UngroundedExplainer.explainer_is_ungrounded_here

-- 5.4: exhaustiveness at the entity level, and its deflation
#print axioms Logos.Grounding.exists_descending_chain_of_not_wellFounded
#print axioms Logos.GroundingModels.RouteSeam.BareRegress.regressOfChain
#print axioms Logos.GroundingModels.RouteSeam.BareRegress.wellFounded_or_regressTotality
#print axioms Logos.GroundingModels.RouteSeam.BareRegress.bare_totality_necessary

-- summary
#print axioms Logos.GroundingModels.RouteSeam.explainer_groundedness_undetermined
