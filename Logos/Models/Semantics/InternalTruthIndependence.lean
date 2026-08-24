/-
Logos / Models / Semantics / InternalTruthIndependence.lean

Independence set for the INTERNAL-TRUTH cut.

For each of the seven premises of `no_internal_truth` there is a model in which
that premise fails and the other six hold. Hence no premise is derivable from
the rest and none is redundant.

The number of branches is a RESULT here, not a preregistered claim. In
particular the gap branch and the glut branch are separated by which of
`NoGap` / `NoGlut` fails over ONE AND THE SAME three-element value carrier with
ONE AND THE SAME negation (`GapTV` and `GlutTV` differ only in `isT` / `isF`).
A single "negation has no fixed point" condition would have merged them, since
`negThree Three.thr = Three.thr` in both.
-/

import Logos.Systems.InternalTruth.Theorems

namespace Logos.Models.Semantics

open Logos.Ontology.Semantics
open Logos.Systems.InternalTruth

/-! ## Value carriers -/

inductive Three where
  | tru | fls | thr
  deriving DecidableEq

def negThree : Three → Three
  | .tru => .fls
  | .fls => .tru
  | .thr => .thr

/-- Classical two-valued carrier. -/
def BoolTV : TruthValues where
  V := Bool
  neg := not
  isT := fun v => v = true
  isF := fun v => v = false

/-- Two-valued carrier whose negation fixes every value. Used only to drop
`NegSwapT`. -/
def IdNegTV : TruthValues where
  V := Bool
  neg := fun v => v
  isT := fun v => v = true
  isF := fun v => v = false

/-- Gap carrier: `thr` is designated neither true nor false. -/
def GapTV : TruthValues where
  V := Three
  neg := negThree
  isT := fun v => v = Three.tru
  isF := fun v => v = Three.fls

/-- Glut carrier: same values, same negation, `thr` designated both. -/
def GlutTV : TruthValues where
  V := Three
  neg := negThree
  isT := fun v => v = Three.tru ∨ v = Three.thr
  isF := fun v => v = Three.fls ∨ v = Three.thr

/-! ## Value-carrier properties -/

theorem bool_negSwap : NegSwapT BoolTV := by intro v; cases v <;> simp [BoolTV]
theorem bool_noGap   : NoGap BoolTV   := by intro v; cases v <;> simp [BoolTV]
theorem bool_noGlut  : NoGlut BoolTV  := by intro v; cases v <;> simp [BoolTV]

theorem idneg_not_negSwap : ¬ NegSwapT IdNegTV := by
  intro h
  have hx : IdNegTV.isF true := (h true).mp (by simp [IdNegTV])
  simp [IdNegTV] at hx
theorem idneg_noGap  : NoGap IdNegTV  := by intro v; cases v <;> simp [IdNegTV]
theorem idneg_noGlut : NoGlut IdNegTV := by intro v; cases v <;> simp [IdNegTV]

theorem gap_negSwap : NegSwapT GapTV := by
  intro v; cases v <;> simp [GapTV, negThree]
theorem gap_noGlut : NoGlut GapTV := by
  intro v; cases v <;> simp [GapTV]
theorem gap_not_noGap : ¬ NoGap GapTV := by
  intro h
  cases h Three.thr with
  | inl hx => simp [GapTV] at hx
  | inr hx => simp [GapTV] at hx

theorem glut_negSwap : NegSwapT GlutTV := by
  intro v; cases v <;> simp [GlutTV, negThree]
theorem glut_noGap : NoGap GlutTV := by
  intro v; cases v <;> simp [GlutTV]
theorem glut_not_noGlut : ¬ NoGlut GlutTV := by
  intro h
  exact h Three.thr ⟨by simp [GlutTV], by simp [GlutTV]⟩

/-! ## A one-sentence language schema

One sentence, one code, one internal predicate. `a` is the external value of
the sentence, `b` the value of the predicate, `t` the internal verdict. -/

def constLang (TV : TruthValues) (a b : TV.V) (t : Option TV.V) : SemLanguage TV where
  Sent := Unit
  Code := Unit
  Pred := Unit
  q    := fun _ => ()
  val  := fun _ => a
  pval := fun _ _ => b
  T    := fun _ => t

section ConstLemmas
variable {TV : TruthValues} {a b : TV.V} {t : Option TV.V}

theorem const_diag (h : a = b) : Diag (constLang TV a b t) :=
  fun _ => ⟨(), h⟩

theorem const_not_diag (h : a ≠ b) : ¬ Diag (constLang TV a b t) :=
  fun hd => match hd () with | ⟨_, he⟩ => h he

theorem const_expr (h : ∀ u, t = some u → b = TV.neg u) :
    ExprNegT (constLang TV a b t) :=
  ⟨(), fun _ u hu => h u hu⟩

