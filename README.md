# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, assumptions, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

## Accepted main line

`main` currently contains five accepted formal cuts:

1. `modal-foundation-1` - Kripke semantics for necessity, possibility, contingency, and standard modal principles under exact frame hypotheses;
2. `finite-countermodels-2` - explicit finite frames, pointed refutations, and a genuine contingency witness;
3. `absolute-ground-1` - a grounding language, explicit A0-A8 assumption records, the minimal necessary-ground theorem, and independence/countermodels delimiting its assumptions;
4. `totality-regress-1` - a separate fact carrier and an A2-free totality route showing that pure contingency is impossible under explicit fact-sufficient-ground, externality, and completeness commitments;
5. `totality-externality-1` - a role split between constitution and explanation, a premise-order audit for F4/EF4 and E/E_expl, and a derived-externality theorem from explanatory scope plus irreflexivity.

The load-bearing grounding theorem remains:

```text
A0 + A1 + A2 + A4 + A5
        ->
there exists some actual ungrounded entity that exists necessarily
```

Formally, `exists_necessary_ungrounded` requires `NecessaryExistenceAxioms`. That record contains A0-A2 and A4-A5. It contains neither A3 nor the later transcendence/creation assumptions A6-A8.

A3 is separate and is used for uniqueness and universal grounding ancestry. A6-A8 are explicit extensions concerning created-order transcendence and essential aseity; they are not premises of the minimal existence theorem.

The accepted totality route has a different conclusion and premise package:

```text
fact F4 + externality E + completeness C
        ->
NecessaryFact(totality)
OR
an actual necessary entity grounds the totality fact from outside the regress
```

It does not prove that the necessary witness is ungrounded, and it does not eliminate A2 from the stronger foundation theorem.

`totality-externality-1` then audits the externality route more finely. It introduces a primitive `explainsFact` relation alongside constitutive support and distinguishes:

```text
F4     generic fact grounding of actual non-necessary facts
EF4    explanatory grounding of actual non-necessary facts
E      every generic ground of the totality fact is outside
E_expl every explanatory source of the totality fact is outside
```

The accepted premise-order result is:

```text
without G = ExplanationImpliesGrounding:
  F4 and EF4 are independent
  E and E_expl are independent

with G:
  EF4 is strictly stronger than F4
  E_expl is strictly weaker than E
```

Therefore the cut is not a proof that the total metaphysical premise package became weaker. It is a factorization and premise-accounting result: externality can be weakened and then derived from lower explanatory conditions, but the sufficient-ground commitment moves from generic F4 to stronger EF4 when explanation is required to imply grounding.

The deepest accepted theorem is conditional on:

```text
EF4 + S + I + C
```

where `S` is explanatory scope coverage and `I` is explanatory irreflexivity. From this package Lean proves either a necessary totality fact or an actual necessary explanatory source outside the represented regress. The deep theorem uses no A2, no A3, no old E, and no primitive E_expl premise.

Dedicated comparison, scope, type-boundary, and static CI audits pin these boundaries.

## Current research frontier

Six research cuts are open beyond the accepted externality layer. None of them is on `main`, and nothing below is accepted.

```text
#7   self-explanation-1             -> main
#8   fact-sufficient-explanation-1  -> #7
#9   contingent-absolute-1          -> #8
#10  grounded-modality-1            -> #9
#14  carrier-schema-1               -> #8
#16  route-seam-1                   -> main
```

`#7` reduces explanatory irreflexivity to a local adequacy condition, leaving the narrow question whether an identity citation such as `P because P` can count as an adequate explanation of contingent existence within a claimed complete explanation. `#8` removes the sufficient-explanation principle from the core and exposes a third disjunct, a contingent explanatory absolute. `#9` gives that disjunct a modal reading and tests whether necessity can be derived from explanatory ultimacy. `#10` separates metaphysically licensed modal variation from raw Kripke accessibility. `#14` states the closure argument for an arbitrary carrier and asks what relocating the unexplained item onto a fresh carrier costs. `#16` relates the two accepted routes to each other and asks whether the totality route's necessary explanatory source is ungrounded.

`#14` and `#16` are not further floors on the `#7` to `#10` chain. Branch topology, real dependencies and promotion order are recorded in `STATUS.md`.

Goedel-Scott is a separate formal branch of the LOGOS program, not a step in the grounding/totality sequence. TWIST-J is likewise not a dependency of the general ontology core.

## Project-wide rules

Repository-wide claim typing, import firewall, cut topology, audit requirements, and the mandatory post-merge documentation closure rule live in `PROJECT-RULES.md`.

Cut-specific contracts remain local records of the assumptions and acceptance tests for their cuts; they do not override project-wide rules.

See also:

- `ABSOLUTE-GROUND-CONTRACT.md` for the accepted foundation route;
- `TOTALITY-REGRESS-CONTRACT.md` for the accepted totality route;
- `TOTALITY-EXTERNALITY-CONTRACT.md` for the accepted externality/premise-order cut;
- `A2-A3-A4-ATTACK.md` for the foundation route's philosophical attack surface;
- `DESIGN-CONTRACT.md` for the historical CUT 1 design contract.

Status: **FORMAL LABORATORY - TOTALITY-EXTERNALITY-1 ON MAIN**.

License: MIT, copyright 2026 A. M. Thorn.
