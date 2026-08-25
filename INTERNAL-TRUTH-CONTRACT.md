# INTERNAL-TRUTH-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - NOT ON MAIN**.

Base: `main` at `6a16b8d`, after the A4 fact-independence closure.

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

Read this before treating the contract as a preregistration.

The semantics of section 3 and the premise list of section 4 were fixed in discussion before any Lean was written. The four design decisions of section 3 in particular were settled as corrections to an earlier and worse proposal: `T` landing in `Option V` rather than `V`, diagonalisation quantified over a `Pred` carrier rather than over all ambient functions, and a single negation-fixed-point condition split into two independent designation conditions.

However, an experimental implementation of that specification existed before this contract file was written. **This run is therefore not a blind preregistration.** The contract is a faithful reconstruction of the pre-implementation specification, committed before the Lean is reapplied, and no definition below was altered to suit a proof. The purpose of the cycle rule is to stop definitions drifting toward whatever the proof needs; it is not a requirement to forget a known proof. Whether that is sufficient is a human judgement and is recorded here so it can be made.

## 1. Motivation

A recurring informal argument runs: if reality is exhaustively a formal or numerical structure, then the truth of a complete description of that structure cannot itself be one more item inside it, and therefore something escapes the structure. The argument is usually credited to Tarski.

That argument is not the object of this cut and this cut does not evaluate it. What is isolated here is a narrower question, askable without any metaphysics:

```text
Under what exact conditions is a language unable to carry a total,
correct truth predicate for its own sentences?
```

Two separations drive the design.

**Logical layer versus transfer premise.** A claim that a system cannot define its own truth is a claim about definability at a level. A claim that a totality must contain the semantic facts needed to describe itself is a separate metaphysical premise. Call the second `SemanticClosure`. It is not formalised here, not assumed here, and no result below may mention it. Conflating the two is the error this contract exists to prevent.

**Gap versus glut.** A single condition of the form "negation has no fixed point among truth values" cannot distinguish a truth-value gap from a truth-value glut: both give `neg v = v` at the offending value. Merging them produces a false branch count.

## 2. Claim type

Per `PROJECT-RULES.md` section 2:

```text
formal definition   TruthValues, SemLanguage
formal assumption   Diag, ExprNegT, Scope, Disq, NegSwapT, NoGap, NoGlut
proved theorem      the joint-unsatisfiability target of 5.1
countermodel        the independence witnesses of 5.2
interpretation      sections 1 and 9 only
```

Nothing in sections 0, 1 or 9 may become a premise of anything in `Logos/`.

## 3. Language

Two carriers, no laws. All constraints are separate propositions.

```text
TruthValues
  V    : Type
  neg  : V -> V
  isT  : V -> Prop
  isF  : V -> Prop

SemLanguage (TV : TruthValues)
  Sent : Type
  Code : Type
  Pred : Type
  q    : Sent -> Code
  val  : Sent -> TV.V
  pval : Pred -> Code -> TV.V
  T    : Code -> Option TV.V
```

Four frozen design decisions.

**`V` is a parameter, not `Prop`.** Over `Prop` the proposition `not (exists p, p <-> not p)` is provable, intuitionistically. A negation-fixed-point condition would then not be droppable, and gap-based and glut-based countermodels would be inexpressible. Project rule 6 forbids a system that cannot express the failure of its own theorem.

**`isT` and `isF` are independent.** See section 1.

**`T` lands in `Option TV.V`.** `none` means the internal predicate does not apply to that code at all, which is the stratification case. `some u` means it applies and returns a possibly non-classical value. A function `Code -> TV.V` is total by typing, which makes the scope premise vacuous and leaves stratification and gappiness indistinguishable.

**`pval` ranges over a carrier `Pred`, not over all functions `Code -> TV.V`.** Quantifying diagonalisation over the ambient function space would grant the object language exactly the metalanguage strength under measurement. Coding of syntax and diagonalisation against a semantic predicate must stay separable: `q` gives the first, `Diag` together with `ExprNegT` gives the second.

## 4. Assumptions

Seven propositions, defined separately and never bundled into one record. Bundling would defeat the boundary audit.

```text
Diag      forall p : Pred, exists s : Sent, val s = pval p (q s)
ExprNegT  exists p : Pred, forall c u, T c = some u -> pval p c = neg u
Scope     forall s : Sent, exists u, T (q s) = some u
Disq      forall s u, T (q s) = some u -> u = val s
NegSwapT  forall v, isT (neg v) <-> isF v
NoGap     forall v, isT v \/ isF v
NoGlut    forall v, not (isT v /\ isF v)
```

`Disq` is stated conditionally so that it is independent of `Scope`.

Any law not used by the target theorem, including the converse swap law `isF (neg v) <-> isT v`, must not appear as a premise. Project rule 5.

## 5. Targets

### 5.1 Main target

```text
no_internal_truth : Diag L -> ExprNegT L -> Scope L -> Disq L
                    -> NegSwapT TV -> NoGap TV -> NoGlut TV -> False
```

### 5.2 Independence set

Seven witnesses, one per premise, each asserting that the named premise fails and the other six hold.

One structural requirement is frozen in advance rather than left to the implementer. The gap witness and the glut witness **must share the same value type and the same negation function**, differing only in `isT` and `isF`. If they do not, the cut has not demonstrated the separation of section 1 and the branch count is not established.

