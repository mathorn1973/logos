# STATUS

```text
PROGRAM     LOGOS
STATE       FORMAL LABORATORY
MAIN        modal-foundation-1 + finite-countermodels-2 + absolute-ground-1 + totality-regress-1
            + totality-externality-1 + self-explanation-1 + fact-sufficient-explanation-1
            + contingent-absolute-1 + grounded-modality-1 + carrier-schema-1
            + route-seam-1 + a4-fact-independence-1
FOCUS       none open; the formal programme is stable and the residue is philosophical
AUTHORITY   none; no released theorem catalogue exists yet
CANON       none
LICENSE     MIT; copyright 2026 A. M. Thorn
```

## Non-negotiable boundary

LOGOS makes no unconditional theological claim.

Every proved statement is relative to explicit definitions, assumptions or axiom records, semantics, frame conditions, carrier types, valuations, and interpretation maps. A successful Lean proof establishes derivability from those commitments. It does not by itself establish that the commitments describe reality.

## Accepted foundation route

`absolute-ground-1` is on protected `main`.

```text
A0 + A1 + A2 + A4 + A5
        ->
some actual ungrounded entity exists necessarily
```

`NecessaryExistenceAxioms` contains A0-A2 and A4-A5. A3 is absent and is used only for uniqueness and universal ancestry. A6-A8 are separate extensions and are not premises of the minimal theorem.

## Accepted totality route

`totality-regress-1` is on protected `main`.

Its load-bearing package is:

```text
F4  actual non-necessary facts are entity-grounded
E   a ground of the regress-totality fact is outside the represented regress
C   every actual non-necessary entity is inside the represented totality
```

Lean proves:

```text
NecessaryFact(totality)
OR
exists an actual necessary entity outside the regress grounding the totality fact
```

No A2/well-foundedness or A3/unity premise occurs in this theorem. This route does not prove that the necessary witness is ungrounded; `route-seam-1` pins that by countermodel.

The accepted independence suite shows that pure contingency survives if any one of F4, E, or C is removed.

## Accepted externality and premise-order cut

`totality-externality-1` is also on protected `main`.

It separates primitive constitutive and explanatory fact roles and introduces:

```text
EF4    actual non-necessary facts have an explanatory source
E_expl an explanatory source of the totality fact lies outside the represented regress
G      ExplanationImpliesGrounding
S      an explanation of the totality covers every entity inside its claimed scope
I      no actual entity explains itself
```

The verified premise-order map is:

```text
without G:
  F4 and EF4 are independent
  E and E_expl are independent

with G:
  EF4 is strictly stronger than F4
  E_expl is strictly weaker than E
```

Thus `totality-externality-1` is not a net premise reduction. It factors one commitment while exposing that the sufficient-ground axis has moved from generic F4 to stronger EF4 under the natural bridge G.

The deepest accepted theorem uses:

```text
EF4 + S + I + C
```

and proves:

```text
NecessaryFact(totality)
OR
exists an actual necessary explanatory source outside the represented regress
```

Its negative boundary is explicit:

```text
NO A2 / well-foundedness
NO A3 / common-ground premise
NO old E
NO ExternalRegressTotalityAxioms
NO primitive E_expl in the deep theorem
NO ExternalExplanationAxioms conversion in the deep theorem source
NO A6-A8
```

Dedicated type-level and static CI audits enforce this boundary.

## Accepted explanation line

Cuts `self-explanation-1` through `carrier-schema-1` are on protected `main`.

The core no longer asserts that an explanation exists:

```text
TotalityExplanationCore
    ES   a source explaining the actual totality fact is itself actual
    LA   the totality explanation adequately explains each actual member in scope
    C    every actual non-necessary entity is inside the represented totality
```

Lean proves the three-way fork:

```text
NecessaryFact(totality)
OR  an actual necessary explanatory source explains the totality fact
OR  ContingentExplanatoryAbsoluteFact(totality)
```

and the equivalence that fixes the cost of the third disjunct:

```text
local EF4 at the totality fact
    IFF
no contingent explanatory absolute at the totality fact
```

Two recorded failures, kept because they are results:

