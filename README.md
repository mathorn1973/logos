# LOGOS

A formal laboratory for ontology, modal logic, and computational philosophy in Lean.

LOGOS does not assert theological conclusions unconditionally. Every theorem is relative to explicit definitions, assumptions, semantics, and frame conditions. Lean checks consequence; human judgment remains responsible for the meaning and truth of the starting commitments.

## Accepted main line

`main` currently contains ten accepted formal cuts:

1. `modal-foundation-1` - Kripke semantics for necessity, possibility, contingency, and standard modal principles under exact frame hypotheses;
2. `finite-countermodels-2` - explicit finite frames, pointed refutations, and a genuine contingency witness;
3. `absolute-ground-1` - a grounding language, explicit A0-A8 assumption records, the minimal necessary-ground theorem, and independence/countermodels delimiting its assumptions;
4. `totality-regress-1` - a separate fact carrier and an A2-free totality route showing that pure contingency is impossible under explicit fact-sufficient-ground, externality, and completeness commitments;
5. `totality-externality-1` - a role split between constitution and explanation, a premise-order audit for F4/EF4 and E/E_expl, and a derived-externality theorem from explanatory scope plus irreflexivity;
6. `self-explanation-1` - reduction of explanatory irreflexivity first to contingent propriety and then to a local adequacy condition on the totality explanation alone;
7. `fact-sufficient-explanation-1` - removal of EF4 from the core, and the resulting three-way fork in which a contingent explanatory absolute is a live option;
8. `contingent-absolute-1` - the modal reading of that option, and the recorded finding that deriving necessity from explanatory ultimacy is equivalent to local EF4;
9. `grounded-modality-1` - modal conditions as a carrier separate from entities and explanatory sources, with the recorded finding that the axis does not close the fork;
10. `carrier-schema-1` - the closure argument stated for an arbitrary carrier, with the accepted route shown to be an instance of it.

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

## Where the explanation line ended

Cuts 6 to 10 took the totality route as far as the present language allows. The outcome is a mapped fork, not a closure, and two attempts at closing it are recorded as failures rather than removed.

EF4 is no longer a premise of the core. `TotalityExplanationCore` contains only source actuality, local explanatory adequacy and completeness, and asserts no principle that an explanation must exist. From it Lean proves:

```text
NecessaryFact(totality)
OR
an actual necessary explanatory source explains the totality fact
OR
the totality fact is a contingent explanatory absolute:
  actual, non-necessary, and unexplained
```

The third disjunct is the surviving opponent position. Two routes to removing it were tried:

- `contingent-absolute-1` tested the claim that an explanatorily ultimate fact must be necessary. At the designated actual fact that claim is provably equivalent to local EF4. It is not an independent route around EF4; it is EF4 restated in modal-stability form. Any future argument from ultimacy to necessity must add genuinely new structure rather than rename the old premise.
- `grounded-modality-1` tested whether refusing to identify raw Kripke accessibility with metaphysically licensed possibility closes the position. It does not. The cut's own `ConditionedBrute` model satisfies no-brute-modality together with an unexplained, non-necessary totality fact. The cut's main implication also partitions necessity rather than deriving it: no-brute-modality together with modal unconditionedness is equivalent to actuality together with necessity.

`carrier-schema-1` then answers the general form of the worry those two cuts raise. The engine of the accepted route consults only five predicates of its sources, so it can be stated for an arbitrary carrier:

```text
escape_requires_exemption
    K.Explains a -> not K.Necessary a -> not ScopeClosureAxioms K
```

A contingent item can explain the target only at a carrier exempted from completeness, scope or adequacy. Relocating the unexplained item onto a fresh carrier therefore never dissolves the fork. Three one-item countermodels show each of the three conditions is separately load-bearing, and `TotalityExplanationCore` is proved to be an instance of the schema rather than an analogy to it.

The open question is consequently no longer "can the unexplained item always be moved". It is: for a proposed carrier, which condition is it exempt from, and is that exemption principled or merely stipulated.

## Current research frontier

One research cut is open. It is not on `main` and nothing in it is accepted.

```text
#16  route-seam-1  -> main
```

It relates the two accepted routes to each other and asks whether the totality route's necessary explanatory source is ungrounded. Branch topology and promotion order are recorded in `STATUS.md`.

Beyond it the remaining work on the explanation line is philosophical rather than formal. The two judgments the machine has isolated and cannot settle are whether an identity citation can count as an adequate explanation of contingent existence, and whether exempting a carrier from completeness, scope or adequacy can ever be principled.

Goedel-Scott is a separate formal branch of the LOGOS program, not a step in the grounding/totality sequence. TWIST-J is likewise not a dependency of the general ontology core.

## Project-wide rules

Repository-wide claim typing, import firewall, cut topology, audit requirements, and the mandatory post-merge documentation closure rule live in `PROJECT-RULES.md`.

Cut-specific contracts remain local records of the assumptions and acceptance tests for their cuts; they do not override project-wide rules.

See also:

- `ABSOLUTE-GROUND-CONTRACT.md` for the accepted foundation route;
- `TOTALITY-REGRESS-CONTRACT.md` for the accepted totality route;
- `TOTALITY-EXTERNALITY-CONTRACT.md` for the accepted externality/premise-order cut;
- `SELF-EXPLANATION-CONTRACT.md`, `FACT-SUFFICIENT-EXPLANATION-CONTRACT.md`, `CONTINGENT-ABSOLUTE-CONTRACT.md`, `GROUNDED-MODALITY-CONTRACT.md` and `CARRIER-SCHEMA-CONTRACT.md` for the accepted explanation line;
- `A2-A3-A4-ATTACK.md` for the foundation route's philosophical attack surface;
- `DESIGN-CONTRACT.md` for the historical CUT 1 design contract.

Status: **FORMAL LABORATORY - EXPLANATION LINE ON MAIN**.

License: MIT, copyright 2026 A. M. Thorn.
