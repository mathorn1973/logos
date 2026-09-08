# TOTALITY-CONSTITUTION-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - NOT ON MAIN**.

Base: `main` at `25c797b`, after the `truth-fact-seam-1` closure.

Local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

This contract is written before any Lean for this cut exists. The design was settled by
reading the accepted definitions on `main` (`FactModel`, `RegressTotality`,
`TotalityExplanationCore`, the trichotomy theorem, `NecessaryExistenceAxioms` and the
accepted independence models) and by rebuilding `main` from the pinned toolchain. Nothing
of this cut has been run. A target in section 5 may therefore fail, and if one does, the
failure is recorded here and in the pull request as a result. Section 6 says in advance
what each outcome would mean.

## 1. Motivation

`route-seam-1` recorded that `RegressTotality` is weak: its designated fact `totality`
and its predicate `inside` are free data, and `bare_totality_necessary` showed the
totality conclusion can hold by its first disjunct with no explanatory premise doing any
work. That was a deflation of the record. It was not followed by the obvious repair.

The repair is to say what the totality fact **is**. On `main` there is no law relating
`holdsAt w R.totality` to the existence of the members `R.inside`. So the fact called
"the totality of contingent reality" has, formally, nothing to do with contingent reality.
A necessary totality fact over wholly contingent members is admissible.

Once the totality fact is constituted by its members, the first disjunct of the accepted
trichotomy stops being a free option. Under completeness `C` it becomes the claim that
every actual entity is necessary. That is necessitarianism about the actual world, and it
is the denial of the presupposition of the programme's question. The premise that removes
it is the presupposition made explicit:

```text
W   something actual is not necessary
```

`W` is not in any accepted premise package. On the foundation side the same absence has a
different shape: nothing in `NecessaryExistenceAxioms` constrains the frame beyond `A5`,
so on a frame where the actual world accesses only itself, `Necessary` coincides with
`Actual`, `A4` is vacuous, and `exists_necessary_ungrounded` says exactly what
`exists_ungrounded` already said from `A0` to `A2`. The accepted independence model
`twoRootModel` lives on such a frame. `W` is precisely what rules that reading out.

So the cut has one question:

> When the totality fact is constituted by its members, what is the first disjunct of
> the trichotomy, and what does each route need `W` for?

## 2. Claim type

```text
formal definition   ConstitutedTotality, TotalityRequiresMembers, ContingencyWitness,
                    constitutedFacts
proved theorem      5.1, 5.2, 5.3, 5.4, 5.6, 5.7
countermodel        5.5 (four models), 5.8 (reuse of an accepted model)
interpretation      section 7 only
```

`ConstitutedTotality` is a **constitution law**. It is a premise about what the fact
carrier records, stated as a `Prop` over the existing `FactModel` and `RegressTotality`,
and it is confined to this cut. No result outside the cut may depend on it.

`ContingencyWitness` is a **premise**. It is the presupposition of the question, stated
as a `Prop`. It is not established, and section 7 says what denying it amounts to.

## 3. Language

Inherited: `Model`, `FactModel`, `RegressTotality`, `FactGroundingRoles`,
`EntityExplanationModel`, `TotalityExplanationCore`, `NecessaryExistenceAxioms`, and the
predicates `Actual`, `Necessary`, `Contingent`, `NecessaryFact`,
`ContingentExplanatoryAbsoluteFact`, `LocalFactSufficientExplanation`.

New definitions, all in one ontology module:

```text
ConstitutedTotality F R :=
    forall w, F.holdsAt w R.totality <-> (forall x, R.inside x -> M.existsAt w x)

TotalityRequiresMembers F R :=
    forall w, F.holdsAt w R.totality -> forall x, R.inside x -> M.existsAt w x

ContingencyWitness M :=
    exists x, Actual M x /\ not Necessary M x

constitutedFacts M inside groundsFact : FactModel M
    Fact       := PUnit
    holdsAt w  := forall x, inside x -> M.existsAt w x
    groundsFact := groundsFact            (parameter, left free)
```

Three deliberate choices.

**Membership is rigid.** `R.inside` does not vary with the world, so the constituted
totality at a non-actual world is the fact that *these* members exist there, not the fact
that whatever is contingent there exists. This is the de re reading of "the totality of
contingent reality". A world-relative reading is a different law and is not attempted.

