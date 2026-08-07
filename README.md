# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, assumptions, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

## Accepted main line

`main` currently contains four accepted formal cuts:

1. `modal-foundation-1` — Kripke semantics for necessity, possibility, contingency, and standard modal principles under exact frame hypotheses;
2. `finite-countermodels-2` — explicit finite frames, pointed refutations, and a genuine contingency witness;
3. `absolute-ground-1` — a grounding language, explicit A0–A8 assumption records, the minimal necessary-ground theorem, and independence/countermodels delimiting its assumptions;
4. `totality-regress-1` — a separate fact carrier and an A2-free totality route showing that pure contingency is impossible under explicit fact-sufficient-ground, externality, and completeness commitments.

The load-bearing grounding theorem remains:

```text
A0 + A1 + A2 + A4 + A5
        ->
there exists some actual ungrounded entity that exists necessarily
```

Formally, `exists_necessary_ungrounded` requires `NecessaryExistenceAxioms`. That record contains A0–A2 and A4–A5. It contains neither A3 nor the later transcendence/creation assumptions A6–A8.

A3 is separate and is used for uniqueness and universal grounding ancestry. A6–A8 are explicit extensions concerning created-order transcendence and essential aseity; they are not premises of the minimal existence theorem.

The accepted totality route is weaker in conclusion and different in premises:

```text
fact F4 + externality E + completeness C
        ->
NecessaryFact(totality)
OR
an actual necessary entity grounds the totality fact from outside the regress
```

It does not prove that the necessary witness is ungrounded, and it does not eliminate A2 from the stronger foundation theorem. Instead it shows that a proposed totality of contingent reality cannot remain contingent all the way down and as a whole under F4+E+C.

The accepted source also contains explicit countermodels showing that pure contingency survives if any one of F4, E, or C is removed. `Logos/CoreBoundaryAudit.lean` pins both the minimal foundation theorem and the totality theorem to their exact premise records.

## Current research frontier

The next open cut is `totality-externality-1`, which analyzes the roles hidden inside the externality premise rather than treating E as an unanalyzed block. Later stacked cuts address self-explanation, sufficient explanation, contingent absolutes, and grounded modality.

Gödel–Scott is a separate formal branch of the LOGOS program, not a step in the grounding/totality sequence. TWIST-J is likewise not a dependency of the general ontology core.

## Project-wide rules

Repository-wide claim typing, import firewall, cut topology, audit requirements, and the mandatory post-merge documentation closure rule live in `PROJECT-RULES.md`.

Cut-specific contracts remain local records of the assumptions and acceptance tests for their cuts; they do not override project-wide rules.

See also:

- `ABSOLUTE-GROUND-CONTRACT.md` for the accepted foundation route;
- `TOTALITY-REGRESS-CONTRACT.md` for the accepted totality route;
- `A2-A3-A4-ATTACK.md` for the foundation route's philosophical attack surface;
- `DESIGN-CONTRACT.md` for the historical CUT 1 design contract.

Status: **FORMAL LABORATORY — TOTALITY-REGRESS-1 ON MAIN**.

License: MIT, copyright 2026 A. M. Thorn.