```text
contingent-absolute-1
    explanatory ultimacy -> necessity  IFF  local EF4
    so that route is not independent of EF4

grounded-modality-1
    no-brute-modality + modal unconditionedness  IFF  actual + necessary
    so the implication partitions necessity rather than deriving it
    and ConditionedBrute satisfies no-brute-modality together with a
    contingent explanatory absolute
```

The carrier-neutral engine:

```text
closure_explainer_is_necessary
    ScopeClosureAxioms K -> K.Explains a -> K.Necessary a

escape_requires_exemption
    K.Explains a -> not K.Necessary a -> not ScopeClosureAxioms K
```

with `TotalityExplanationCore` proved to instantiate `ScopeClosureAxioms`, and three one-item countermodels showing completeness, scope and adequacy are each separately load-bearing.

Negative boundary of the line:

```text
NO closure of the fork; a contingent explanatory absolute remains available
NO claim that any particular carrier exemption is illegitimate
NO claim that the three closure conditions are exhaustive
NO derivation of necessity from explanatory ultimacy
NO joining of the modal layer to the totality argument
     (enforced by a static CI guard)
NO theological or physical predicate anywhere in the line
```

## Accepted route seam

`route-seam-1` is on protected `main`.

Three findings, in order of weight.

**The record is weak.** `RegressTotality` carries an infinite descending grounding chain and
little else; its fact layer, designated fact and `inside` predicate are largely free data.

```text
exists_descending_chain_of_not_wellFounded
    not WellFounded (ActualGrounds M)
      -> exists f, forall n, ActualGrounds M (f (n+1)) (f n)

wellFounded_or_regressTotality
    WellFounded (ActualGrounds M) or Nonempty (RegressTotality M (bareFactModel M))

bare_totality_necessary
    NecessaryFact (bareFactModel M) R.totality
```

The last line is the deflation: the freely constructed witness satisfies the totality
conclusion by its first disjunct with no explanatory premise doing work.

**The presuppositions of the two routes are incompatible.**

```text
regressTotality_refutes_wellFoundedness      no axioms
regressTotality_refutes_foundationAxioms     no axioms
regressTotality_refutes_necessaryExistenceAxioms   no axioms
seam_bridge_is_vacuous                       no axioms
```

**The core fixes modality, not grounding.** `GroundedExplainer` inhabits
`TotalityExplanationCore`, sits on the middle disjunct of the accepted trichotomy, and has a
necessary explanatory source that is itself grounded.

```text
core_fixes_necessity_not_grounding
    every explainer of the totality fact is necessary
    and none of them is ungrounded, in that model
```

The accepted positive model gives the opposite grounding reading, so `Ungrounded(explainer)`
is undetermined by the core.

Negative boundary:

```text
NO claim that the two premise packages are exhaustive; both may fail
NO claim that either route applies whenever the other does not
NO unqualified reading of the totality conclusion as a necessary explanatory source
NO claim that the structural dichotomy supports either route
NO claim that the substantive totality premises are available whenever A2 fails
NO new axiom record; enforced by a static CI guard over the seam layer
```

## Accepted A4 fact independence

`a4-fact-independence-1` is on protected `main`.

Two countermodels under one hypothesis schema, fixed before the models were built:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
not NecessaryFact F R.totality
```

What is proved is exactly two non-entailments under that schema:

```text
A4 and A4' do not entail local EF4       witnessed by FactBruteEntityRegular
local EF4 does not entail A4 or A4'      witnessed by EntityBruteFactRegular
```

Both forms of the entity-level principle appear in both directions, the original A4 as well
as `NonNecessaryIsDerived`. The second model exhibits non-vacuity of local EF4 as two
separate facts, so the direction cannot be met by a principle that holds only because its
antecedent fails, and it satisfies the fact-level bridge `ExplanationImpliesGrounding`
rather than dispensing with it.

The gap the second direction does rely on is at the entity level:

```text
root_explains_stray_without_grounding
    AdequateExplainsEntity M E root stray and not ActualGrounds M root stray