theorem const_not_expr {u0 : TV.V} (ht : t = some u0) (h : b ≠ TV.neg u0) :
    ¬ ExprNegT (constLang TV a b t) :=
  fun he => match he with | ⟨_, hp⟩ => h (hp () u0 ht)

theorem const_scope {u0 : TV.V} (ht : t = some u0) : Scope (constLang TV a b t) :=
  fun _ => ⟨u0, ht⟩

theorem const_not_scope (ht : t = none) : ¬ Scope (constLang TV a b t) := by
  intro hs
  cases hs () with
  | intro u hu => simp [constLang, ht] at hu

theorem const_disq (h : ∀ u, t = some u → u = a) : Disq (constLang TV a b t) :=
  fun _ u hu => h u hu

theorem const_not_disq {u0 : TV.V} (ht : t = some u0) (h : u0 ≠ a) :
    ¬ Disq (constLang TV a b t) :=
  fun hd => h (hd () u0 ht)

theorem const_expr_vacuous (ht : t = none) : ExprNegT (constLang TV a b t) :=
  ⟨(), fun _ u hu => by simp [constLang, ht] at hu⟩

theorem const_disq_vacuous (ht : t = none) : Disq (constLang TV a b t) :=
  fun _ u hu => by simp [constLang, ht] at hu

end ConstLemmas

/-! ## The seven witnesses -/

def LDiag  : SemLanguage BoolTV  := constLang BoolTV  true       false      (some true)
def LExpr  : SemLanguage BoolTV  := constLang BoolTV  true       true       (some true)
def LScope : SemLanguage BoolTV  := constLang BoolTV  true       true       none
def LDisq  : SemLanguage BoolTV  := constLang BoolTV  true       true       (some false)
def LNeg   : SemLanguage IdNegTV := constLang IdNegTV true       true       (some true)
def LGap   : SemLanguage GapTV   := constLang GapTV   Three.thr  Three.thr  (some Three.thr)
def LGlut  : SemLanguage GlutTV  := constLang GlutTV  Three.thr  Three.thr  (some Three.thr)

/-- 1. `Diag` is not derivable from the other six. -/
theorem drop_Diag :
    ¬ Diag LDiag ∧ ExprNegT LDiag ∧ Scope LDiag ∧ Disq LDiag
    ∧ NegSwapT BoolTV ∧ NoGap BoolTV ∧ NoGlut BoolTV :=
  ⟨const_not_diag (by simp),
   const_expr (fun u hu => by simp at hu; subst hu; simp [BoolTV]),
   const_scope rfl,
   const_disq (fun u hu => by simp at hu; subst hu; rfl),
   bool_negSwap, bool_noGap, bool_noGlut⟩

/-- 2. `ExprNegT` is not derivable from the other six. -/
theorem drop_ExprNegT :
    Diag LExpr ∧ ¬ ExprNegT LExpr ∧ Scope LExpr ∧ Disq LExpr
    ∧ NegSwapT BoolTV ∧ NoGap BoolTV ∧ NoGlut BoolTV :=
  ⟨const_diag rfl,
   const_not_expr rfl (by simp [BoolTV]),
   const_scope rfl,
   const_disq (fun u hu => by simp at hu; subst hu; rfl),
   bool_negSwap, bool_noGap, bool_noGlut⟩

/-- 3. `Scope` is not derivable from the other six. Tarski stratification. -/
theorem drop_Scope :
    Diag LScope ∧ ExprNegT LScope ∧ ¬ Scope LScope ∧ Disq LScope
    ∧ NegSwapT BoolTV ∧ NoGap BoolTV ∧ NoGlut BoolTV :=
  ⟨const_diag rfl,
   const_expr_vacuous rfl,
   const_not_scope rfl,
   const_disq_vacuous rfl,
   bool_negSwap, bool_noGap, bool_noGlut⟩

/-- 4. `Disq` is not derivable from the other six. -/
theorem drop_Disq :
    Diag LDisq ∧ ExprNegT LDisq ∧ Scope LDisq ∧ ¬ Disq LDisq
    ∧ NegSwapT BoolTV ∧ NoGap BoolTV ∧ NoGlut BoolTV :=
  ⟨const_diag rfl,
   const_expr (fun u hu => by simp at hu; subst hu; simp [BoolTV]),
   const_scope rfl,
   const_not_disq rfl (by simp),
   bool_negSwap, bool_noGap, bool_noGlut⟩

/-- 5. `NegSwapT` is not derivable from the other six. -/
theorem drop_NegSwapT :
    Diag LNeg ∧ ExprNegT LNeg ∧ Scope LNeg ∧ Disq LNeg
    ∧ ¬ NegSwapT IdNegTV ∧ NoGap IdNegTV ∧ NoGlut IdNegTV :=
  ⟨const_diag rfl,
   const_expr (fun u hu => by simp at hu; subst hu; rfl),
   const_scope rfl,
   const_disq (fun u hu => by simp at hu; subst hu; rfl),
   idneg_not_negSwap, idneg_noGap, idneg_noGlut⟩

