import Logos

/-! Axiom audit for the semantic self-reference line:
`internal-truth-1`, `self-closure-1` and `truth-fact-seam-1`.

`README` and `STATUS` state that `no_internal_truth`,
`selfClosed_excludes_exprNegT` and every result of the seam cut depend on no
axioms, and that `omegaMax_diag` is the only result on the line that uses
`Classical.choice`. Until this file those were documentation statements.
`PROJECT-RULES.md` section 6 says a documentation statement is not enough
when the boundary can be pinned by Lean; this pins it. -/

-- internal-truth-1: joint unsatisfiability, predicted axiom-free
#print axioms Logos.Systems.InternalTruth.no_internal_truth

-- internal-truth-1: seven independence witnesses
#print axioms Logos.Models.Semantics.drop_Diag
#print axioms Logos.Models.Semantics.drop_ExprNegT
#print axioms Logos.Models.Semantics.drop_Scope
#print axioms Logos.Models.Semantics.drop_Disq
#print axioms Logos.Models.Semantics.drop_NegSwapT
#print axioms Logos.Models.Semantics.drop_NoGap
#print axioms Logos.Models.Semantics.drop_NoGlut

-- internal-truth-1: seven non-redundancy theorems over all proofs
#print axioms Logos.Models.Semantics.Diag_not_redundant
#print axioms Logos.Models.Semantics.ExprNegT_not_redundant
#print axioms Logos.Models.Semantics.Scope_not_redundant
#print axioms Logos.Models.Semantics.Disq_not_redundant
#print axioms Logos.Models.Semantics.NegSwapT_not_redundant
#print axioms Logos.Models.Semantics.NoGap_not_redundant
#print axioms Logos.Models.Semantics.NoGlut_not_redundant

-- internal-truth-1: gap and glut over one carrier and one negation
#print axioms Logos.Models.Semantics.gap_not_noGap
#print axioms Logos.Models.Semantics.glut_not_noGlut

-- self-closure-1: restatement, predicted axiom-free
#print axioms Logos.Systems.SelfClosure.selfClosed_excludes_exprNegT

-- self-closure-1: re-presentation and the two failure modes
#print axioms Logos.Models.Semantics.self_closure_possible
#print axioms Logos.Models.Semantics.simple_selfClosed
#print axioms Logos.Models.Semantics.simple_diag
#print axioms Logos.Models.Semantics.simple_not_expr

-- self-closure-1: the bound is tight at finite size
#print axioms Logos.Models.Semantics.maxLang_selfClosed
#print axioms Logos.Models.Semantics.maxLang_diag
#print axioms Logos.Models.Semantics.maxLang_not_expr
#print axioms Logos.Models.Semantics.maxLang_pred_universal
#print axioms Logos.Models.Semantics.maxLang_excluded
#print axioms Logos.Models.Semantics.maxLang_excluded_is_negTruth

-- self-closure-1: infinite size; omegaMax_diag is the one classical result
#print axioms Logos.Models.Semantics.omega_selfClosed
#print axioms Logos.Models.Semantics.omega_diag
#print axioms Logos.Models.Semantics.omega_not_expr
#print axioms Logos.Models.Semantics.omegaMax_selfClosed
#print axioms Logos.Models.Semantics.omegaMax_diag
#print axioms Logos.Models.Semantics.omegaMax_not_expr
#print axioms Logos.Models.Semantics.omegaMax_pred_universal
#print axioms Logos.Models.Semantics.omegaMax_excluded

-- truth-fact-seam-1: S1a, predicted axiom-free
#print axioms Logos.Models.Seam.s1a_val
#print axioms Logos.Models.Seam.s1a_T
#print axioms Logos.Models.Seam.s1a_scope_agree_on_image
#print axioms Logos.Models.Seam.s1a_scope_differ_off_image

-- truth-fact-seam-1: S1b
#print axioms Logos.Models.Seam.s1b_bridge_tru
#print axioms Logos.Models.Seam.s1b_bridge_both
#print axioms Logos.Models.Seam.s1b_selfClosed_tru
#print axioms Logos.Models.Seam.s1b_selfClosed_both
#print axioms Logos.Models.Seam.s1b_same_fact
#print axioms Logos.Models.Seam.s1b_val_differs
#print axioms Logos.Models.Seam.s1b_T_differs

-- truth-fact-seam-1: S2
#print axioms Logos.Models.Seam.s2_naming_surjective
#print axioms Logos.Models.Seam.s2_bridge_everywhere
#print axioms Logos.Models.Seam.s2_bridge_actualOnly
#print axioms Logos.Models.Seam.s2_agree_at_actual
#print axioms Logos.Models.Seam.s2_differ_off_actual
