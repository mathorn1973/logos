# DESIGN CONTRACT — SELF-EXPLANATION-1

Status: **NON-CANONICAL DESIGN CONTRACT**.

This cut attacks the irreflexivity principle `I` used by the totality-explanation route. Its purpose is to determine how much anti-self-explanation content is actually needed to refute pure contingency.

It does not define God, does not attribute any positive property to necessary reality, and does not assume A2, A3, primitive externality E, or primitive explanatory externality E*.

## 1. First reduction: global I is too strong

The previous principle was:

```text
I
every actual entity fails to explain itself.
```

A much weaker principle suffices:

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

Lean proves these two formulations equivalent and proves that global I implies Ic.

A concrete model then shows the converse is unnecessary for the argument:

```text
a necessary root explains itself;
global irreflexivity I fails;
Ic holds for all non-necessary targets;
the necessary-reality theorem remains true.
```

Therefore full I is surplus structure.

## 2. Second reduction: even global Ic is too strong

The argument does not need to forbid contingent self-citation everywhere in the explanatory graph.

It needs only a local adequacy condition on the explanations delivered by the *specific explanation of the totality*.

Define:

```text
AdequateExplainsEntity(a, x)
```

to mean:

```text
a actually explains x,
and if x is non-necessary then a is distinct from x.
```

Necessary targets remain unrestricted.

The corresponding package is:

```text
AdequateTotalityScopeAxioms
```

with only:

```text
EF4  every actual non-necessary fact has an explanatory source
LA   the explanation of the represented totality adequately explains each actual member in its scope
C    every actual non-necessary entity lies inside the represented totality
```

No global I and no global Ic occurs.

## 3. Deepest theorem in this cut

Lean proves:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and a explains the totality fact.
```

from `EF4 + LA + C` alone.

The proof is minimal:

```text
assume a explains the totality fact;
if a were non-necessary, C would place a inside the totality;
LA would require the totality explanation to adequately explain a;
for a non-necessary target, adequacy requires source != target;
but the source here is a itself;
contradiction;
therefore a is necessary.
```

No well-foundedness, unity, primitive externality, explanatory externality, global irreflexivity, or global contingent-self-exclusion premise is used.

## 4. Model showing global Ic is also surplus

The cut contains a stronger positive stress test:

```text
the necessary root explains the totality;
the root may self-explain;
a contingent internal node also self-explains elsewhere;
therefore global Ic fails;
local adequacy of the totality explanation still holds;
necessary reality still follows.
```

This is the decisive reduction: contingent self-citation as such is not forbidden. What is rejected is counting an identity citation as an *adequate answer supplied by the complete explanation of the totality* for that very contingent source.

## 5. Exact countermodel

The existing pure-contingency model supplies the opposite case:

```text
the totality fact is non-necessary;
every actual entity is non-necessary;
an internal node explains the totality;
that same node explains itself;
EF4 holds;
totality coverage holds;
raw scope coverage holds;
local adequacy fails exactly at source = target;
pure contingency survives.
```

Therefore the remaining load-bearing issue is not general self-explanation. It is whether identity citation may count as adequate explanation of contingent existence within a purported complete explanation.

## 6. Philosophical reading

The residual issue is now semantic rather than structural.

The disputed form is:

```text
P because P
```

when P is contingent.

LOGOS does **not** prove that this formula is logically contradictory. It is not.

The formal claim is narrower:

> if a purported complete explanation answers the question why a contingent member exists by citing only that same member as its explanatory source, that citation is not counted as an adequate explanatory discharge.

An opponent may reject that adequacy criterion. If so, the countermodel shows exactly what becomes possible: a completely contingent reality closed by circular self-citation.

## 7. What this cut does not claim

The cut does not claim:

```text
self-explanation is logically contradictory;
necessary reality cannot explain itself;
contingent entities may never self-cite in any explanatory relation;
all explanatory relations are asymmetric;
all grounding relations are well founded;
a necessary explainer is ungrounded;
a necessary explainer is God.
```

The cut leaves necessary reality completely undescribed beyond necessity.

## 8. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `ContingentExplanationProper` and `ContingentSelfExplanationExcluded` are proved equivalent;
4. global irreflexivity implies the weaker criterion but is refuted in a positive model;
5. necessary self-explanation is compatible with the theorem;
6. global contingent self-citation is also compatible with the theorem when it occurs outside the local totality explanation;
7. `AdequateTotalityScopeAxioms` proves the necessary-reality dichotomy without I or Ic;
8. the pure-contingency countermodel fails local adequacy exactly at a contingent self-citation;
9. the main theorem contains no A2, A3, E, E*, global I, or global Ic assumption;
10. the dedicated self-explanation axiom audit is green;
11. no theological interpretation enters the proof core.

## 9. Remaining attack surface

After the two reductions, there is no broad metaphysical anti-self-explanation axiom left to attack.

The remaining human judgment is the meaning of *adequate explanation*:

> Can an identity citation `P because P` count as a complete explanation of why contingent P obtains?

Lean can expose the consequences of answering yes or no. It cannot decide the intended semantics of the word "explanation" independently of a humanly chosen adequacy criterion.