/-- 6. `NoGap` is not derivable from the other six. Kripke-style gap. -/
theorem drop_NoGap :
    Diag LGap ∧ ExprNegT LGap ∧ Scope LGap ∧ Disq LGap
    ∧ NegSwapT GapTV ∧ ¬ NoGap GapTV ∧ NoGlut GapTV :=
  ⟨const_diag rfl,
   const_expr (fun u hu => by simp at hu; subst hu; rfl),
   const_scope rfl,
   const_disq (fun u hu => by simp at hu; subst hu; rfl),
   gap_negSwap, gap_not_noGap, gap_noGlut⟩

/-- 7. `NoGlut` is not derivable from the other six. Paraconsistent glut. -/
theorem drop_NoGlut :
    Diag LGlut ∧ ExprNegT LGlut ∧ Scope LGlut ∧ Disq LGlut
    ∧ NegSwapT GlutTV ∧ NoGap GlutTV ∧ ¬ NoGlut GlutTV :=
  ⟨const_diag rfl,
   const_expr (fun u hu => by simp at hu; subst hu; rfl),
   const_scope rfl,
   const_disq (fun u hu => by simp at hu; subst hu; rfl),
   glut_negSwap, glut_noGap, glut_not_noGlut⟩

/-! ## Non-vacuity of `Diag`

Every witness above satisfies `Diag` over a one-sentence language, where it is
nearly trivial. This model shows `Diag` is also satisfiable with more than one
sentence and a non-constant valuation, so `Diag` is not merely a by-product of
`Sent := Unit`. It claims nothing else. -/

def TwoSentLang : SemLanguage GapTV where
  Sent := Bool
  Code := Bool
  Pred := Unit
  q    := fun s => s
  val  := fun s => if s then Three.tru else Three.thr
  pval := fun _ _ => Three.thr
  T    := fun _ => some Three.thr

theorem twoSent_diag : Diag TwoSentLang := fun _ => ⟨false, rfl⟩

theorem twoSent_val_nonconstant :
    TwoSentLang.val true ≠ TwoSentLang.val false := by
  simp [TwoSentLang]

/-! ## Non-redundancy

The seven witnesses above are not merely evidence that the particular proof
term of `no_internal_truth` mentions each hypothesis. Each of the following
says that the remaining six premises do NOT entail `False`, for ANY proof.
That is the load-bearing claim; a compile-failure experiment on one proof term
is not, and is not used here. -/

theorem Diag_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        ExprNegT L → Scope L → Disq L → NegSwapT TV → NoGap TV → NoGlut TV → False) := by
  intro h
  have ⟨_, h2, h3, h4, h5, h6, h7⟩ := drop_Diag
  exact h BoolTV LDiag h2 h3 h4 h5 h6 h7

theorem ExprNegT_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → Scope L → Disq L → NegSwapT TV → NoGap TV → NoGlut TV → False) := by
  intro h
  have ⟨h1, _, h3, h4, h5, h6, h7⟩ := drop_ExprNegT
  exact h BoolTV LExpr h1 h3 h4 h5 h6 h7

theorem Scope_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → ExprNegT L → Disq L → NegSwapT TV → NoGap TV → NoGlut TV → False) := by
  intro h
  have ⟨h1, h2, _, h4, h5, h6, h7⟩ := drop_Scope
  exact h BoolTV LScope h1 h2 h4 h5 h6 h7

theorem Disq_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → ExprNegT L → Scope L → NegSwapT TV → NoGap TV → NoGlut TV → False) := by
  intro h
  have ⟨h1, h2, h3, _, h5, h6, h7⟩ := drop_Disq
  exact h BoolTV LDisq h1 h2 h3 h5 h6 h7

theorem NegSwapT_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → ExprNegT L → Scope L → Disq L → NoGap TV → NoGlut TV → False) := by
  intro h
  have ⟨h1, h2, h3, h4, _, h6, h7⟩ := drop_NegSwapT
  exact h IdNegTV LNeg h1 h2 h3 h4 h6 h7

theorem NoGap_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → ExprNegT L → Scope L → Disq L → NegSwapT TV → NoGlut TV → False) := by
  intro h
  have ⟨h1, h2, h3, h4, h5, _, h7⟩ := drop_NoGap
  exact h GapTV LGap h1 h2 h3 h4 h5 h7

theorem NoGlut_not_redundant :
    ¬ (∀ (TV : TruthValues) (L : SemLanguage TV),
        Diag L → ExprNegT L → Scope L → Disq L → NegSwapT TV → NoGap TV → False) := by
  intro h
  have ⟨h1, h2, h3, h4, h5, h6, _⟩ := drop_NoGlut
  exact h GlutTV LGlut h1 h2 h3 h4 h5 h6

end Logos.Models.Semantics