Which concrete models realise the seven is a result, not a commitment, and is reported in the pull request.

### 5.3 Non-redundancy

Independence must be stated as a theorem about all proofs, not about one proof term:

```text
<premise>_not_redundant :
  not (forall TV L, <the other six premises> -> False)
```

one per premise. A compile-failure experiment showing that removing a hypothesis breaks the existing proof establishes only that this proof term mentions it. It is not an independence argument and must not be reported as one.

### 5.4 Non-vacuity of `Diag`

`Diag` must be shown satisfiable over a language with more than one sentence and a non-constant valuation, so that its presence in the witnesses is not an artefact of a one-element sentence type.

## 6. What this establishes

Seven conditions are jointly inconsistent and none is redundant. Every escape from the liar therefore has an address in this list, and the number of addresses is whatever the independence set proves it to be, not a number chosen in advance.

Named readings of the exits belong to the interpretation layer only.

## 7. What this does not establish

This is not Tarski's undefinability theorem. There is no arithmetic, no Goedel coding, no representability, and no theory. `q`, `pval`, `Diag` and `ExprNegT` are primitive assumptions, placed on the table so the audit can see them. No file in `Logos/` may claim otherwise, and no documentation of this cut may describe it as a formalisation of Tarski.

Nothing about meaning, reference, experience, or any theory of mind.

Nothing about physicalism, materialism, or whether reality is numerical. `SemanticClosure` is not stated.

Nothing about necessary reality, grounding, or the totality fact.

Nothing showing that there is no absolute standpoint. `val : Sent -> TV.V` grants an external valuation by assumption. The target is the gap between an assumed external valuation and a candidate internal predicate. A Lean development is always conducted from a metalanguage; that is a property of the medium, not a hidden result.

## 8. Boundary

```text
NO A0-A8            NO God predicate        NO Goedel-Scott premise
NO TWIST-J          NO physical predicate   NO theological predicate
NO Entity carrier   NO Fact carrier         NO World carrier
NO grounding, explanation, constitution or modality vocabulary
NO SemanticClosure  NO arithmetic           NO mathlib
```

Required import firewall:

```text
Logos/Ontology/Semantics/Language.lean                 imports nothing
Logos/Systems/InternalTruth/Axioms.lean                -> Ontology.Semantics.Language
Logos/Systems/InternalTruth/Theorems.lean              -> Systems.InternalTruth.Axioms
Logos/Models/Semantics/InternalTruthIndependence.lean  -> Systems.InternalTruth.Theorems
```

The cut must be a leaf: no existing module may import any file of it.

## 9. Remaining philosophical boundary

Interpretation, not results, and not importable.

**Relation to the fact carrier is open and is not this cut.** Verified on `main` at `6a16b8d`: `FactModel` supplies `Fact : Type w`, `holdsAt` and `groundsFact`, with no syntax, no coding and no truth predicate, and nothing forbids instantiating `Fact` with the sentence type itself. `RegressTotality` adds only a distinguished `totality : F.Fact`, its actuality, and `inside`.

Two non-implications between `RegressTotality` and the structure of section 3 would be worthless: the signatures are disjoint and any two such models can be glued as unrelated worlds. The renaming worry is a definability worry and needs a bridge, hence a separate seam cut with its own contract, on the precedent of `route-seam-1`. The test shape that would actually settle it:

```text
bridge   sentenceFact : Sent -> F.Fact
         ActualFact F (sentenceFact s)  <->  isT (val s)

S1       two linked models sharing FactModel, sentenceFact and the bridge,
         differing in T
S2       two linked models sharing the whole language side,
         differing in holdsAt
```

`S1` is the substantive direction: it would show `T` is not a function of the fact-side data, which is exactly the denial that this is `holdsAt` renamed. `S2` is weak as written, since facts outside the image of `sentenceFact` are unconstrained by the bridge; the seam contract must decide whether to require `sentenceFact` surjective. Neither has been attempted, and until both exist this cut says nothing about whether the truth axis is new.

**The interesting metaphysical question is not in this cut.** A stratified language answers the liar without leaving the mathematical: every particular sentence receives a value at some level, none is left unevaluated. Pressure arises only for a claim quantifying across all levels at once, which is the absolute generality problem and not a truth-definability problem. Not formalised, and this cut gives no evidence about it either way.

## 10. Acceptance tests

To be run against `main` at `6a16b8d` with `leanprover/lean4:v4.30.0`, `lake-manifest.json` packages empty. Results are reported in the pull request, not here.

```text
T1   lake build succeeds
T2   no sorry, sorryAx or native_decide in the new files
T3   #print axioms on the main theorem reports at most
     propext, Classical.choice, Quot.sound
T4   #print axioms on every witness and every non-redundancy theorem
     reports at most propext, Classical.choice, Quot.sound
T5   one independence witness per premise, seven in total
T6   one non-redundancy theorem per premise, in the form of 5.3
T7   the gap witness and the glut witness share value type and negation
     and differ only in isT / isF
T8   Diag satisfiable with more than one sentence and non-constant valuation
T9   forbidden-token scan over the new files is empty
T10  no existing module imports any file of this cut
```
