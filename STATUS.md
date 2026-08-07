# STATUS

```text
PROGRAM     LOGOS
STATE       FORMAL LABORATORY
MAIN        modal-foundation-1 + finite-countermodels-2 + absolute-ground-1
FOCUS       next totality/explanation cuts; A2 / A4 / A3 remain explicit philosophical forks
AUTHORITY   none; no released theorem catalogue exists yet
CANON       none
LICENSE     MIT; copyright 2026 A. M. Thorn
```

## Non-negotiable boundary

LOGOS makes no unconditional theological claim.

Every proved statement is relative to explicit definitions, assumptions or axiom records, semantics, frame conditions, carrier types, valuations, and interpretation maps. A successful Lean proof establishes derivability from those commitments. It does not by itself establish that the commitments describe reality.

## Accepted grounding theorem on main

`absolute-ground-1` is merged into protected `main`.

```text
A0  something is actual
A1  grounding relates existents
A2  actual grounding is well founded
A4  actual contingent beings are derived
A5  the actual world accesses itself
```

These assumptions are bundled as `NecessaryExistenceAxioms`. Lean proves:

```lean
exists_necessary_ungrounded :
  NecessaryExistenceAxioms M →
  ∃ a, Ungrounded M a ∧ Necessary M a
```

A3 is absent from that signature. It is used only for uniqueness and universal grounding ancestry.

A6–A8 are later explicit extensions:

- A6: created actual entities are derived;
- A7: the created order is nonempty;
- A8: actual aseity is essential across accessible worlds.

They are not premises of `exists_necessary_ungrounded`. `Logos/CoreBoundaryAudit.lean` pins this boundary in CI.

## Accepted attack surface

### A2 — infinite regress

`Logos.Models.Grounding.InfiniteRegress` is an acyclic bottomless model satisfying A0, A1, A3, A4, and A5 while A2 fails. Every entity has a further ground and no ungrounded root exists.

### A4 — contingent brute fact

Under A5, original A4 is equivalent to:

```text
Actual x → ¬ Necessary x → Derived x
```

The brute-fact model refutes both forms.

### A3 — fundamental plurality

The disconnected two-root model satisfies `NecessaryExistenceAxioms` while A3 fails and contains two distinct actual, ungrounded, necessary roots. A3 therefore excludes fundamental plurality; it does not carry the minimal existence proof.

## Interpretation firewall

The accepted grounding core contains no formal `God` predicate and no theorem identifying a formal root with God. It must not depend on Gödel–Scott predicates, positive divine attributes, revelation or confessional premises, TWIST-J physics, essay prose, metaphor, or a hidden global project axiom.

Gödel–Scott is a separate research branch. The totality/explanation route is a second grounding research line. Neither may silently become a premise of the accepted minimal theorem.

## Open stack

PRs #5–#10 are research cuts beyond the accepted grounding layer. Their current Git history is not by itself evidence of logical dependency. Each cut must be restacked according to actual imports and theorem dependencies before promotion.

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
9. README and STATUS are immediately closed from branch/review language to the actual `main` state.

Project-wide governance is defined in `PROJECT-RULES.md`.
