/-
Logos / Systems / InternalTruth / Axioms.lean

The seven premises of the INTERNAL-TRUTH cut, each a standalone proposition.

They are deliberately NOT bundled into one axiom record. The point of the cut
is that each is separately droppable and that dropping each one is satisfiable.
Bundling would defeat the boundary audit.
-/

import Logos.Ontology.Semantics.Language

namespace Logos.Systems.InternalTruth

open Logos.Ontology.Semantics

variable {TV : TruthValues}

/-- D. Diagonalisation, restricted to internally expressible predicates.
For every internal predicate there is a sentence whose external value is the
value of that predicate at that sentence's own code. -/
def Diag (L : SemLanguage TV) : Prop :=
  ∀ p : L.Pred, ∃ s : L.Sent, L.val s = L.pval p (L.q s)

/-- L. Expressibility of the negated internal truth predicate.
Some internal predicate agrees with `neg ∘ T` wherever `T` applies.
Note this is strictly more than syntax coding: a language may name its own
sentences without being able to express negated internal truth. -/
def ExprNegT (L : SemLanguage TV) : Prop :=
  ∃ p : L.Pred, ∀ (c : L.Code) (u : TV.V), L.T c = some u → L.pval p c = TV.neg u

/-- S. Scope. The internal truth predicate applies to every sentence of the
language, i.e. is not stratified away from its own object level. -/
def Scope (L : SemLanguage TV) : Prop :=
  ∀ s : L.Sent, ∃ u : TV.V, L.T (L.q s) = some u

/-- Tdis. Disquotation, stated conditionally so that it is independent of
`Scope`: where the internal predicate applies, it returns the external value. -/
def Disq (L : SemLanguage TV) : Prop :=
  ∀ (s : L.Sent) (u : TV.V), L.T (L.q s) = some u → u = L.val s

/-- N. Negation swaps designation. Only the `isT ∘ neg` law is stated; the
converse `isF ∘ neg` law is satisfied by every model exhibited in the
independence set but is NOT used by the main theorem, so by the minimal
boundary rule it is not a premise. -/
def NegSwapT (TV : TruthValues) : Prop :=
  ∀ v : TV.V, TV.isT (TV.neg v) ↔ TV.isF v

/-- G. No gaps: every value is designated true or designated false. -/
def NoGap (TV : TruthValues) : Prop :=
  ∀ v : TV.V, TV.isT v ∨ TV.isF v

/-- K. No gluts: no value is designated both true and false. -/
def NoGlut (TV : TruthValues) : Prop :=
  ∀ v : TV.V, ¬ (TV.isT v ∧ TV.isF v)

end Logos.Systems.InternalTruth
