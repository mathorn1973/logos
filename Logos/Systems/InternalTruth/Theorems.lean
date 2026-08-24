/-
Logos / Systems / InternalTruth / Theorems.lean

Main theorem of the INTERNAL-TRUTH cut.

This is NOT Tarski's undefinability theorem. There is no arithmetisation, no
coding of syntax, no representability, and no theory. `q`, `pval` and the
diagonal property are primitive assumptions, put on the table on purpose so
that the boundary audit can see them.
-/

import Logos.Systems.InternalTruth.Axioms

namespace Logos.Systems.InternalTruth

open Logos.Ontology.Semantics

/-- The seven premises are jointly unsatisfiable.

Every hypothesis is used. See `Logos.Models.Semantics.InternalTruthIndependence`
for a witness that each of the seven may be dropped, the other six retained. -/
theorem no_internal_truth
    {TV : TruthValues} (L : SemLanguage TV)
    (hDiag  : Diag L)
    (hExpr  : ExprNegT L)
    (hScope : Scope L)
    (hDisq  : Disq L)
    (hNeg   : NegSwapT TV)
    (hGap   : NoGap TV)
    (hGlut  : NoGlut TV) : False := by
  cases hExpr with
  | intro p hp =>
    cases hDiag p with
    | intro s hs =>
      cases hScope s with
      | intro u hu =>
        have hval : u = L.val s := hDisq s u hu
        have hpv  : L.pval p (L.q s) = TV.neg u := hp (L.q s) u hu
        have hfix : u = TV.neg u := hval.trans (hs.trans hpv)
        cases hGap u with
        | inl h =>
          have h2 : TV.isT (TV.neg u) := by rw [← hfix]; exact h
          exact hGlut u ⟨h, (hNeg u).mp h2⟩
        | inr h =>
          have h2 : TV.isT (TV.neg u) := (hNeg u).mpr h
          have h3 : TV.isT u := by rw [hfix]; exact h2
          exact hGlut u ⟨h3, h⟩

end Logos.Systems.InternalTruth