**The law fixes `holdsAt` only.** `groundsFact`, `constitutesFact` and `explainsFact`
stay free. The cut says what it is for the totality to obtain; it says nothing about what
grounds or explains it. Any result that seemed to need a law on grounding would be a
different cut.

**`W` is stated with `not Necessary`, not with `Contingent`.** The totality packages use
`Actual` and `not Necessary` throughout and carry no `A5`. Under `A5` the two readings
agree, and 5.7 states that.

## 4. Assumptions

`ConstitutedTotality` and `ContingencyWitness` as above. Everything else is used as
already defined on `main`. No new `structure`, `class` or `axiom` anywhere in the cut.

## 5. Targets

### 5.1 The law forces membership into the actual world

```text
ConstitutedTotality F R  ->  forall x, R.inside x -> Actual M x
```

from `R.actual_totality`. Predicted to hold and to need only the forward half of the law.
Together with `C` this sandwiches `inside` between the actual non-necessary entities and
the actual entities. Recorded because it is a constraint the law imposes on `inside`
that the free record did not.

### 5.2 The first disjunct is member-necessity

```text
ConstitutedTotality F R  ->
    (NecessaryFact F R.totality  <->  forall x, R.inside x -> Necessary M x)
```

Predicted to hold without axioms. The one-directional form, using only
`TotalityRequiresMembers`:

```text
R.inside x -> not Necessary M x -> not NecessaryFact F R.totality
```

### 5.3 Under completeness, the first disjunct is necessitarianism

```text
ConstitutedTotality F R  ->  (forall x, Actual M x -> not Necessary M x -> R.inside x)  ->
    (NecessaryFact F R.totality  <->  not ContingencyWitness M)
```

Predicted to hold. The direction `NecessaryFact -> not W` should need no axioms. The
direction `not W -> NecessaryFact` is expected to need classical logic, since it passes
from `not not Necessary` to `Necessary`; that use is recorded, not hidden.

### 5.4 The dichotomy

```text
TotalityExplanationCore M F G E R  ->  TotalityRequiresMembers F R  ->
ContingencyWitness M  ->
    (exists a, Actual M a /\ Necessary M a /\ ActualExplainsFact G a R.totality)
    \/ ContingentExplanatoryAbsoluteFact G R.totality
```

Predicted to hold, by the accepted trichotomy with its first disjunct refuted through 5.2.
And with local sufficient explanation added:

```text
... -> LocalFactSufficientExplanation G R.totality ->
    exists a, Actual M a /\ Necessary M a /\ ActualExplainsFact G a R.totality
```

### 5.5 Independence, four models

Each model is exhibited concretely. The first three use `constitutedFacts`, so the law
holds there by construction rather than by stipulation.

```text
Necessitarian      law /\ core /\ not W       first disjunct holds
                   every member exists at every world; no explainer
BareWitness        W /\ core /\ not law       first disjunct still holds
                   totality obtains at a world where a member does not exist
NecessaryExplainer law /\ core /\ W           middle disjunct inhabited
ContingentAbsolute law /\ core /\ W           third disjunct inhabited
```

`Necessitarian` shows the law and the core do not entail `W`. `BareWitness` shows `W`
and the core do not remove the first disjunct without the law, so the law is load-bearing
in 5.4. The last two show that 5.4 is not further reducible without local sufficient
explanation. `Necessitarian` must use a frame with more than one accessible world, so
that `W` fails for a substantive reason and not because the frame is degenerate.

### 5.6 The foundation route on a degenerate frame

For a model whose actual world accesses only itself and satisfies `A5`:

```text
Necessary M x  <->  Actual M x
not Contingent M x
FoundationAxioms M  ->  NecessaryExistenceAxioms M           (A4 is vacuous)
(exists a, Ungrounded M a /\ Necessary M a)  <->  exists a, Ungrounded M a
```

Predicted to hold without axioms. This is the record that the modal content of the
central theorem is supplied by the frame and by nothing in the premise package.

### 5.7 `W` and the frame

