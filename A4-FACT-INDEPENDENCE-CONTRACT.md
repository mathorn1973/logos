# A4-FACT-INDEPENDENCE-1 DESIGN CONTRACT

Status: **RESEARCH CUT, IN REVIEW**.

Base: `main` after the route-seam closure and the attack-note revision.

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

A feasibility spike confirmed both directions of section 5 before this contract was frozen. No statement below rests on that spike alone; each is an acceptance test in section 10.

## 1. Motivation

The revised `A2-A3-A4-ATTACK.md` separates two object positions that A4 as written treats as one:

```text
brute contingent entity   an actual, non-necessary, underived entity
brute contingent fact     the totality fact is actual, non-necessary and unexplained
```

The note asserts that an argument against the first does not transfer to the second. That assertion is currently prose. This cut pins it.

The two positions are excluded by two different principles already on `main`:

```text
NonNecessaryIsDerived M                    A4', entity level
LocalFactSufficientExplanation G R.totality local EF4, fact level
```

Nothing so far shows these are two commitments rather than one.

## 2. Claim type

```text
countermodel   FactBruteEntityRegular   (the accepted BruteTotality model, read for A4')
countermodel   EntityBruteFactRegular   (new)
proved theorem a4_and_localEF4_are_independent
```

No new language, no new axiom record, no new carrier, no bridge, no interpretation.

## 3. Language

None introduced. The cut is stated entirely in vocabulary already on `main`: `RegressTotality`, `TotalityExplanationCore`, `NonNecessaryIsDerived`, `LocalFactSufficientExplanation`, `Derived`, `Necessary`, `NecessaryFact`.

A static CI guard enforces that the cut's only source file declares no `structure`, `class` or `axiom`, so it cannot introduce a record or a commitment. Inductive carriers for a finite model are permitted; they are model data, not language.

## 4. Assumptions

None added. Both directions are models, and the shared environment is fixed in advance:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
¬ NecessaryFact F R.totality
```

Every model below satisfies all three. The independence is therefore stated inside the accepted environment, not by varying it.

## 5. Results

### 5.1 Entity level regular, fact level brute

The accepted `BruteTotality` model already on `main` is reused unchanged. In it every entity is a regress node and every node has a deeper node grounding it, so:

```text
NonNecessaryIsDerived IM                              holds
¬ NecessaryFact IFM IR.totality                       holds
¬ LocalFactSufficientExplanation BG IR.totality       holds
TotalityExplanationCore                               inhabited by bruteCore
```

A4' can therefore hold while the fact-level principle fails. No new model is needed for this direction; only the A4' reading of the existing one.

### 5.2 Fact level regular, entity level brute

`EntityBruteFactRegular` adds one entity `stray` to an otherwise well-behaved model: actual, non-necessary, grounded by nothing, inside the represented totality and adequately explained by the same source that explains the totality fact.

```text
LocalFactSufficientExplanation G R.totality            holds, non-vacuously
¬ NecessaryFact F R.totality                           holds, so the antecedent is met
ActualExplainsFact G root R.totality                   holds, so the consequent is met
¬ NonNecessaryIsDerived M                              holds, witnessed at stray
TotalityExplanationCore                                inhabited by explanationCore
```

Non-vacuity is stated as two separate facts rather than asserted, so the direction cannot be satisfied by a model in which the principle holds only because its antecedent fails.

### 5.3 The joint statement

```text
a4_and_localEF4_are_independent
    (TotalityExplanationCore ... ∧ NonNecessaryIsDerived ...
       ∧ ¬ NecessaryFact ... ∧ ¬ LocalFactSufficientExplanation ...)
  ∧ (TotalityExplanationCore ... ∧ LocalFactSufficientExplanation ...
       ∧ ¬ NecessaryFact ... ∧ ¬ NonNecessaryIsDerived ...)
```

Both directions in one theorem, both inside the shared environment.

## 6. What this establishes

A4' and local EF4 are two commitments, not one. Inside `RegressTotality` plus `TotalityExplanationCore` with a non-necessary totality fact, either can hold while the other fails.

Consequently an argument that excludes brute contingent entities does not thereby exclude a brute contingent totality fact, and an argument that excludes the brute fact does not thereby exclude brute entities. The attack note's claim that the two positions are not variants of one thesis is now a theorem rather than a reading.

This also fixes the scope of `absolute-ground-1`. Its A4 governs the entity level only, and the fact-level position it leaves open is exactly the third disjunct of the accepted trichotomy.

## 7. What this does not establish

It does not establish either principle. Both remain live commitments recorded in `STATUS.md`.

It does not establish that the two are the only relevant principles, or that together they exhaust brute positions.

It says nothing about carrier extension. That is a manoeuvre about where explanatory sources may be drawn from, not an object position, and it is deliberately outside this cut. `ScopeCarrier` records that an item explains the designated target and does not record that the item is itself unexplained; it has no bridge to `ActualExplainsFact`. Treating carrier extension as a third independent axis was considered and rejected: `ConditionedBrute` already carries a contingent unexplained totality fact and a licensing modal condition at the same time, so the two layers do not substitute for each other, and bidirectional models could be produced only by taking a product of unrelated structures. That is syntactic freedom, not philosophical independence.

It does not weaken anything accepted. No premise, record or theorem changes.

## 8. Boundary

```text
NO new axiom record, structure, class or axiom; enforced by static CI guard
NO new ontological language and NO new carrier
NO modification of any accepted theorem, record or model
NO claim that either principle is true
NO claim that the two principles exhaust the brute positions
NO claim about carrier extension in either direction
NO variation of the shared environment to obtain independence
NO theological or physical predicate
```

## 9. Remaining philosophical boundary

The question this sharpens is not new, but it is now correctly divided:

> Is a contingent underived entity a genuine stopping point?

and, separately,

> Can an actual fact that could have failed to obtain be the final unexplained stopping point for all contingent reality?

Both are live. Answering the first leaves the second open, and the formal layer now says so rather than leaving it to a reader.

## 10. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `NonNecessaryIsDerived` is proved for the accepted `BruteTotality` model;
4. that same model is confirmed to have a non-necessary totality fact and to fail local EF4;
5. `EntityBruteFactRegular` inhabits `TotalityExplanationCore`;
6. in it local EF4 holds, and non-vacuity is exhibited as two separate facts;
7. in it an actual non-necessary underived entity is exhibited, refuting `NonNecessaryIsDerived`;
8. `a4_and_localEF4_are_independent` states both directions inside the shared environment;
9. the cut's source file declares no `structure`, `class` or `axiom`, enforced by static CI guard;
10. dedicated axiom audit is green;
11. no new premise enters any accepted axiom record;
12. no theological interpretation enters the proof core.
