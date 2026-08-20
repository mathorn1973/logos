# ROUTE-SEAM-1 DESIGN CONTRACT

Status: **ACCEPTED CUT CONTRACT - ON MAIN**.

Base, original: `main` accepted through `totality-externality-1` (`d9519f5`).
Base, final: `main` after the explanation-line promotion (`9dd17c5`). The cut was rebased
onto the promoted state during review, and sections 1, 5.3 and 7 were restated against
`TotalityExplanationCore` accordingly.

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

A feasibility spike confirmed that the two load-bearing statements of section 5 are provable before this contract was frozen. No statement below is asserted on the strength of that spike alone; each is an acceptance test in section 10.

**Amended during review.** Section 7 originally claimed that the exclusivity result could not be turned into an exhaustive dichotomy, on the ground that a negation supplies neither a descending chain nor the fact-layer data. The first half of that reason was right and the second was wrong: the fact layer is free data. Section 5.4 now proves the dichotomy, and section 7 records what the correction does and does not buy. The amendment is kept visible rather than rewritten away.

**Amended a second time during review.** Review found two overreaches and one stale
dependency. Sections 6 and 9 read the structural dichotomy as though the full premise
packages were exhaustive, and read the totality conclusion as a necessary explanatory
source without its remaining disjuncts. Section 5.3 was stated against
`CompleteScopedExplanationAxioms`, which the promotion of the explanation line superseded.
Sections 5.3, 5.4, 6, 7, 8, 9 and the acceptance tests are corrected, and the countermodel
is now also a witness for `TotalityExplanationCore`. Both amendments stay on the record.

**Amended a third time after promotion.** Post-merge review found four residues of the
superseded package that the second amendment had claimed to remove: the base line, the
closing sentence of 5.4, the "partition" phrasing, and two sentences in 7. All four are
corrected here. The same review found that the ungrounded-explainer direction existed only
as pieces a reader had to assemble; `current_core_has_ungrounded_explainer` and
`core_leaves_explainer_groundedness_undetermined` now state it against the current core.
All three amendments stay on the record.

## 1. Motivation

`main` carries two routes to necessary reality that have never been related to each other.

```text
foundation route     A0 + A1 + A2 + A4 + A5
                       -> some actual ungrounded entity exists necessarily

totality route       TotalityExplanationCore (ES + LA + C), no EF4
                       -> NecessaryFact(totality)
                          or an actual necessary explanatory source
                          or a contingent explanatory absolute totality fact
```

`README` and `STATUS` both record that the totality route "does not prove that the necessary witness is ungrounded". That is stated as prose. It has never been pinned by a countermodel, and the obvious repair, importing A2 to recover ungroundedness through the existing ancestry machinery, has never been checked.

This cut asks the two questions that seam raises:

1. Is the totality route's necessary explanatory source ungrounded?
2. Can the two premise packages be combined in one model, so that the second route inherits the first route's stronger conclusion?

## 2. Claim type

```text
proved theorem   regressTotality_refutes_wellFoundedness
                 regressTotality_refutes_foundationAxioms
                 regressTotality_refutes_necessaryExistenceAxioms
                 seam_bridge_is_vacuous
                 exists_descending_chain_of_not_wellFounded
                 wellFounded_or_regressTotality
                 bare_totality_necessary
                 core_trichotomy_second_disjunct
                 core_fixes_necessity_not_grounding
countermodel     GroundedExplainer
consistency witness  UngroundedExplainer (read off the accepted positive model)
                     BareRegress (cheapest regress totality)
```

No new language, no new axiom record, no bridge, no interpretation, no confession.

## 3. Language

None introduced. The cut is stated entirely in the vocabulary already on `main`:
`RegressTotality`, `ActualGrounds`, `Ungrounded`, `Derived`, `FoundationAxioms`,
`NecessaryExistenceAxioms`, `CompleteScopedExplanationAxioms`.

A static CI guard enforces that the seam layer under `Logos/Systems/RouteSeam/`
declares no `structure` at all, so the cut cannot smuggle in a new assumption record.

## 4. Assumptions

None added. Every theorem below is a consequence of definitions and records already accepted on `main`.

## 5. Results

### 5.1 A regress totality refutes well-foundedness

```text
regressTotality_refutes_wellFoundedness
    RegressTotality M F -> ¬ WellFounded (ActualGrounds M)
```

`RegressTotality` carries `node : Nat → Entity` together with
`step : ∀ n, ActualGrounds M (node (n+1)) (node n)`. That is an actual infinite
descending grounding chain, present as data rather than as a possibility. Any
model that carries such a structure therefore falsifies A2.

### 5.2 The two premise packages are jointly unsatisfiable

Since `FoundationAxioms` contains `grounding_wellFounded`:

