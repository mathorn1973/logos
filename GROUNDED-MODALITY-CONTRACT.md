# DESIGN CONTRACT — GROUNDED-MODALITY-1

Status: **NON-CANONICAL DESIGN CONTRACT**.

This cut attacks the final `brute modal asymmetry` left by `CONTINGENT-ABSOLUTE-1`.

The target is not to redefine necessity as unconditionedness and not to reintroduce EF4 under another name.  It separates raw Kripke accessibility from metaphysically licensed modal variation and tests the exact bridge between them.

## 1. Problem

The previous cut permits:

```text
p holds at the actual world;
p fails at an accessible world;
p has no explanation.
```

Nothing in ordinary Kripke semantics requires the accessibility edge itself to have any metaphysical basis.

Therefore the last brute position may reside not in entity grounding or fact explanation but in the modal frame itself.

## 2. Modal variation layer

`ModalVariationModel` introduces a separate carrier:

```text
Condition
availableAt : World -> Condition -> Prop
licensesFailure : Condition -> Fact -> World -> Prop
```

A condition is deliberately not identified with an entity or an explanatory source.

The layer distinguishes:

```text
raw accessible failure
  access(actual, w) and not p(w)

grounded failure
  raw accessible failure
  plus an actual modal condition licensing that failure
```

This is a new semantic axis, independent of explanatory grounding.

## 3. Modal unconditionedness

Define:

```text
ModallyUnconditionedFact(V, p)
```

as:

```text
p is actual
and
there is no grounded accessible failure of p.
```

This is **not** definitionally modal necessity.

A raw accessible counterexample may still exist if the frame contains an unlicensed/brute modal edge.

`FullyUnconditionedFact(G, V, p)` combines:

```text
explanatory ultimacy
and
modal unconditionedness
```

but still contains no necessity clause.

## 4. No-brute modality

The substantive bridge is:

```text
NoBruteModalVariationAt(V, p)
```

meaning:

> every accessible world where p fails has an actual modal condition licensing that failure.

This is the precise formal version of the principle:

> a genuine modal difference cannot be a completely unsupported feature of the accessibility relation.

LOGOS does not assert this principle unconditionally.

## 5. Main theorem

Lean must prove:

```text
NoBruteModalVariationAt(V, p)
+
ModallyUnconditionedFact(V, p)
->
NecessaryFact(p)
```

and hence:

```text
NoBruteModalVariationAt(V, p)
->
(ModallyUnconditionedFact(V, p)
 IFF
 ModallyAbsoluteFact(p))
```

A fully unconditioned fact therefore becomes necessary under the no-brute-modality bridge.

No EF4, A2, A3, externality principle, or anti-self-explanation principle occurs in this proof.

## 6. Price of contingency

Under no-brute modality:

```text
not NecessaryFact(p)
->
GroundedFailurePossible(V, p)
```

So if p is contingent, some actual modal condition must license a concrete accessible failure.

This is the intended sharpening of the philosophical question:

> if an absolute fact could fail, what makes that failure a genuine possibility rather than a bare formal alternative?

## 7. Independence models

### A. Fully unconditioned but non-necessary without no-brute modality

Reuse the existing brute-totality model and give it no modal conditions at all.

Then:

```text
ExplanatorilyAbsoluteFact(totality)
ModallyUnconditionedFact(totality)
not NecessaryFact(totality)
```

and `NoBruteModalVariationAt` fails at the accessible `absent` world.

Therefore unconditionedness does not imply necessity if raw accessibility may contain brute alternatives.

### B. No-brute modality without EF4

Give the contingent brute-totality fact an explicit modal condition licensing its failure at the `absent` world, while leaving its explanatory relation empty.

Then:

```text
NoBruteModalVariationAt(totality)
not LocalFactSufficientExplanation(totality)
ExplanatorilyAbsoluteFact(totality)
not NecessaryFact(totality)
```

Therefore no-brute modality does not imply EF4.  Modal conditioning and explanation are distinct.

### C. EF4 without no-brute modality

Reuse the positive explained-totality model but give it no modal conditions.

Then:

```text
LocalFactSufficientExplanation(totality)
```

holds, while `NoBruteModalVariationAt` fails.

Therefore EF4 does not imply no-brute modality.

The new bridge is not EF4 in disguise.

## 8. Interpretation

The central distinction is:

```text
logical accessibility
!=
metaphysically grounded possibility
```

Kripke `access` remains the general modal logic layer.

`ModalVariationModel` records an additional metaphysical interpretation of some accessible contrasts as grounded/licensed.

Under no-brute modality, every accessible contrast is required to have such grounding.  Only under that additional commitment does modal unconditionedness collapse to ordinary necessity.

## 9. What the cut does not prove

It does not prove:

```text
every Kripke-accessible world is metaphysically possible;
every modal contrast must have a condition;
explanatory ultimacy alone implies modal unconditionedness;
modal conditions are entities;
modal conditions explain actuality;
necessity follows from mere actuality;
a necessary fact is explanatorily absolute;
a necessary reality is ungrounded;
a necessary reality is God.
```

In particular, the cut explicitly rejects the invalid inference:

```text
Actual(p) -> Necessary(p)
```

for arbitrary facts.

## 10. Remaining philosophical boundary

If this cut closes, the residual choice is extremely narrow:

```text
A  every genuine modal contrast is grounded/licensed;

or

B  the modal structure of reality may contain brute alternatives:
   p is actual, not-p is genuinely possible, and nothing whatsoever
   makes that contrast possible.
```

LOGOS can verify the consequences of A and exhibit models for B.  Human judgment remains responsible for deciding whether brute modality is metaphysically coherent.

## 11. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. modal conditions remain a separate carrier from entities and explanatory sources;
4. modal unconditionedness is not definitionally necessity;
5. no-brute modality plus modal unconditionedness proves necessity;
6. necessity implies modal unconditionedness;
7. under no-brute modality the two notions are equivalent;
8. the fully-unconditioned-but-contingent countermodel elaborates when no-brute modality is absent;
9. no-brute modality without EF4 model elaborates;
10. EF4 without no-brute modality model elaborates;
11. dedicated axiom audit is green;
12. no theological interpretation enters the proof core.
