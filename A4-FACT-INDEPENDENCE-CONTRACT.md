# A4-FACT-INDEPENDENCE-1 DESIGN CONTRACT

Status: **ACCEPTED CUT CONTRACT - ON MAIN**.

Base: `main` after the route-seam closure, the attack-note revision, and the carrier and modality amendments of the claim-correction PR.

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

A feasibility spike confirmed both directions of section 5 before this contract was frozen. No statement below rests on that spike alone; each is an acceptance test in section 10.

## 1. Motivation

The revised `A2-A3-A4-ATTACK.md` separates two object positions. The original discussion grouped them under the broad heading of brute contingency. Formal A4 itself governs only the entity position; it quantifies over entities and never mentioned facts.

```text
brute contingent entity   an actual, non-necessary, underived entity
brute contingent fact     the totality fact is actual, non-necessary and unexplained
```

The note reads these as two positions rather than as variants of one thesis. Formally that reading has a precise and much narrower content, and only that content is pinned here: under the shared hypothesis schema of section 4, neither of the two principles below entails the other.

Nothing about arguments is pinned. A countermodel bears on entailment. Whether a particular argument against one position happens to reach the other depends on that argument's own premises, which no model can settle.

The two positions are excluded by two different principles already on `main`:

```text
NonNecessaryIsDerived M                    A4', entity level
LocalFactSufficientExplanation G R.totality local EF4, fact level
```

Nothing so far shows these are two commitments rather than one.

## 2. Claim type

```text
countermodel   FactBruteEntityRegular   (the accepted BruteTotality model, read for A4 and A4')
countermodel   EntityBruteFactRegular   (new)
proved theorem a4_and_localEF4_are_independent
```

No new language, no new axiom record, no new `ScopeCarrier`, no new bridge assumption, and no interpretation of `Explains` for a fresh carrier.

Two qualifications, so the line is not read more widely than it holds. Each model declares its own inductive entity and fact types; those are model data, not language. And the second model satisfies the existing fact-level bridge `ExplanationImpliesGrounding` rather than dispensing with it, which is a property of the model and not an assumption added to the core.

## 3. Language

None introduced. The cut is stated entirely in vocabulary already on `main`: `RegressTotality`, `TotalityExplanationCore`, `NonNecessaryIsDerived`, `LocalFactSufficientExplanation`, `Derived`, `Necessary`, `NecessaryFact`.

A static CI guard enforces that the cut's model source file, `Logos/Models/Grounding/A4FactIndependence.lean`, declares no `structure`, `class` or `axiom`, so it cannot introduce a record or a commitment. That file is where a record could enter; the cut also touches an audit file, the workflow and this contract, and the guard says nothing about those. Local inductive carriers for a model are permitted; they are model data, not language. The entity carrier of the second model is not finite: `node : Nat → Entity` supplies the required infinite descending chain.

## 4. Assumptions

None added. The two directions are two different models. What they share is the same fixed hypothesis schema, fixed in advance:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
¬ NecessaryFact F R.totality
```

Both models satisfy all three. The independence is therefore stated under the accepted hypotheses, not by changing them.

## 5. Results

### 5.1 Entity level regular, fact level brute

The accepted `BruteTotality` model already on `main` is reused unchanged. In it every entity is a regress node and every node has a deeper node grounding it, so:

```text
NonNecessaryIsDerived IM                              holds
∀ x, Actual → Contingent → Derived                    holds (the original A4)
¬ NecessaryFact IFM IR.totality                       holds
¬ LocalFactSufficientExplanation BG IR.totality       holds
TotalityExplanationCore                               inhabited by bruteCore
```

The original A4 is derived from A4' through the accepted equivalence; the actual world of this model accesses itself, so that equivalence applies. Both forms therefore hold while the fact-level principle fails. No new model is needed for this direction, only the A4 reading of the existing one.

### 5.2 Fact level regular, entity level brute

`EntityBruteFactRegular` adds one entity `stray` to an otherwise well-behaved model: actual, non-necessary, grounded by nothing, inside the represented totality and adequately explained by the same source that explains the totality fact.

```text
LocalFactSufficientExplanation G R.totality            holds, non-vacuously
¬ NecessaryFact F R.totality                           holds, so the antecedent is met
ActualExplainsFact G root R.totality                   holds, so the consequent is met
¬ NonNecessaryIsDerived M                              holds, witnessed at stray
¬ (∀ x, Actual → Contingent → Derived)                 holds, same witness
ExplanationImpliesGrounding G                          holds
TotalityExplanationCore                                inhabited by explanationCore
```

Non-vacuity is stated as two separate facts rather than asserted, so the direction cannot be satisfied by a model in which the principle holds only because its antecedent fails.

`stray` is contingent in the original sense and not merely non-necessary, so the original A4 fails at the same witness.

The fact-level bridge `ExplanationImpliesGrounding` is deliberately made to hold: `root` is admitted as a generic fact ground as well as an explanatory source. The direction therefore does not turn on the absence of that bridge.

### 5.3 The joint statement

```text
a4_and_localEF4_are_independent
    (TotalityExplanationCore ... ∧ NonNecessaryIsDerived ...
       ∧ ¬ NecessaryFact ... ∧ ¬ LocalFactSufficientExplanation ...)
  ∧ (TotalityExplanationCore ... ∧ LocalFactSufficientExplanation ...
       ∧ ¬ NecessaryFact ... ∧ ¬ NonNecessaryIsDerived ...)
