# DESIGN CONTRACT - TOTALITY-EXTERNALITY-1

Status: **NON-CANONICAL PRE-PROMOTION CONTRACT**.

This contract is the authoritative preregistration for the restacked `TOTALITY-EXTERNALITY-1` cut against protected `main` after `TOTALITY-REGRESS-1`.

The original organic branch contract is historical only. Its contract-before-proof ordering could not be independently reconstructed from the available repository interface, so this restack began from a fresh contract committed before the restacked Lean implementation.

**Amendment A1.** Semantic review after the first green comparison run found that the original R3 criterion was insufficient: with `explainsFact` kept primitive, one model satisfying `E_expl` while old E fails does not by itself establish a logical weakening. This amendment is committed before the additional bridge-order tests implementing the corrected criterion below. No already-proved main theorem depends on the erroneous weakening claim.

## 1. Exact problem inherited from TOTALITY-REGRESS-1

The accepted totality theorem uses:

```text
F4  actual non-necessary facts have an entity-ground
E   any ground of the totality fact lies outside the represented regress
C   every actual non-necessary entity lies inside the represented totality
```

and concludes:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and ActualGroundsFact(a, totality)
  and not inside(a)
```

The inferential roles are not symmetric. The `not inside(a)` clause is E instantiated at the witness supplied by F4. The genuinely additional step is modal: if that external witness were non-necessary, C would place it back inside the represented totality, contradicting E. Thus C forces the witness to be necessary.

The accepted independence suite proves that F4, E, and C are non-redundant. It does not show that they are equally distant from the conclusion. This cut attacks E and the role structure surrounding it.

## 2. Role split

Introduce two primitive relations:

```text
constitutesFact
explainsFact
```

with intended bookkeeping readings:

```text
constitutesFact  internal or constitutive support for a fact
explainsFact     a source registered as answering why the fact obtains
```

The formal layer must not define either relation in terms of the other.

The word `explains` is only a typed relation label in this cut. No definition may silently include adequacy, completeness, non-circularity, sufficient reason, or any other normative success condition. Those commitments, if needed, must be explicit later premises.

R1 and R2 below therefore establish semantic non-identification only. They do not constitute a philosophical theory of explanation.

## 3. Generic F4 and explanatory EF4

The accepted fact-level sufficient-ground principle is:

```text
F4(p):
ActualFact(p) and not NecessaryFact(p)
->
DerivedFact(p)
```

where `DerivedFact` uses generic `groundsFact`.

The proposed explanation-specific principle is:

```text
EF4(p):
ActualFact(p) and not NecessaryFact(p)
->
ExplainedFact(p)
```

where `ExplainedFact` uses `explainsFact`.

At the primitive-language level, neither relation contains the other. The cut must therefore test both directions:

```text
R4  F4 holds and EF4 fails
R5  EF4 holds and F4 fails
```

If both elaborate, F4 and EF4 are independent in the unbridged semantics.

### Optional bridge G

Define separately:

```text
G = ExplanationImpliesGrounding:
ActualExplainsFact(a,p) -> ActualGroundsFact(a,p)
```

G is not definitional and is not part of the main theorem package unless explicitly passed.

Under G, Lean may prove:

```text
EF4 -> F4
```

To determine whether this implication is strict, the R4 model must also satisfy G. If it does, then:

```text
G + F4 does not imply EF4
G + EF4 implies F4
```

so EF4 is strictly stronger than F4 relative to G.

This is the exact test for the premise-strengthening trap. If established, the cut must state plainly that weakening externality while replacing F4 with EF4 is not a net premise weakening.

## 4. Old E and explanatory E_expl

Old E is:

```text
E:
ActualGroundsFact(a,totality)
->
not inside(a)
```

The role-specific premise is:

```text
E_expl:
ActualExplainsFact(a,totality)
->
not inside(a)
```

Because `explainsFact` is primitive, E and E_expl are not automatically ordered.

### Unbridged comparison

The cut must test both directions:

```text
R3a  E_expl holds and E fails
R3b  E holds and E_expl fails
```

If both elaborate, E and E_expl are independent in the unbridged semantics.

### Bridged comparison

Under G, every explainer is a generic fact ground, so Lean may prove:

```text
G + E -> E_expl
```

The R3a model must also satisfy G. If so, it witnesses strict weakening relative to G:

```text
G + E implies E_expl
but
G + E_expl does not imply E
```

Only in this explicitly bridged sense may the cut describe E_expl as weaker than old E.

## 5. Mandatory comparison suite

The comparison layer must elaborate before promotion of the main theorem layer.

### R1 - constitution without explanation

```text
ActualConstitutesFact(a,p)
not ActualExplainsFact(a,p)
```

### R2 - explanation without constitution

```text
ActualExplainsFact(a,p)
not ActualConstitutesFact(a,p)
```

### R3a - E_expl without E

Same totality model:

```text
G
E_expl
not E
```

### R3b - E without E_expl

A separate unbridged model:

```text
E
not E_expl
```

This demonstrates that no weakening relation exists without G.

### R4 - F4 without EF4

```text
G
F4
not EF4
```

### R5 - EF4 without F4

```text
EF4
not F4
```

R4 and R5 establish primitive independence. R4 together with the theorem `G + EF4 -> F4` establishes strict strengthening of EF4 relative to G.

No documentation may describe the total premise package as weaker merely because E is factorized.

## 6. First theorem layer: explicit E_expl

The first theorem layer may use:

```text
EF4 + E_expl + C
```

and prove:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and ActualExplainsFact(a,totality)
  and not inside(a)
```

