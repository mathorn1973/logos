# DESIGN CONTRACT — CONTINGENT-ABSOLUTE-1

Status: **ACCEPTED CUT CONTRACT - ON MAIN**.

This cut attacks the residual `ContingentExplanatoryAbsoluteFact` option left by `FACT-SUFFICIENT-EXPLANATION-1`.

Its purpose is not to assume that explanatory ultimacy and modal necessity are the same. It tests that identification formally and isolates the exact bridge required to make it.

## 1. Two notions of absolute

The language now keeps separate:

```text
ExplanatorilyAbsoluteFact
  actual and unexplained

ModallyAbsoluteFact
  actual and necessary
```

No definition identifies them.

A contingent explanatory absolute is:

```text
actual
non-necessary
unexplained
```

## 2. Brute modal asymmetry

Define:

```text
BruteModalAsymmetryFact(p)
```

to mean:

```text
p holds actually;
p fails at some world accessible from the actual world;
p has no actual explanatory source.
```

Lean proves:

```text
ContingentExplanatoryAbsoluteFact(p)
IFF
BruteModalAsymmetryFact(p)
```

using ordinary classical reasoning for `not box p -> diamond not p`.

Therefore the residual brute-fact position has an exact modal reading:

> actuality selects p over an accessible alternative in which p fails, and no explanatory source accounts for that difference.

## 3. Pure contingency theorem

Under the existing EF4-free totality-explanation core, if:

```text
the totality fact is non-necessary;
every actual entity is non-necessary;
```

then Lean proves:

```text
BruteModalAsymmetryFact(totality)
```

Pure contingency therefore does not merely produce an unexplained fact. It produces an unexplained actual modal asymmetry at the totality level.

## 4. The critical equivalence

Define the local bridge:

```text
UltimateModalStabilityAt(p) :=
  ExplanatorilyAbsoluteFact(p) -> NecessaryFact(p)
```

For any actual fact, Lean proves:

```text
UltimateModalStabilityAt(p)
IFF
LocalFactSufficientExplanation(p)
```

At the designated totality fact this becomes:

```text
explanatory ultimacy -> necessity
IFF
local EF4
```

This is the central result of the cut.

It means that the proposed claim

> "an explanatorily absolute fact must be necessary"

is not an independent route around EF4 in the current semantics. It is exactly the same commitment in modal-stability form.

Any future argument that derives necessity from explanatory ultimacy must therefore add genuinely new semantic or metaphysical structure rather than merely rename local EF4.

## 5. Independence models

The cut contains both directions of independence.

### Explanatory absolute without modal necessity

The existing brute-totality model has:

```text
actual totality fact
no explainer
not necessary
```

Hence:

```text
ExplanatorilyAbsoluteFact
and
not NecessaryFact
```

So explanatory ultimacy alone does not imply necessity.

### Modal necessity without explanatory absoluteness

A separate stable-fact model has a fact that holds throughout the accessible worlds but is explicitly explained by an actual entity.

Hence:

```text
ModallyAbsoluteFact
and
not ExplanatorilyAbsoluteFact
```

The two notions are therefore independent in the current semantics.

## 6. What this cut proves

It proves:

```text
contingent explanatory absolute = brute unexplained modal asymmetry;
pure contingency forces such an asymmetry at the totality level;
explanatory ultimacy -> necessity is equivalent to local EF4;
explanatory and modal absoluteness are semantically independent without a bridge.
```

## 7. What this cut does not prove

It does not prove:

```text
explanatory ultimacy entails necessity;
contingent explanatory absolutes are contradictory;
accessible alternatives are metaphysically possible in any interpretation-independent sense;
brute modal asymmetry is impossible by pure logic;
a necessary fact is unexplained;
a necessary explainer is ungrounded;
a necessary explainer is God.
```

## 8. Remaining attack surface

The live question is now narrower than EF4 itself:

> Can an actual unexplained fact be modally variant — true here, false at an accessible alternative — with no explanation of why actuality selects this side of the contrast?

Calling such variation impossible is equivalent, at the designated actual fact, to reintroducing local EF4 unless additional independent structure is supplied.

The next cut should therefore attack **brute modal asymmetry** directly rather than restate explanatory ultimacy as necessity.

## 9. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `ContingentExplanatoryAbsoluteFact` is proved equivalent to `BruteModalAsymmetryFact`;
4. pure contingency is proved to force brute modal asymmetry at the totality fact;
5. `UltimateModalStabilityAt` is proved equivalent to local EF4 for actual facts;
6. the totality-specific equivalence elaborates;
7. the brute-totality countermodel refutes ultimacy-implies-necessity;
8. the necessary-explained model refutes necessity-implies-explanatory-absoluteness;
9. the dedicated axiom audit is green;
10. no theological interpretation enters the proof core.