```text
regressTotality_refutes_foundationAxioms
    RegressTotality M F -> ¬ FoundationAxioms M

regressTotality_refutes_necessaryExistenceAxioms
    RegressTotality M F -> ¬ NecessaryExistenceAxioms M
```

The totality route is stated over a `RegressTotality`. The foundation route requires A2.
No model satisfies both. Consequently:

```text
seam_bridge_is_vacuous
    RegressTotality M F -> NecessaryExistenceAxioms M -> C
```

for an arbitrary conclusion `C`. Any future theorem that assumes both packages proves
whatever it likes and establishes nothing.

This closes the repair route named in section 1. Ungroundedness cannot be recovered for
the totality explainer by importing A2, because A2 is unavailable wherever the totality
route applies.

### 5.3 The core fixes the explainer's modal status, not its grounding status

`GroundedExplainer` inhabits `TotalityExplanationCore`, the package accepted on `main`,
which asserts no sufficient-explanation principle at all. It also inhabits the older and
stronger `CompleteScopedExplanationAxioms`, so the reading does not depend on which
package is used. In it:

```text
the totality fact is actual and non-necessary
root is actual, necessary, explains the totality fact, and lies outside the regress
over is actual, necessary and grounds root
therefore root is derived and not ungrounded
and no explainer of the totality fact in the model is ungrounded
```

`core_trichotomy_second_disjunct` records which branch of the accepted trichotomy the model
realizes: the totality fact is neither necessary nor unexplained, so the model sits on the
middle disjunct and is not a contingent explanatory absolute.

The accepted positive model already on `main` gives the opposite reading: its explainer is
ungrounded. Stating both yields the exact reading of the cut:

```text
core_fixes_necessity_not_grounding
    every explainer of the totality fact is necessary
    and no explainer of the totality fact is ungrounded, in this model
```

`totality_explainer_is_necessary_from_core` fixes the modal status of any source that
explains the totality fact. It fixes nothing about that source's position in the grounding
order. `Ungrounded(explainer)` is neither forced nor forbidden; it is simply not determined.

### 5.4 The dichotomy is exhaustive, and that is worth nothing

The converse direction holds at the level of entities:

```text
exists_descending_chain_of_not_wellFounded
    ¬ WellFounded (ActualGrounds M)
      -> ∃ f : Nat → Entity, ∀ n, ActualGrounds M (f (n+1)) (f n)
```

by classical choice. The remaining fields of `RegressTotality`, namely the fact
carrier, the designated totality fact and the `inside` predicate, are free data and
can simply be supplied:

```text
bareFactModel        one always-obtaining fact, grounded by nothing
regressOfChain       dresses any actual descending chain as a RegressTotality

wellFounded_or_regressTotality
    WellFounded (ActualGrounds M)
      or Nonempty (RegressTotality M (bareFactModel M))
```

Together with 5.1 this **structural** dichotomy is both exclusive and exhaustive. It is a
dichotomy about the shape of actual grounding and about the availability of the record, not
about the premise packages of the two arguments. See 7 for why the latter is not exhaustive.

It is also empty. In the witness just constructed the totality fact obtains at every
world:

```text
bare_totality_necessary
    NecessaryFact (bareFactModel M) R.totality
```

so the totality route's disjunctive conclusion holds by its first disjunct with no
explanatory premise doing any work. Availability of a regress totality is a cheap
structural fact. Every substantive conclusion arrives only with the further premises stated
over the record; none follows from availability of the record alone.

The right reading of 5.1 to 5.4 together is therefore: the grounding-shape presuppositions
of the two routes lie on opposite sides of an exhaustive structural dichotomy, and neither
that placement nor its exhaustiveness is an argument for anything.

## 6. What this establishes about the program

### 6.1 `RegressTotality` is a weak record

This is the substantive finding of the cut, and 5.1 to 5.4 are best read through it.

The record carries an infinite descending grounding chain, and beyond that its fact layer,
its designated totality fact and its `inside` predicate are largely free data. Any actual
infinite descent can therefore be dressed as a `RegressTotality` with a single
always-obtaining fact. What the record captures is essentially the chain plus a label. All
the substantive content of the totality route arrives with the further premises stated over
it, never from the record itself.

### 6.2 The grounding presuppositions of the two routes are incompatible

A2 is a field of the foundation package and is refuted by the mere presence of the record.
So no model carries both premise packages, and any theorem stated over both is vacuous.

This is a statement about presuppositions, not about conclusions. It does not say that one
route applies whenever the other fails.

### 6.3 What each route yields when its own package does hold

```text
foundation package holds   -> some actual ungrounded entity exists necessarily
current totality core holds -> NecessaryFact(totality)
                               or an actual necessary explanatory source
                               or a contingent explanatory absolute totality fact
```