This is a role-separated analogue of the accepted totality theorem. It is conditional on EF4, not on generic F4.

The `not inside(a)` clause is still supplied by E_expl in this layer. Only necessity of the witness is derived from C.

## 7. Deep theorem layer: derive E_expl

The deeper target removes primitive E_expl.

### S - scope coverage

```text
if a explains the totality fact,
then a explains every entity inside the claimed explanatory scope
```

### I - explanatory irreflexivity

```text
no actual entity explains itself
```

Then Lean must prove directly:

```text
S + I -> E_expl
```

If an explainer were inside the represented totality, S would make it explain itself and I would reject that self-relation.

This theorem concerns the chosen primitive explanation relation. It does not prove that this relation is metaphysically adequate.

## 8. Deep theorem boundary

The deepest theorem allowed in this cut has exactly the substantive package:

```text
EF4 + S + I + C
```

and conclusion:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and ActualExplainsFact(a,totality)
  and not inside(a)
```

Negative boundary:

```text
NO A2 / WellFounded
NO A3 / common_ground
NO old E
NO ExternalRegressTotalityAxioms
NO primitive E_expl in the deep theorem
NO ExternalExplanationAxioms conversion inside the deep theorem file
NO A6-A8
NO God predicate
NO Goedel-Scott premise
NO TWIST-J dependency
```

The proof should derive necessity directly from S + I + C and derive outside-ness directly from S + I. It must not obtain the result by packaging those premises into an externality record and calling an earlier theorem.

## 9. Independence of S and I

### Without S

I and C may hold while an internal contingent entity is registered as explaining the totality fact without covering members in its alleged scope. Pure contingency must remain satisfiable.

### Without I

S and C may hold because an internal contingent explainer is allowed to explain itself. Pure contingency must remain satisfiable.

These models establish that S and I are non-redundant within the deep package.

## 10. Boundary audits

### B1 - explicit-E_expl theorem

A wrapper must elaborate from `CompleteExplanationAxioms` and contain no A2 or A3 record.

### B2 - deep theorem

A wrapper must elaborate from `CompleteScopedExplanationAxioms` alone.

In addition to the type audit, CI must statically reject the following names in the deep theorem source:

```text
ExternalRegressTotalityAxioms
ExternalExplanationAxioms
FoundationAxioms
StructuralAxioms
NecessaryExistenceAxioms
NecessaryGroundAxioms
grounding_wellFounded
common_ground
```

The static check exists because a clean public signature alone would not detect an internal conversion through a forbidden stronger record.

## 11. Acceptance tests

The cut is acceptable only if:

1. the fresh restack contract was committed before the restacked Lean implementation;
2. Amendment A1 precedes the new bridge-order tests R3b and the bridged comparison theorems;
3. whole project builds under the pinned Lean toolchain;
4. no `sorry` or `sorryAx` occurs;
5. R1 and R2 elaborate;
6. R3a elaborates with G;
7. R3b elaborates without G;
8. Lean proves `G + E -> E_expl`;
9. documentation calls E_expl weaker than E only relative to G;
10. R4 elaborates with G;
11. R5 elaborates;
12. Lean proves `G + EF4 -> F4`;
13. documentation records F4/EF4 independence without G and strict EF4 strengthening relative to G;
14. the explicit-E_expl theorem has no A2 or A3 dependency;
15. `S + I -> E_expl` elaborates;
16. no-S and no-I countermodels elaborate;
17. the deep theorem contains no A2, A3, old E, primitive E_expl, or externality-record conversion;
18. central, scope, type-boundary, and static boundary audits pass;
19. no theological interpretation enters the proof core.

## 12. Interpretation boundary

A successful cut will not prove that explanation is metaphysically fundamental or that every contingent fact has an adequate explanation.

Its strongest conditional result is:

```text
EF4 + S + I + C
->
pure contingency fails
```

The premise audit must remain visible:

```text
unbridged:
  F4 and EF4 are independent
  E and E_expl are independent

with G = ExplanationImpliesGrounding:
  EF4 is stronger than F4
  E_expl is weaker than E
```

Thus the cut may successfully factor externality without producing a globally weaker metaphysical package. That is a legitimate result, not a failure.

Whether EF4, G, S, or I is philosophically defensible remains a human question and the explicit attack surface for later cuts.
