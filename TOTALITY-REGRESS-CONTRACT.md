# DESIGN CONTRACT — TOTALITY-REGRESS-1

Status: **ACCEPTED CUT CONTRACT — ON MAIN**.

This accepted cut builds on the general grounding language now present on `main`. Its purpose is to test whether the well-foundedness commitment A2 is needed merely to establish *necessary reality*, once an infinite regress is treated as an explicit totality.

It does not use limits, integrals, a point at infinity, or a last member of the regress.

## 1. Target

The target is deliberately weaker than `AbsoluteGround`:

> If a regress is proposed as the totality of contingent reality, pure contingency cannot survive: either the totality fact is necessary, or some actual necessary entity grounds that fact from outside the regress.

Formally:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and a grounds the totality fact
  and a is outside the represented regress.
```

No A2/well-foundedness premise occurs in this theorem.

This cut does **not** prove that the necessary witness is ungrounded. It therefore does not by itself replace the stronger `AbsoluteGround` theorem. It attacks the narrower claim that reality could be contingent all the way down and as a whole.

## 2. Fact firewall

The regress totality is not silently reified as an entity.

```lean
structure FactModel (M : Grounding.Model) where
  Fact : Type
  holdsAt : World -> Fact -> Prop
  groundsFact : World -> Entity -> Fact -> Prop
```

Entity grounding and fact grounding remain distinct relations.

Introducing a totality fact is therefore an explicit semantic commitment open to independent criticism.

## 3. Regress totality

`RegressTotality M F` contains:

```text
node : Nat -> Entity
step : node(n+1) grounds node(n)
totality : Fact
actual_totality : the totality fact actually holds
inside : Entity -> Prop
node_inside : every regress node is inside
```

The infinite chain is genuine. No terminal element is postulated.

## 4. Three load-bearing totality commitments

### F4 — fact-level sufficient ground

```text
ActualFact(p) and not NecessaryFact(p)
-> DerivedFact(p)
```

An actual fact that is not necessary has an entity-ground.

This is the fact analogue of entity-level A4'. It is not obtained for free merely by introducing a `Fact` carrier.

### E — externality

```text
if a grounds the totality fact,
then a is not inside that regress.
```

This is the explicit anti-circularity bridge. It prevents the proposed contingent totality from grounding its own totality fact through one of its members.

### C — completeness

```text
every actual non-necessary entity is inside the represented totality.
```

The intended strong reading is therefore not "one infinite regress exists", but "this represents the totality of contingent reality".

Without C, an external ground may merely be another contingent item outside the chosen regress.

## 5. Main derivation

Assume F4, E, and C.

If the totality fact is necessary, necessary reality already exists at the fact level.

If it is not necessary, F4 yields an actual entity grounding that fact. E places that entity outside the represented totality.

If that external entity were itself non-necessary, C would place it inside the totality, contradicting E.

Therefore the external ground is necessary.

Hence:

```text
contingent_totality_forces_necessary_reality
```

and the corollary:

```text
no_pure_contingent_reality
```

Neither theorem assumes A2 or A3. `Logos/CoreBoundaryAudit.lean` now machine-pins this premise boundary.

## 6. Positive model

The accepted cut contains a concrete model with:

```text
an actual infinite regress of contingent entities;
a contingent regress-totality fact;
a necessary entity outside the regress;
that entity grounds the totality fact.
```

The right branch of the main dichotomy is therefore inhabited.

## 7. Independence models

The replacement of A2 is not free. Each new bridge is exposed by a countermodel.

### Without E — internal grounding

A regress member grounds the regress-totality fact. F4 can hold while both every actual entity and the totality fact remain non-necessary. Pure contingency therefore survives without externality.

### Without C — incomplete totality

The totality fact has an external ground, but that external ground is itself non-necessary and lies outside the chosen regress. F4 and E hold; pure contingency still survives.

### Without F4 — brute totality fact

The totality fact is actual and non-necessary but has no ground. C and E can hold while pure contingency survives.

## 8. What has and has not happened to A2

`TOTALITY-REGRESS-1` establishes:

```text
A2 is not needed to refute PURE CONTINGENCY
provided F4 + E + C are accepted.
```

It does not establish:

```text
A2 is unnecessary for proving an UNGROUNDED necessary entity.
```

The accepted comparison is therefore:

```text
FOUNDATION ROUTE
  A2 + entity A4'
  -> necessary ungrounded entity

TOTALITY ROUTE
  fact F4 + externality E + completeness C
  -> necessary reality (fact or entity)
```

Which premise package is metaphysically preferable remains an open philosophical question, not a Lean result.

## 9. Interpretation boundary

This cut introduces no `God` predicate and no positive divine attribute.

Its only target is the modal status of reality:

> Can everything actual, including the totality of a proposed infinite regress, be non-necessary?

Under F4 + E + C, Lean verifies that the answer is no.

## 10. Acceptance record

The cut was promoted only after:

1. the project built under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurred;
3. the totality fact remained on a separate fact carrier;
4. the main theorem contained no A2/well-foundedness or A3/unity assumption;
5. the positive infinite-regress model elaborated;
6. the no-externality countermodel elaborated;
7. the no-completeness countermodel elaborated;
8. the no-fact-A4' countermodel elaborated;
9. the central axiom audit covered the load-bearing theorems and models;
10. the dedicated core-boundary audit pinned the exact theorem signature; and
11. no interpretation bridge was imported into the proof core.