Both conclusions remain disjunctive or trichotomous where the accepted theorems make them
so. The totality route does not conclude to a necessary explanatory source simpliciter, and
this cut relies on that: the bare witness of 5.4 discharges the first disjunct.

The stronger predicate `AbsoluteGround`, which builds in `Ungrounded`, is reachable only on
the foundation side. Nothing on the totality side supports it, which 5.3 now pins against
the current core rather than against a superseded package.

## 7. What this does not establish

It does not show that the premise packages of the two arguments are exhaustive. Only the
structural dichotomy of 5.4 is exhaustive. Both packages can fail together: well-founded
grounding by itself supplies neither A0, A1, A4 nor A5, and the availability of a regress
record by itself supplies neither local sufficient explanation, nor adequacy, nor
completeness. "One route or the other applies" is not a theorem of this cut and is not
true in general.

It does not show that the exhaustive dichotomy of 5.4 has argumentative force. The
disjunction "A2, or a regress totality is available" is a theorem, but 5.4 also shows the
second disjunct is satisfiable by a witness in which the totality route's conclusion is
trivially true. Anyone reading the dichotomy as "so necessary reality follows either way"
has read the structure and skipped the premises.

It does not show that a regress totality satisfying the substantive premises of the current
core, that is source actuality, local adequacy and completeness, is available whenever A2
fails. Only the bare structure is constructed. Whether those premises can be met is exactly
the open question the totality route leaves standing, and nothing here touches it.

It does not show that the totality explainer is grounded. `GroundedExplainer` shows only
that it may be.

It does not weaken either accepted route. Neither `NecessaryExistenceAxioms` nor
`TotalityExplanationCore` changes, no accepted theorem is restated, and the superseded
`CompleteScopedExplanationAxioms` is left exactly as it stands on `main`.

It does not identify any formal object with God, and it attributes no positive property to
anything necessary.

## 8. Boundary

```text
NO new axiom record
NO new ontological language
NO modification of any accepted theorem or record
NO A3, A6, A7, A8 anywhere in the cut
NO claim that the exhaustive dichotomy supports either route
NO claim that the two premise packages are exhaustive; both may fail
NO claim that either route applies whenever the other does not
NO unqualified reading of the totality conclusion as a necessary explanatory source
NO claim that the substantive totality premises are available whenever A2 fails
NO claim that the totality explainer is grounded, only that it may be
```

## 9. Remaining philosophical boundary

The seam is now exact, and it must be stated at the right level.

> The grounding presuppositions of the two routes are incompatible. Well-foundedness
> against the availability of a bare regress record is an exhaustive structural dichotomy.
> The full premise packages of the two arguments do not form an exhaustive dichotomy;
> both may fail.

Where the foundation package does hold, its conclusion is an ungrounded necessary entity.
Where the current totality core does hold, its conclusion is a trichotomy, and even its
middle disjunct yields a necessary explanatory source that need not be a terminus of
grounding at all.

The open human question is therefore not "which route applies" but whether the middle
disjunct is worth the same name as the foundation conclusion. A necessary explanatory
source that is itself grounded is not an absolute in the sense `absolute-ground-1` defines,
and the program should stop writing as though the two routes converge on one object.

## 10. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `regressTotality_refutes_wellFoundedness` is proved from the `RegressTotality` fields alone;
4. the two refutation corollaries for `FoundationAxioms` and `NecessaryExistenceAxioms` elaborate;
5. `seam_bridge_is_vacuous` elaborates for an arbitrary conclusion;
6. `GroundedExplainer` inhabits `TotalityExplanationCore`, the package accepted on `main`,
   as well as the older `CompleteScopedExplanationAxioms`;
7. in `GroundedExplainer` the totality fact is non-necessary and no explainer of it is ungrounded;
8. the accepted positive model is shown to have an ungrounded explainer, giving the other direction;
9. a descending chain is extracted from failure of A2, using only classical choice;
10. `wellFounded_or_regressTotality` elaborates, making the dichotomy exhaustive;
11. `bare_totality_necessary` elaborates, showing the constructed witness satisfies the
    totality conclusion by its trivial disjunct;
12. the seam layer declares no `structure`, enforced by static CI guard;
13. dedicated axiom audit is green;
14. no new premise enters any accepted axiom record;
15. `core_fixes_necessity_not_grounding` elaborates against the current core;
15a. `current_core_has_ungrounded_explainer` elaborates, pinning the opposite direction
    against the same core, and `core_leaves_explainer_groundedness_undetermined` states
    both directions as one theorem;
16. no statement in this contract reads the totality conclusion as a necessary explanatory
    source without its remaining disjuncts;
17. no theological interpretation enters the proof core.
