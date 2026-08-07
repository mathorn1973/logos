# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, axioms, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

The first research cut, `modal-foundation-1`, builds a small Kripke-semantic core for necessity, possibility, contingency, and later analysis of modal collapse.

The second cut, `finite-countermodels-2`, adds explicit finite frames and pointed refutations. It checks not only that modal principles hold under their named hypotheses, but also that concrete formulas fail when the relevant frame condition is absent.

## Current boundary

The current stacked cuts contain only:

- Kripke frames and world-indexed propositions;
- validity and satisfiability;
- necessity, possibility, and contingency;
- standard frame conditions;
- modal principles K, T, B, 4, and 5 under their exact hypotheses;
- reusable formulas for T, B, 4, and 5;
- finite frames with exhaustive world lists;
- pointed countermodels for T, B, 4, and 5;
- a positive finite witness of genuine contingency;
- a minimal claim-status vocabulary for later essay and interpretation bridges.

They contain no definition of God, positivity, essence, creation, freedom, or TWIST-J. Those belong to later, separately reviewed cuts.

Status: **FORMAL LABORATORY — CUT 2 IN PREPARATION**.

License: MIT, copyright 2026 A. M. Thorn.
