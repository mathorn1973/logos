/-
Logos / Systems / SelfClosure / Theorems.lean

The upper bound on self-closure.

`selfClosed_excludes_exprNegT` is a CONTRAPOSITIVE RESTATEMENT of
`no_internal_truth` and carries no content beyond it. It is stated because the
positive framing is what the models of this cut are measured against. The new
content of this cut is entirely in
`Logos/Models/Semantics/SelfClosure.lean`, which shows the bound is tight.
-/

import Logos.Systems.SelfClosure.Axioms
import Logos.Systems.InternalTruth.Theorems

namespace Logos.Systems.SelfClosure

open Logos.Ontology.Semantics Logos.Systems.InternalTruth

/-- A bivalent, self-closed language in which diagonalisation holds cannot
express the negation of its own truth predicate. -/
theorem selfClosed_excludes_exprNegT
    {TV : TruthValues} (L : SemLanguage TV)
    (hSC : SelfClosed L) (hB : Bivalent TV) (hNeg : NegSwapT TV)
    (hDiag : Diag L) : ¬ ExprNegT L :=
  fun hExpr => no_internal_truth L hDiag hExpr hSC.1 hSC.2 hNeg hB.1 hB.2

end Logos.Systems.SelfClosure
