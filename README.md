# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, assumptions, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

The first research cut, `modal-foundation-1`, builds a small Kripke-semantic core for necessity, possibility, contingency, and analysis of modal principles.

The second cut, `finite-countermodels-2`, adds explicit finite frames and pointed refutations and is now part of `main`.

The current research branch, `absolute-ground-1`, develops an independent grounding-based metaphysical argument directly on that accepted modal/countermodel base. It is separate from Gödel–Scott and from TWIST-J.

## Current boundary

The central question is deliberately narrow:

> If anything at all exists, is some necessary ungrounded reality forced?

The branch separates this from the stronger question whether there is exactly one universal root.

The current sources contain:

- Kripke frames and world-indexed propositions;
- necessity, possibility, and contingency;
- finite modal countermodels;
- a modal grounding language with world-relative existence;
- explicit grounding commitments A0-A8;
- `FoundationAxioms` for A0-A2;
- `NecessaryExistenceAxioms` for A0-A2 plus A4-A5, with no A3;
- `StructuralAxioms` carrying A3 separately;
- a proof that A0-A2 plus A4-A5 force some necessary ungrounded entity;
- a proof that A3 is needed only for uniqueness and universal ancestry;
- a proved equivalence, under A5, between original A4 and the cleaner rule `Actual x -> not Necessary x -> Derived x`;
- a genuine acyclic infinite-regress model satisfying A0, A1, A3, A4, and A5 while failing A2;
- a two-root model satisfying the minimal necessity axioms while containing two distinct necessary ungrounded roots;
- a brute-fact model refuting both A4 formulations;
- a positive model showing a necessary root with contingent derived reality and no modal collapse;
- the transcendence/creation extensions, kept formally separate from the minimal existence theorem;
- a full axiom audit.

The load-bearing minimal theorem is:

```text
A0 + A1 + A2 + A4 + A5
        ->
there exists some actual ungrounded entity that exists necessarily
```

A3 is not part of this theorem. Adding A3 yields uniqueness and universal grounding ancestry.

This branch does not attempt to define positive properties of God. There is no formal `God` predicate, and no program to derive personality, intelligence, goodness, will, omniscience, omnipotence, or other divine attributes. Transcendence is treated as a boundary on description.

Gödel–Scott will be developed as a separate formal branch. TWIST-J is not a dependency of this argument.

See:

- `ABSOLUTE-GROUND-CONTRACT.md` for the formal contract;
- `A2-A3-A4-ATTACK.md` for the current philosophical attack surface.

Status: **FORMAL LABORATORY — ABSOLUTE-GROUND-1 IN REVIEW**.

License: MIT, copyright 2026 A. M. Thorn.