```

The current language has no bridge from adequate explanation to ontological grounding for
entities. If one were added, that direction would have to be re-examined.

Negative boundary:

```text
NO claim that either principle is true
NO claim that the two principles exhaust the brute positions
NO claim about what any argument against one position reaches
NO claim about carrier extension in either direction
NO independence claim under a future entity-level explanation-to-grounding bridge
NO new axiom record, structure, class or axiom; enforced by a static CI guard
```

## Current live philosophical commitments and questions

The first five items are commitments: principles the formal layer states and does not
establish. The last is an interpretive question about how to read an accepted result, and
no theorem depends on how it is answered.

The machine has not established any of the commitments as true of reality.

### Local sufficient explanation for the totality fact

Global EF4 is gone from the core. What remains is the local principle for the one designated fact, and it is provably equivalent to excluding a contingent explanatory absolute there. Accepting it is therefore the same commitment as rejecting the third disjunct, and it cannot be argued for by way of that rejection.

### A4' at the entity level

Stated in `absolute-ground-1` as `NonNecessaryIsDerived`:

> what actually exists but need not exist is not ontologically ultimate.

Under A5 it is equivalent to the original A4. `a4-fact-independence-1` shows it is a separate
commitment from the fact-level principle above: each can hold while the other fails, under the
shared hypothesis schema. So neither can be argued for by way of the other, and the brute-fact
position survives every argument that only rules out brute entities.

### Adequacy of contingent self-citation

`self-explanation-1` reduced irreflexivity to a local adequacy condition. The residue is normative, not structural:

> Can an identity citation `P because P` count as an adequate complete explanation of why contingent P obtains?

The countermodel shows exactly what answering yes permits: a wholly contingent reality closed by circular self-citation.

### Principled versus stipulated carrier exemption

`carrier-schema-1` shows that a contingent item can be offered as an explainer of the target only at a carrier exempted from completeness, scope or adequacy. Whether such an exemption can be principled is a philosophical question the formal layer deliberately leaves open.

The exemption is not identified for any particular proposal. In particular it is **not** established that the modal condition of `ConditionedBrute` is exempt from completeness: `CompletenessExempt` is an uninterpreted one-item carrier, no interpretation of `Explains` is supplied for the modal-condition carrier, and there is no bridge to `licensesFailure`.

### No brute modality

`grounded-modality-1` states it precisely: every accessible failure of a fact has an actual condition licensing it. It is a premise of a new axis, not a new route to the conclusion, and on its own it does not close the fork.

### Whether the middle disjunct deserves the name

*Interpretive question, not a premise. No theorem depends on how it is answered.*

`route-seam-1` shows the totality route's necessary explanatory source may itself be grounded,
while the foundation route's witness is ungrounded by construction. `AbsoluteGround` is
reachable only on the foundation side. Whether a necessary explanatory source that is itself
grounded is an absolute in the intended sense is a human judgment, not a formal one.

## Interpretation firewall

The accepted grounding/totality core contains no formal `God` predicate and no theorem identifying a formal root, fact, external ground, or explanatory source with God. It must not depend on Goedel-Scott predicates, positive divine attributes, revelation or confessional premises, TWIST-J physics, essay prose, metaphor, or a hidden global project axiom.

Goedel-Scott remains a separate research branch.

## Open stack

Empty. No research cut is open.

The `#7` to `#10` chain and `#14` were promoted on 2026-08-20, followed by `#16 route-seam-1`
after review required it to be rebased on the promoted state, to drop two interpretive
overreaches and to be restated against `TotalityExplanationCore` rather than the superseded
`CompleteScopedExplanationAxioms`.

`#24 a4-fact-independence-1` followed on the same day, after `#25` had corrected four
documents that still stated the carrier result and the modal-licensing result more strongly
than the types support. Review of `#24` also required adequacy to be put into the type of
`root_explains_stray_without_grounding`, and required the contract to claim two
non-entailments rather than anything about the reach of arguments.

## Promotion and closure rule

A cut is not operationally complete merely because its code PR merged. The merge sequence is complete only when:

1. the exact statements are committed;
2. the project builds from the pinned toolchain;
3. axiom and boundary audits pass;
4. no `sorry` or `sorryAx` occurs in trusted source;
5. theorem signatures use no stronger assumption records than required;
6. load-bearing assumptions have explicit countermodels where practical;
7. the semantic reading has been reviewed;
8. the result is classified as theorem, countermodel, consistency witness, bridge, or interpretation; and
9. README, STATUS, and affected contracts are immediately synchronized with the actual `main` state.

Project-wide governance is defined in `PROJECT-RULES.md`.
