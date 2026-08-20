# STATUS

```text
PROGRAM     LOGOS
STATE       FORMAL LABORATORY
MAIN        modal-foundation-1 + finite-countermodels-2 + absolute-ground-1 + totality-regress-1 + totality-externality-1
FOCUS       self-explanation-1; live premises now include EF4 and adequacy of contingent self-citation
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

No A2/well-foundedness or A3/unity premise occurs in this theorem. This route does not prove that the necessary witness is ungrounded.

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

## Current live philosophical premises

The machine has not established these as true of reality.

### EF4 / sufficient explanation

The totality/explanation line now requires the explanation-specific principle that an actual non-necessary fact has an explanatory source. Under G this is strictly stronger than the earlier generic fact-grounding F4.

The next cuts must therefore attack EF4 rather than silently treating it as inherited from F4.

### Adequacy of contingent self-citation

The accepted deep theorem uses explanatory irreflexivity I. The next cut `self-explanation-1` is tasked with reducing this as far as possible and isolating the narrower human judgment:

> Can an identity citation `P because P` count as an adequate complete explanation of why contingent P obtains?

This is a normative adequacy question, not a logical contradiction.

## Interpretation firewall

The accepted grounding/totality core contains no formal `God` predicate and no theorem identifying a formal root, fact, external ground, or explanatory source with God. It must not depend on Goedel-Scott predicates, positive divine attributes, revelation or confessional premises, TWIST-J physics, essay prose, metaphor, or a hidden global project axiom.

Goedel-Scott remains a separate research branch.

## Open stack

Six research cuts are open beyond the accepted externality layer.

```text
#7   self-explanation-1             -> main
#8   fact-sufficient-explanation-1  -> #7
#9   contingent-absolute-1          -> #8
#10  grounded-modality-1            -> #9
#14  carrier-schema-1               -> #8
#16  route-seam-1                   -> main
```

The `#7` to `#10` chain is a real dependency order at current PR granularity, because each later cut imports types or theorems introduced by the preceding one. Promotion along that chain should remain sequential unless the cuts are deliberately repartitioned.

`carrier-schema-1` is not a further floor on that chain. Its only real dependency is `TotalityExplanationCore`, so under PROJECT-RULES section 4 it is based on `#8` and is a sibling of `#9`, not a successor to `#10`. It may be promoted after `#8` independently of `#9` and `#10`.

`route-seam-1` is based directly on `main` and imports nothing from any open cut. It may be promoted at any time, in any order relative to the chain.

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
