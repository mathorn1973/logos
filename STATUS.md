# STATUS

```text
PROGRAM     LOGOS
STATE       FORMAL LABORATORY
MAIN        18 accepted cuts: 14 on the grounding line, 1 on the Goedel-Scott line,
            3 on the semantic self-reference side line
OPEN        none
FOCUS       none open; the grounding line's residue is philosophical, apart from one
            formal item listed in MAP.md section 9
AUTHORITY   none; no released theorem catalogue exists yet
CANON       none
LICENSE     MIT; copyright 2026 A. M. Thorn
```

This file describes the current state of `main` only. The question and the answer are in
`README.md`, the logical map is in `MAP.md`, and the record of how `main` got here, cut by cut,
is in `history/CHANGELOG.md`.

## Non-negotiable boundary

LOGOS makes no unconditional theological claim.

Every proved statement is relative to explicit definitions, assumptions or axiom records, semantics, frame conditions, carrier types, valuations, and interpretation maps. A successful Lean proof establishes derivability from those commitments. It does not by itself establish that the commitments describe reality.

## Accepted cuts

Contracts are under `contracts/<line>/`. Audit files are under `Logos/` and CI runs every one of
them. `Logos/Audit.lean` additionally prints the axioms of the logic layer and of the early
grounding cuts.

```text
grounding line
  cut                            PR    contract                                 audit (Logos/*.lean)
  modal-foundation-1             #1    DESIGN-CONTRACT.md (historical)          Audit
  finite-countermodels-2         #3    FINITE-COUNTERMODELS-CONTRACT.md         Audit
  absolute-ground-1              #4    ABSOLUTE-GROUND-CONTRACT.md              CoreBoundaryAudit
  totality-regress-1             #5    TOTALITY-REGRESS-CONTRACT.md             CoreBoundaryAudit
  totality-externality-1         #6    TOTALITY-EXTERNALITY-CONTRACT.md         TotalityExternality*Audit,
                                                                                ScopeAudit
  self-explanation-1             #7    SELF-EXPLANATION-CONTRACT.md             SelfExplanationAudit
  fact-sufficient-explanation-1  #8    FACT-SUFFICIENT-EXPLANATION-CONTRACT.md  FactSufficientExplanationAudit
  contingent-absolute-1          #9    CONTINGENT-ABSOLUTE-CONTRACT.md          ContingentAbsoluteAudit
  grounded-modality-1            #10   GROUNDED-MODALITY-CONTRACT.md            GroundedModalityAudit
  carrier-schema-1               #18   CARRIER-SCHEMA-CONTRACT.md               CarrierSchemaAudit
  route-seam-1                   #16   ROUTE-SEAM-CONTRACT.md                   RouteSeamAudit
  a4-fact-independence-1         #24   A4-FACT-INDEPENDENCE-CONTRACT.md         A4FactIndependenceAudit
  totality-constitution-1        #33   TOTALITY-CONSTITUTION-CONTRACT.md        TotalityConstitutionAudit
  necessitation-1                #39   NECESSITATION-CONTRACT.md                NecessitationAudit

Goedel-Scott line
  scott-collapse-1               #36   SCOTT-COLLAPSE-CONTRACT.md               ScottCollapseAudit

semantic self-reference side line
  internal-truth-1               #27   INTERNAL-TRUTH-CONTRACT.md               SemanticLineAudit
  self-closure-1                 #28   SELF-CLOSURE-CONTRACT.md                 SemanticLineAudit
  truth-fact-seam-1              #31   TRUTH-FACT-SEAM-CONTRACT.md              SemanticLineAudit
```

PR numbers are those of the cut PRs; `#8` to `#10` were stacked on `#7` and reached `main`
through it. What each cut established, with its negative boundary, is in its contract
and in `history/CHANGELOG.md`.

## Live premise register

Principles the formal layer states and does not establish. The machine has not established any
of them, nor the presupposition, as true of reality. `MAP.md` section 6 shows where each one acts.

### Commitments

#### Local sufficient explanation for the totality fact

Global EF4 is gone from the core. What remains is the local principle for the one designated fact, and it is provably equivalent to excluding a contingent explanatory absolute there. Accepting it is therefore the same commitment as rejecting the third disjunct, and it cannot be argued for by way of that rejection.

#### A4' at the entity level

Stated in `absolute-ground-1` as `NonNecessaryIsDerived`:

> what actually exists but need not exist is not ontologically ultimate.

Under A5 it is equivalent to the original A4. `a4-fact-independence-1` shows it is a separate
commitment from the fact-level principle above: each can hold while the other fails, under the
shared hypothesis schema. These are two non-entailments. Read as a claim about arguments: a
result whose conclusion is A4' does not reach the fact-level principle, so the brute-fact
position survives every result that only rules out brute entities.

#### Adequacy of contingent self-citation

`self-explanation-1` reduced irreflexivity to a local adequacy condition. The residue is normative, not structural:

> Can an identity citation `P because P` count as an adequate complete explanation of why contingent P obtains?

The countermodel shows exactly what answering yes permits: a wholly contingent reality closed by circular self-citation.

#### No brute modality

`grounded-modality-1` states it precisely: every accessible failure of a fact has an actual condition licensing it. It is a premise of a new axis, not a new route to the conclusion, and on its own it does not close the fork.

#### The constitution law for the totality fact

Commitment, confined to `totality-constitution-1`. No result outside that cut depends on it.

`ConstitutedTotality`: the totality fact obtains at a world exactly when every represented
member exists there, with membership fixed across worlds. Two choices in it can be rejected:
that membership is rigid, and that the totality is the joint existence of its members. A
world-relative reading is a different law and has not been attempted. `BareWitness` shows the
law is load-bearing: without it `W` does not remove the first disjunct.

#### Full comprehension in the Goedel-Scott embedding

Commitment, confined to `scott-collapse-1`. No result outside that cut depends on it.

Property variables range over every function from individuals and worlds to propositions,
including functions that mention a particular world. The placement of Scott's package on the
denial of `W` turns on it: the argument instantiates Scott's D3 at the property of being a
given individual at a given world. A reader who holds that property variables range only over
what the object language of higher-order modal logic can express, where no world is nameable,
is untouched by that placement. Whether anything of it survives there is not attempted.

### Presupposition

#### W: something actual is not necessary

*Presupposition of the programme's question, not a commitment among the others.*

Stated in `totality-constitution-1` as `ContingencyWitness`. It is in no accepted premise
package. Its denial is necessitarianism about the actual world. That position is consistent
and is not refuted anywhere in the repository: the `Necessitarian` model inhabits it on a
frame that is not degenerate. Under the constitution law and completeness, denying `W` is
exactly the first disjunct of the trichotomy, so the position grants the totality conclusion
trivially and empties the question rather than opposing necessary reality. On the foundation
side `W` is what excludes the frame on which `Necessary` coincides with `Actual`.

`scott-collapse-1` places Scott's axiom package on this position: under full comprehension,
Scott's A1, A2 and A5 with back-access at the actual world force the single-successor frame. That is a
statement about where the package sits, relative to the comprehension commitment above. It is
not an argument against `W` and not an argument against the package.

### Questions

Open, and no theorem depends on how they are answered.

#### Principled versus stipulated carrier exemption

*Philosophical question, not a premise.*

`carrier-schema-1` shows that an actual contingent item can be offered as an explainer of the target only at a carrier exempted from completeness, scope or adequacy. Whether such an exemption can be principled is a philosophical question the formal layer deliberately leaves open.

The exemption is not identified for any particular proposal. In particular it is **not** established that the modal condition of `ConditionedBrute` is exempt from completeness: `CompletenessExempt` is an uninterpreted one-item carrier, no interpretation of `Explains` is supplied for the modal-condition carrier, and there is no bridge to `licensesFailure`.

#### Whether a link that does not necessitate can explain

*Philosophical question, not a premise. Opened by `necessitation-1`.*

On the foundation route, with A1, A2, A4 and A5, grounding that necessitates is equivalent to
every actual entity being necessary. On the totality route, with the core and local sufficient
explanation, explanation that necessitates is equivalent to the totality fact being necessary,
and under the constitution law that is the denial of `W`; without the law `W` survives
(`LawlessNecessitation`). So whoever keeps a necessary reality and `W` needs a link from the
necessary source that does not necessitate its target: on the foundation route from A1, A2, A4
and A5, and on the totality route only under the constitution law as well.

With such a link there is an accessible world where the source exists and the target fails. The
question is whether the source then explains why the target obtains rather than fails, or
whether the link is itself a brute element. The formal layer states the constraint and leaves the
question open.

#### Whether the middle disjunct deserves the name

