/-
Logos / Ontology / Semantics / Language.lean

Semantic carrier for the INTERNAL-TRUTH cut.

Layer: ontology language. Depends on nothing but Lean core.

This file introduces NO premises. It only fixes the vocabulary in which the
premises of `Logos.Systems.InternalTruth` are stated. Every constraint on
these carriers is an explicit, separately droppable proposition living in
`Logos/Systems/InternalTruth/Axioms.lean`.

Deliberate design notes, frozen by INTERNAL-TRUTH-CONTRACT.md:

* `V` is a parameter, not `Prop`. Over `Prop` the negation-fixed-point
  condition is a theorem (`¬(p ↔ ¬p)` is provable), so gap-based and
  glut-based countermodels would be inexpressible.

* `isT` and `isF` are two independent designation predicates, not one.
  A single "negation has no fixed point" condition cannot separate a
  truth-value gap from a truth-value glut: both give `neg v = v`.

* `T` lands in `Option TV.V`, not `TV.V`. `none` means the internal
  predicate does not apply to that code at all (stratification);
  `some u` means it applies and returns `u`. Without `Option`, a
  `Code -> V` is total by typing and the scope premise is vacuous.

* `pval` ranges over a carrier `Pred` of internally expressible
  predicates, NOT over all functions `Code -> V`. Quantifying over the
  full Lean function space would import exactly the metalanguage strength
  whose absence is under measurement.
-/

namespace Logos.Ontology.Semantics

/-- A truth-value carrier: values, a negation operation, and two independent
designation predicates. No laws. -/
structure TruthValues where
  V   : Type
  neg : V → V
  isT : V → Prop
  isF : V → Prop

/-- A language with an external valuation and a candidate internal truth
predicate. No laws.

`Sent` sentences, `Code` names of sentences, `Pred` internally expressible
unary predicates, `q` the naming map, `val` the external valuation,
`pval` the semantic value of an internal predicate at a code,
`T` the candidate internal truth predicate. -/
structure SemLanguage (TV : TruthValues) where
  Sent : Type
  Code : Type
  Pred : Type
  q    : Sent → Code
  val  : Sent → TV.V
  pval : Pred → Code → TV.V
  T    : Code → Option TV.V

end Logos.Ontology.Semantics
