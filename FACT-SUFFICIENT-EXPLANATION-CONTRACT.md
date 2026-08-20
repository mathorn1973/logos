# DESIGN CONTRACT — FACT-SUFFICIENT-EXPLANATION-1

Status: **NON-CANONICAL DESIGN CONTRACT**.

This cut attacks the remaining fact-level sufficient-explanation principle EF4.
Its purpose is to determine exactly what the totality argument needs, and what
is really asserted by rejecting sufficient explanation for the totality fact.

It does not define God, does not assume well-foundedness A2 or unity A3, and
does not reintroduce primitive externality, global anti-self-explanation, or
any positive divine attribute.

## 1. First reduction: global EF4 is too strong

The earlier principle was:

```text
EF4
for every fact p,
ActualFact(p) and not NecessaryFact(p)
-> ExplainedFact(p).
```

The totality argument uses EF4 at exactly one fact: the designated fact that the
represented totality obtains.

Define the local principle:

```text
LocalFactSufficientExplanation(totality)

not NecessaryFact(totality)
-> ExplainedFact(totality).
```

A model is required in which:

```text
the totality fact satisfies local EF4;
an unrelated actual non-necessary fact has no explanation;
global EF4 therefore fails;
the necessary-reality theorem still holds.
```

Thus no theorem in this cut may require global fact-level sufficient
explanation merely because one designated totality fact is under discussion.

## 2. Explanatory absolute

Introduce a purely structural notion:

```text
ExplanatorilyAbsoluteFact(p)
:= ActualFact(p) and not ExplainedFact(p)
```

and its contingent form:

```text
ContingentExplanatoryAbsoluteFact(p)
:= ActualFact(p)
   and not NecessaryFact(p)
   and not ExplainedFact(p).
```

The word `absolute` here is deliberately relation-relative. It means only that
no explanatory source lies beyond the fact in the chosen explanation relation.
It does **not** mean that the fact exists necessarily.

This distinction is non-negotiable:

```text
explanatory ultimacy != modal necessity
```

## 3. Rejection of local EF4

For an actual fact, Lean must prove:

```text
not LocalFactSufficientExplanation(p)
iff
ContingentExplanatoryAbsoluteFact(p).
```

For the actual totality fact this becomes:

```text
Local EF4
iff
not ContingentExplanatoryAbsoluteFact(totality).
```

Hence rejecting local EF4 does not remove explanatory ultimacy. It accepts the
totality fact itself as an actual, non-necessary, unexplained ultimate fact.

This is the precise formal content of the claim that replacing an absolute by
a brute contingent totality does not eliminate an absolute *explanatory role*;
it changes only the modal status of the bearer of that role.

## 4. EF4-free explanation core

Separate all consequences that follow once an explainer exists from the claim
that an explainer must exist.

`TotalityExplanationCore` contains only:

```text
ES   a source that explains the actual totality fact is actual
LA   the totality explanation adequately explains each actual member in scope
C    every actual non-necessary entity is inside the represented totality
```

It contains no existence-of-explanation premise.

Under this core, Lean proves:

```text
if a explains the totality fact,
then a is necessary.
```

This theorem contains no EF4.

## 5. Main EF4-free trichotomy

From `TotalityExplanationCore` alone, Lean must prove:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and a explains the totality fact
OR
ContingentExplanatoryAbsoluteFact(totality).
```

This is the main result of the cut.

It exposes the option previously hidden by EF4 instead of excluding it by
premise.

## 6. Pure contingency theorem

Assume:

```text
the totality fact is non-necessary;
every actual entity is non-necessary.
```

Under the EF4-free explanation core, Lean must prove:

```text
ContingentExplanatoryAbsoluteFact(totality).
```

Therefore a purely contingent ontology can survive only by placing explanatory
ultimacy in an unexplained contingent totality fact.

This theorem does **not** prove that the contingent absolute is necessary. Doing
so would simply reintroduce a sufficient-ground principle in another form.

## 7. Exact philosophical fork

After this cut, the dispute is no longer accurately described as:

```text
necessary absolute
versus
no absolute, only contingency
```

The formal fork is:

```text
A  necessary reality exists

or

B  the actual totality of contingent reality is itself a contingent
   explanatory absolute: it could have failed to obtain, yet nothing explains
   why it obtains.
```

LOGOS does not decide between A and B by logic alone.

The remaining human judgment is whether B is an acceptable stopping point.

## 8. Required models

### Global-EF4 surplus model

Must show:

```text
local totality EF4 holds;
global EF4 fails on an unrelated fact;
necessary reality still follows.
```

### Brute-totality model

Must show:

```text
genuine infinite contingent entity regress;
actual non-necessary totality fact;
no explanatory source for that fact;
all actual entities non-necessary;
local EF4 fails;
the totality fact is a contingent explanatory absolute.
```

This model is not a bug. It is the exact surviving opponent position.

## 9. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `TotalityExplanationCore` contains no EF4 premise;
4. global EF4 is formally shown stronger than local totality EF4;
5. rejecting local EF4 is equivalent to accepting a contingent explanatory absolute for the actual totality fact;
6. the EF4-free trichotomy elaborates;
7. pure contingency is proved to force a contingent explanatory absolute;
8. the brute-totality model elaborates;
9. the axiom audit exposes all load-bearing theorems and models;
10. no theorem identifies explanatory ultimacy with modal necessity by definition;
11. no theological interpretation enters the proof core.

## 10. Remaining attack surface

If this cut closes, EF4 is no longer a hidden premise of the main analysis.
The remaining question is explicit:

> Can an actual fact that could have failed to obtain nevertheless be the final
> unexplained explanatory stopping point for all contingent reality?

Answering `yes` preserves pure contingency by accepting a contingent
explanatory absolute.

Answering `no` is exactly local sufficient explanation for the totality fact,
and the existing adequacy argument then forces necessary reality.