*Interpretive question, not a premise. No theorem depends on how it is answered.*

`route-seam-1` shows the totality route's necessary explanatory source may itself be grounded,
while the foundation route's witness is ungrounded by construction. Only the foundation route
concludes that its witness is ungrounded. Whether a necessary explanatory source that is itself
grounded is an absolute in the intended sense is a human judgment, not a formal one.

#### Whether the truth carrier is a new axis

*Question, not a premise.*

Settled conditionally by `truth-fact-seam-1` and no longer open in the form it had. Under a
two-valued carrier and a self-closed language the truth side is a function of the fact side
on the image of the coding map; otherwise it is not. What survives is narrower and is a
question about the bridge rather than about the carriers: whether
`ActualFact F (sentenceFact s) <-> isT (val s)` is the right reading of the relation at all.
That is a philosophical question and the formal work does not touch it.

#### Whether maximality needs choice at arbitrary size

*Technical question, not a premise.*

`SELF-CLOSURE-CONTRACT.md` section 9. Choice-free at finite size, not in the proof given at
`Nat`.

## Boundaries

### Interpretation firewall

The accepted grounding/totality core contains no formal `God` predicate and no theorem identifying a formal root, fact, external ground, or explanatory source with God. It must not depend on Goedel-Scott predicates, positive divine attributes, revelation or confessional premises, TWIST-J physics, essay prose, metaphor, or a hidden global project axiom.

Goedel-Scott is a separate line with one accepted cut, `scott-collapse-1`. No module of the
grounding/totality core or of the semantic line imports it, its seam module is a leaf, and CI
enforces both. Scott's D1 is named `AllPositive` in Lean. The source's name for it appears in no
Lean file. Among the contracts it appears in section 3 of `SCOTT-COLLAPSE-CONTRACT.md` (whose own
pointer to a mapping in its section 4 is inaccurate) and in the list of vocabulary
`FINITE-COUNTERMODELS-CONTRACT.md` kept out of that cut. No theorem uses any reading of it.

Apart from the Goedel-Scott import and token guards, and the axiom gate, which keeps any
hidden global axiom out of the library, nothing in CI checks this firewall; it holds by
inspection and review. The same is true of the general layer direction in
`PROJECT-RULES.md` section 3.

### Enforced by CI

Each boundary below was introduced by the cut or pull request named. Import guards check direct
imports under `Logos/`. The root `Logos.lean` imports every library module; the audit files are
not library modules, and each imports either the root or specific modules.

```text
no declaration in the library (every module Logos.lean           #41, AxiomGateAudit.lean
  imports) uses an axiom beyond propext, Classical.choice and
  Quot.sound, and no axiom is declared there
no axiom declaration, unfinished proof or native_decide in any    #42, textual guards
  Lean file, the audit files included
exists_necessary_ungrounded needs no A3 and no A6-A8              absolute-ground-1, CoreBoundaryAudit.lean
the deep externality theorem uses no A2, A3 or old E               totality-externality-1
the modal layer does not enter the totality argument               grounded-modality-1
the carrier-neutral schema refers to no entity, fact or regress    carrier-schema-1
  structure
the route seam declares no new record                              route-seam-1
the constitution law is imported only by its own cut, its audit    totality-constitution-1, amended by
  and the Scott seam, which may not use it                           scott-collapse-1
the semantic line uses no grounding carrier; nothing outside the   internal-truth-1 to truth-fact-seam-1
  line and its seam imports it; the seam is a leaf
the Goedel-Scott line imports only the logic layer; its seam is    scott-collapse-1
  a leaf; no theological token in its Lean files
the necessitation cut declares no record, nothing outside it       necessitation-1
  imports it, and it names no identifier of the constitution
  law, of W (ContingencyWitness), of A3 or of A6-A8
```

## Open stack

Empty. No research cut is open on any line.

## Open repository questions

- Whether the CI trigger list should cover stacked branches. `.github/workflows/lean.yml` runs
  on pushes to `main` and `cut/**` and on pull requests into them, so a branch stacked on a
  non-cut branch shows no checks until the workflow is dispatched by hand.

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
9. `MAP.md`, `STATUS.md`, `history/CHANGELOG.md` and affected contracts are immediately synchronized with the actual `main` state, and `README.md` too when the answer it states has changed.

Project-wide governance is defined in `PROJECT-RULES.md`.