```

Both directions in one theorem, both under the shared hypothesis schema, and each stated for the original A4 as well as A4'.

### 5.4 The load-bearing gap in the second direction

The second direction relies on the current language having no entity-level bridge from adequate explanation to ontological grounding. `root` adequately explains `stray` and does not ground it, which is exactly why `TotalityExplanationCore` can hold while A4 and A4' fail. `root_explains_stray_without_grounding` states that gap directly in its type, with adequacy rather than raw explanation on the left, so the statement cannot be satisfied by an explanation that would already be improper.

No independence result under such a future bridge is claimed. If an entity-level bridge from adequate explanation to grounding were added, this direction would have to be re-examined.

## 6. What this establishes

A4' and local EF4 are two commitments, not one. Inside `RegressTotality` plus `TotalityExplanationCore` with a non-necessary totality fact, either can hold while the other fails.

What is proved is exactly two non-entailments, under the shared hypothesis schema:

```text
A4 and A4' do not entail local EF4        witnessed by FactBruteEntityRegular
local EF4 does not entail A4 or A4'       witnessed by EntityBruteFactRegular
```

Nothing broader. The attack note's reading that the two positions are not variants of one thesis is supported by these two non-entailments; it is not itself a formal statement.

This also fixes the scope of `absolute-ground-1`. Its A4 governs the entity level only, and the fact-level position it leaves open is exactly the third disjunct of the accepted trichotomy.

## 7. What this does not establish

It does not establish either principle. Both remain live commitments. Local EF4 is listed in `STATUS.md`; A4' is stated in `absolute-ground-1` and discussed in the attack note, and the closure for this cut added it to the `STATUS.md` list.

It does not establish that the two are the only relevant principles, or that together they exhaust brute positions.

It says nothing about carrier extension. That is a manoeuvre about where explanatory sources may be drawn from, not an object position, and it is deliberately outside this cut.

The precise situation is this. `ScopeCarrier` alone has an uninterpreted `Explains` predicate. `entityScopeCarrier` interprets it as `ActualExplainsFact`, but no such interpretation is supplied for an arbitrary fresh carrier, and there is no bridge to `licensesFailure`. Treating carrier extension as a third independent axis was considered and dropped on that ground: `ConditionedBrute` already carries a contingent unexplained totality fact and a licensing modal condition at the same time, so the two layers do not substitute for each other and there is nothing for an independence result to separate.

The candidate constructions that were examined all amounted to placing unrelated structures side by side, which is syntactic freedom rather than philosophical independence. No claim is made that every possible construction must take that shape. The axis was dropped for want of a candidate that passes the new-axis test, not refuted.

It does not weaken anything accepted. No premise, record or theorem changes.

## 8. Boundary

```text
NO new axiom record, structure, class or axiom; enforced by static CI guard
NO new ontological language
NO new ScopeCarrier or cross-carrier bridge
NO modification of any accepted theorem, record or model
NO claim that either principle is true
NO claim that the two principles exhaust the brute positions
NO claim about carrier extension in either direction
NO change of the shared hypothesis schema to obtain independence
NO independence claim under a future entity-level explanation-to-grounding bridge
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
3. `NonNecessaryIsDerived` and the original A4 are both proved for the accepted `BruteTotality` model;
4. that same model is confirmed to have a non-necessary totality fact and to fail local EF4;
5. `EntityBruteFactRegular` inhabits `TotalityExplanationCore`;
6. in it local EF4 holds, and non-vacuity is exhibited as two separate facts;
7. in it an actual underived entity is exhibited that is both non-necessary and contingent, refuting `NonNecessaryIsDerived` and the original A4;
7a. in it `ExplanationImpliesGrounding` holds, so the direction does not turn on the absence of the fact-level bridge;
7b. `root_explains_stray_without_grounding` states the entity-level gap the direction does rely on, with `AdequateExplainsEntity` in its type and not merely `ActualExplainsEntity`;
8. `a4_and_localEF4_are_independent` states both directions under the shared hypothesis schema, for both A4 and A4';
9. the cut's model source file declares no `structure`, `class` or `axiom`, enforced by static CI guard;
10. dedicated axiom audit is green;
11. no new premise enters any accepted axiom record;
12. no theological interpretation enters the proof core.
