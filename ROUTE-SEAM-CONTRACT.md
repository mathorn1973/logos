# ROUTE-SEAM-1 DESIGN CONTRACT

Status: **RESEARCH CUT, IN REVIEW**.

Base: `main` (accepted through `totality-externality-1`).

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

A feasibility spike confirmed that the two load-bearing statements of section 5 are provable before this contract was frozen. No statement below is asserted on the strength of that spike alone; each is an acceptance test in section 10.

## 1. Motivation

`main` carries two routes to necessary reality that have never been related to each other.

```text
foundation route     A0 + A1 + A2 + A4 + A5
                       -> some actual ungrounded entity exists necessarily

totality route       EF4 + S + I + C
                       -> NecessaryFact(totality)
                          or an actual necessary explanatory source outside the regress
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
countermodel     GroundedExplainer
consistency witness  UngroundedExplainer (read off the accepted positive model)
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

### 5.3 Ungroundedness of the explainer is independent of the deep package

`GroundedExplainer` is a model satisfying `CompleteScopedExplanationAxioms`, that is
EF4 + S + I + C, in which:

```text
the totality fact is actual and non-necessary
root is actual, necessary, explains the totality fact, and lies outside the regress
over is actual, necessary and grounds root
therefore root is derived and not ungrounded
and no explainer of the totality fact in the model is ungrounded
```

The accepted positive model already on `main` gives the opposite reading: its explainer is
ungrounded. Stating both makes `Ungrounded(explainer)` neither forced nor forbidden by the
deep package. It is simply not determined by it.

## 6. What this establishes about the program

The two routes are **alternatives, not stages**. The foundation route treats well-founded
grounding and concludes to an ungrounded necessary entity. The totality route treats
bottomless grounding and concludes to a necessary explanatory source that may itself be
grounded. They divide the ground between them; they never overlap.

The stronger predicate `AbsoluteGround`, which builds in `Ungrounded`, is therefore
reachable only on the foundation side. Nothing on the totality side supports it.

## 7. What this does not establish

It does not show that the two cases are exhaustive. `¬ WellFounded (ActualGrounds M)` does
not by itself deliver a `RegressTotality`: extracting a descending chain needs a choice
principle, and the fact carrier, the designated totality fact and the `inside` predicate are
further structure that no negation supplies. "Either A2 or a regress totality" is not a
theorem of this cut and must not be read into it.

It does not show that the totality explainer is grounded. `GroundedExplainer` shows only
that it may be.

It does not weaken either accepted route. Neither `NecessaryExistenceAxioms` nor
`CompleteScopedExplanationAxioms` changes, and no accepted theorem is restated.

It does not identify any formal object with God, and it attributes no positive property to
anything necessary.

## 8. Boundary

```text
NO new axiom record
NO new ontological language
NO modification of any accepted theorem or record
NO A3, A6, A7, A8 anywhere in the cut
NO claim that the A2 case and the regress case are exhaustive
NO claim that the totality explainer is grounded, only that it may be
```

## 9. Remaining philosophical boundary

The seam is now exact and it is a fork about the shape of grounding, not about explanation:

> Is actual grounding well founded?

If yes, the foundation route applies and delivers an ungrounded necessary entity.
If it is bottomless in the specific shape of a regress totality, the foundation route is
unavailable and the totality route delivers something weaker: a necessary explanatory
source that need not be a terminus of grounding at all.

The open human question is whether the weaker conclusion is worth the same name. A
necessary explanatory source that is itself grounded is not an absolute in the sense
`absolute-ground-1` defines, and the program should stop writing as though the two routes
converge on one object.

## 10. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. `regressTotality_refutes_wellFoundedness` is proved from the `RegressTotality` fields alone;
4. the two refutation corollaries for `FoundationAxioms` and `NecessaryExistenceAxioms` elaborate;
5. `seam_bridge_is_vacuous` elaborates for an arbitrary conclusion;
6. `GroundedExplainer` inhabits `CompleteScopedExplanationAxioms`;
7. in `GroundedExplainer` the totality fact is non-necessary and no explainer of it is ungrounded;
8. the accepted positive model is shown to have an ungrounded explainer, giving the other direction;
9. the seam layer declares no `structure`, enforced by static CI guard;
10. dedicated axiom audit is green;
11. no new premise enters any accepted axiom record;
12. no theological interpretation enters the proof core.