```text
ContingencyWitness M  ->  exists w, M.frame.access M.actual w /\ w <> M.actual
A5  ->  (ContingencyWitness M  <->  exists x, Actual M x /\ Contingent M x)
```

Predicted to hold; the first without axioms, the second direction from `W` to
`Contingent` expected to need classical logic.

### 5.8 An accepted model is degenerate

`twoRootModel` from `Logos.Models.Grounding.Independence` satisfies the hypothesis of
5.6, so its two necessary ungrounded roots are necessary in the degenerate sense.
Predicted to hold. This does not weaken what that model was accepted for, which is the
independence of `A3`; it records what its `Necessary` means.

## 6. What each outcome would mean, stated in advance

```text
all of 5.1 to 5.8 hold     the first disjunct of the trichotomy is, under the
                           constitution law, necessitarianism about the actual
                           world. W is a presupposition of the programme, not a
                           commitment among the others: denying it grants the
                           conclusion trivially and empties the question. STATUS
                           records W as a presupposition and lists
                           necessitarianism as the position that denies it.

5.5 Necessitarian fails    law and core entail W. That would be a strengthening
                           nobody expected and it is investigated before anything
                           is claimed; not reported as a bonus.

5.5 BareWitness fails      W alone removes the first disjunct and the law is
                           redundant. The cut then reduces to "add W" and says so.

5.4 fails                  the law as stated does not connect to the trichotomy;
                           a specification failure in section 3, recorded, not
                           repaired by weakening the target.

5.3 fails constructively   the classical step is recorded in the audit and the
in either direction        statement stands; no change to the target.

5.6 or 5.8 fails           twoRootModel is not degenerate in the stated sense or
                           the single-successor condition was mis-specified;
                           recorded as a specification error.
```

## 7. What this does not establish

Nothing about an absolute, a God, or any theological notion.

Nothing about whether `W` is true. It is the presupposition that something contingent
exists. Its denial is necessitarianism, which is a consistent position and is not refuted
here; it is placed on the map as the position that makes the question empty.

Nothing about whether the constitution law is the right reading of "the totality of
contingent reality". The law is a commitment: rigid membership and the reading of the
totality as the joint existence of its members. Someone who rejects that reading is
untouched by 5.2 to 5.5.

Nothing about the grounding or explanation of the totality fact. The law fixes `holdsAt`
and leaves every grounding and explanatory relation free.

Nothing new about the fork. 5.4 removes one disjunct under two explicit premises; the
remaining fork between a necessary explanatory source and a contingent explanatory
absolute is exactly where `fact-sufficient-explanation-1` left it, and local sufficient
explanation remains the commitment that decides it.

The foundation-side results do not weaken `exists_necessary_ungrounded`. They record what
its conclusion means on a frame the premises do not exclude.

## 8. Boundary

```text
NO A2 / A3 / A6-A8 on the totality side
NO God predicate        NO theological predicate     NO physical predicate
NO Goedel-Scott         NO TWIST-J                   NO mathlib
NO new structure, class or axiom
NO law on groundsFact, constitutesFact or explainsFact
NO world-relative membership
NO change to any existing theorem signature or existing module
NO claim that W is true, and NO claim that the law is forced
```

Structural requirement: the new modules are leaves. Nothing on `main` imports them,
and only `Logos.lean` and the audit file may import them in this cut.

## 9. Acceptance tests

```text
T1   lake build succeeds from the pinned toolchain
T2   no sorry, sorryAx or native_decide in the new files
T3   #print axioms on every result reports at most
     propext, Classical.choice, Quot.sound; the results predicted axiom-free
     in section 5 are checked individually
T4   5.2 and the forward form are stated over an arbitrary F and R satisfying
     the law, not over the construction
T5   the four models of 5.5 are exhibited, and the first three are instances
     of constitutedFacts
T6   Necessitarian has at least two accessible worlds from the actual world
T7   BareWitness refutes TotalityRequiresMembers explicitly
T8   twoRootModel is shown to satisfy the single-successor hypothesis
T9   static guard: no structure, class or axiom declaration in the new files
T10  no existing theorem signature changes; git diff on pre-existing Lean
     files is confined to Logos.lean import lines
T11  the audit file and the static guard are wired into CI in the same PR
```

## 10. Outcome

Added after implementation.
