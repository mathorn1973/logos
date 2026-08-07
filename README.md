# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, assumptions, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

## Accepted main line

`main` currently contains three accepted formal cuts:

1. `modal-foundation-1` — Kripke semantics for necessity, possibility, contingency, and standard modal principles under exact frame hypotheses;
2. `finite-countermodels-2` — explicit finite frames, pointed refutations, and a genuine contingency witness;
3. `absolute-ground-1` — a grounding language, explicit A0–A8 assumption records, the minimal necessary-ground theorem, and independence/countermodels delimiting its assumptions.

The load-bearing grounding theorem is:

```text
A0 + A1 + A2 + A4 + A5
        ->
there exists some actual ungrounded entity that exists necessarily
```

Formally, `exists_necessary_ungrounded` requires `NecessaryExistenceAxioms`. That record contains A0–A2 and A4–A5. It contains neither A3 nor the later transcendence/creation assumptions A6–A8.

A3 is separate and is used for uniqueness and universal grounding ancestry. A6–A8 are explicit extensions concerning created-order transcendence and essential aseity; they are not premises of the minimal existence theorem.

The accepted source also contains:

- an acyclic infinite-regress countermodel showing A2 is substantive;
- a two-root model showing A3 is a unity premise rather than an existence premise;
- a brute contingent model refuting A4 and A4′;
- a necessary-root / contingent-derived model refuting modal collapse;
- explicit axiom audits and a dedicated core-boundary audit.

## Current research frontier

Open research cuts develop a second, totality/explanation-based route around A2. They are not part of `main` until individually reviewed and merged.

Gödel–Scott is a separate formal branch of the LOGOS program, not a step in the grounding/totality sequence. TWIST-J is likewise not a dependency of the general ontology core.

## Project-wide rules

Repository-wide claim typing, import firewall, cut topology, audit requirements, and the mandatory post-merge documentation closure rule live in `PROJECT-RULES.md`.

Cut-specific contracts remain local records of the assumptions and acceptance tests for their cuts; they do not override project-wide rules.

See also:

- `ABSOLUTE-GROUND-CONTRACT.md` for the accepted grounding cut;
- `A2-A3-A4-ATTACK.md` for its philosophical attack surface;
- `DESIGN-CONTRACT.md` for the historical CUT 1 design contract.

Status: **FORMAL LABORATORY — ABSOLUTE-GROUND-1 ON MAIN**.

License: MIT, copyright 2026 A. M. Thorn.
