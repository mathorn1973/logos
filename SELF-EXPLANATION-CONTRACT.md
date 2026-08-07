# DESIGN CONTRACT — SELF-EXPLANATION-1

Status: **NON-CANONICAL DESIGN CONTRACT**.

This cut attacks the irreflexivity principle `I` used by the totality-explanation route.  Its purpose is to determine how much anti-self-explanation content is actually needed to refute pure contingency.

It does not define God, does not attribute any positive property to necessary reality, and does not assume A2, A3, primitive externality E, or primitive explanatory externality E*.

## 1. Main finding

Global explanatory irreflexivity is stronger than the argument requires.

The previous principle was:

```text
I
every actual entity fails to explain itself.
```

The minimal principle needed here is only:

```text
Ic
if x is actual and non-necessary,
then x does not explain its own existence.
```

Equivalently:

```text
an explanation of an actual non-necessary target
must use a source distinct from that target.
```

The formal names are:

```text
ContingentSelfExplanationExcluded
ContingentExplanationProper
```

Lean proves these two formulations equivalent.

## 2. Why this is weaker

`Ic` says nothing about self-explanation of a necessary entity.

The cut therefore does not attempt to answer whether necessary reality may be described as self-explanatory, self-grounding, or neither.  Such language lies outside the target.

A concrete model is required in which:

```text
a necessary root explains itself;
global irreflexivity I fails;
Ic still holds for all non-necessary targets;
the necessary-reality theorem remains true.
```

This demonstrates formally that full I was surplus structure.

## 3. Minimal theorem package

The load-bearing assumptions are now:

```text
EF4  every actual non-necessary fact has an explanatory source
S    an explanation of the represented totality explains every entity inside it
Ic   explanations of actual non-necessary entities are proper/non-identical
C    every actual non-necessary entity lies inside the represented totality
```

From these, Lean proves:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and a explains the totality fact.
```

No global irreflexivity premise occurs.

The proof is short:

```text
assume a explains the totality fact;
if a were non-necessary, C would place a inside the totality;
S would then make a explain itself;
Ic forbids that for a non-necessary entity;
therefore a is necessary.
```

Together with EF4, a non-necessary totality fact therefore yields a necessary explainer.

## 4. Countermodel to Ic

The cut must preserve the existing pure-contingency model in which:

```text
the totality fact is non-necessary;
every actual entity is non-necessary;
an internal node explains the totality;
that same node explains itself;
EF4 holds;
S holds;
C holds.
```

In that model `ContingentExplanationProper` fails and pure contingency survives.

Therefore Ic is load-bearing.

## 5. Philosophical reading

`Ic` is not presented as a theorem of pure modal logic.

It is an adequacy criterion for explanation of contingent existence:

> citing the very contingent existence whose obtaining is in question does not by itself supply a distinct explanatory source.

The objection to Ic must therefore be explicit:

> an actual entity may fail to exist necessarily and nevertheless its own existence may count as a complete explanation of why it exists.

LOGOS does not hide that option.  It provides a concrete model showing that accepting it restores a fully contingent reality.

## 6. What this cut does not claim

The cut does not claim:

```text
self-explanation is logically contradictory;
necessary reality cannot explain itself;
all explanatory relations are asymmetric;
all grounding relations are well founded;
a necessary explainer is ungrounded;
a necessary explainer is God.
```

The formal result is only that global anti-self-explanation can be weakened to contingent explanatory non-vacuity.

## 7. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `ContingentExplanationProper` and `ContingentSelfExplanationExcluded` are proved equivalent;
4. global irreflexivity is proved sufficient but not necessary for the minimal criterion;
5. the necessary-self-citation positive model elaborates;
6. the positive model explicitly refutes global irreflexivity;
7. the pure-contingency self-explanation countermodel elaborates;
8. the main theorem contains no A2, A3, E, E*, or global I assumption;
9. a dedicated axiom audit covers all new load-bearing theorems and models;
10. no theological interpretation enters the proof core.

## 8. Next attack surface

If this cut closes, the remaining question about I is semantic rather than structural:

> Is `P because P` an adequate explanation when P is contingent?

A later cut may attempt to replace Ic by a more primitive account of explanatory non-vacuity, novelty, or contrast.  Until then Ic remains an explicit humanly judged adequacy principle, not an unconditional theorem about reality.
