# DESIGN CONTRACT - TOTALITY-EXTERNALITY-1

Status: **ACCEPTED CUT CONTRACT - ON MAIN**.

This contract records the accepted `TOTALITY-EXTERNALITY-1` cut after promotion to protected `main`.

The restack was rebuilt against accepted `TOTALITY-REGRESS-1`. The original organic branch contract is historical only because its contract-before-proof ordering could not be independently reconstructed. A fresh preregistration was committed before the restacked Lean implementation.

During review, Amendment A1 corrected an important premise-order mistake before promotion: with `explainsFact` primitive, a model satisfying `E_expl` while old E fails does not by itself establish that `E_expl` is weaker. The accepted cut therefore distinguishes unbridged independence from bridge-relative ordering.

## 1. Problem inherited from TOTALITY-REGRESS-1

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
  and ActualGroundsFact(a,totality)
  and not inside(a)
```

The inferential roles are asymmetric.

`not inside(a)` is supplied directly by E for the witness produced by F4. The derived step is necessity: if that witness were non-necessary, C would place it inside the represented totality, contradicting E.

The earlier F4/E/C countermodels establish non-redundancy. They do not imply that all premises are equally distant from the conclusion.

## 2. Primitive role split

The cut introduces separate primitive relations:

```text
constitutesFact
explainsFact
```

with bookkeeping readings:

```text
constitutesFact  internal or constitutive support for a fact
explainsFact     a source registered as answering why the fact obtains
```

Neither relation is defined from the other.

The word `explains` is only a typed relation label here. No definition silently includes adequacy, completeness, non-circularity, sufficient reason, or any other normative success condition.

## 3. Generic F4 and explanatory EF4

Accepted generic F4 is:

```text
F4(p):
ActualFact(p) and not NecessaryFact(p)
->
DerivedFact(p)
```

where `DerivedFact` uses generic `groundsFact`.

Explanation-specific EF4 is:

```text
EF4(p):
ActualFact(p) and not NecessaryFact(p)
->
ExplainedFact(p)
```

where `ExplainedFact` uses `explainsFact`.

The accepted comparison suite proves:

```text
without any bridge:
  F4 does not imply EF4
  EF4 does not imply F4
```

Thus F4 and EF4 are independent in the primitive semantics.

## 4. Bridge G

The cut separately defines:

```text
G = ExplanationImpliesGrounding:
ActualExplainsFact(a,p)
->
ActualGroundsFact(a,p)
```

G is not definitional and is not a premise of the deepest theorem unless explicitly passed elsewhere.

Under G, Lean proves:

```text
EF4 -> F4
```

The comparison model also proves:

```text
G + F4 does not imply EF4
```

Therefore:

```text
relative to G:
EF4 is strictly stronger than F4
```

This is a load-bearing premise-accounting result. Replacing F4 with EF4 is not a weakening if explanation is required to be a form of grounding.

## 5. Old E and explanatory E_expl

Old externality is:

```text
E:
ActualGroundsFact(a,totality)
->
not inside(a)
```

Role-specific explanatory externality is:

```text
E_expl:
ActualExplainsFact(a,totality)
->
not inside(a)
```

Without G, the accepted comparison models prove both directions of separation:

```text
E_expl with not E
E with not E_expl
```

So E and E_expl are independent in the unbridged primitive semantics.

Under G, Lean proves:

```text
E -> E_expl
```

and the mixed-role model satisfies:

```text
G
E_expl
not E
```

Therefore:

```text
relative to G:
E_expl is strictly weaker than E
```

This weakening claim is valid only with the bridge stated explicitly.

## 6. Accepted comparison suite

The promoted cut contains the following witnesses.

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

### R3a - E_expl without E under G

```text
G
E_expl
not E
```

### R3b - E without E_expl without G

```text
E
not E_expl
```

### R4 - F4 without EF4 under G

```text
G
F4
not EF4
```

### R5 - EF4 without F4 without G

```text
EF4
not F4
```

Together with the bridge theorems, these models establish the exact premise-order map rather than a verbal relabeling.

## 7. Explicit E_expl theorem layer

The first accepted theorem layer uses:

```text
EF4 + E_expl + C
```

and proves:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and ActualExplainsFact(a,totality)
  and not inside(a)
```

This theorem is conditional on EF4, not on generic F4.

`not inside(a)` is supplied directly by E_expl in this layer. Necessity of the witness is derived from C.

## 8. Derived externality layer

The deeper layer removes primitive E_expl.

### S - scope coverage

```text
if a explains the totality fact,
then a explains every entity inside the claimed explanatory scope
```

### I - explanatory irreflexivity

```text
no actual entity explains itself
```

Lean proves directly:

```text
S + I -> E_expl
```

If an explainer were inside the represented totality, S would make it explain itself and I would reject that self-relation.

## 9. Deep accepted theorem

The deepest theorem uses exactly the substantive package:

```text
EF4 + S + I + C
```

and proves:

```text
NecessaryFact(totality)
OR
exists a,
  Actual(a)
  and Necessary(a)
  and ActualExplainsFact(a,totality)
  and not inside(a)
```

The proof derives outside-ness from S + I and necessity from S + I + C.

It does not package those premises into an externality record and call an earlier theorem.

## 10. Independence of S and I

The accepted model suite also shows:

```text
without S:
  I and C can hold while pure contingency survives

without I:
  S and C can hold while pure contingency survives
```

Thus S and I are non-redundant within the deep package.

## 11. Negative boundary

The deepest theorem contains:

```text
NO A2 / WellFounded
NO A3 / common_ground
NO old E
NO ExternalRegressTotalityAxioms
NO primitive E_expl premise
NO ExternalExplanationAxioms conversion in the deep theorem source
NO A6-A8
NO God predicate
NO Goedel-Scott premise
NO TWIST-J dependency
```

This boundary is enforced both by theorem signatures and by a static CI scan of the deep theorem source.

## 12. Promotion audit record

The cut was promoted only after all of the following passed:

1. fresh contract committed before restacked Lean implementation;
2. Amendment A1 committed before the corrected bridge-order comparison layer;
3. whole project build under the pinned Lean toolchain;
4. no `sorry` or `sorryAx`;
5. R1 and R2 role-separation models;
6. R3a and R3b externality-order models;
7. theorem `G + E -> E_expl`;
8. R4 and R5 F4/EF4 models;
9. theorem `G + EF4 -> F4`;
10. explicit-E_expl theorem with no A2 or A3;
11. theorem `S + I -> E_expl`;
12. no-S and no-I countermodels;
13. deep theorem with no A2, A3, old E, primitive E_expl, or forbidden externality-record conversion;
14. central axiom audit;
15. accepted-core boundary audit;
16. dedicated premise-comparison audit;
17. scope audit;
18. totality-externality type-boundary audit;
19. static regression guard for externality and A2/A3 records;
20. no theological interpretation in the proof core.

## 13. Interpretation boundary

The accepted cut does not prove that explanation is metaphysically fundamental or that every contingent fact has an adequate explanation.

Its strongest conditional map is:

```text
EF4 + S + I + C
->
pure contingency fails
```

The premise audit remains part of the result:

```text
unbridged:
  F4 and EF4 are independent
  E and E_expl are independent

with G = ExplanationImpliesGrounding:
  EF4 is strictly stronger than F4
  E_expl is strictly weaker than E
```

Therefore `TOTALITY-EXTERNALITY-1` is a successful factorization and premise-accounting cut, not a proof that the total metaphysical premise package became strictly weaker.

The live philosophical questions move to EF4 and to the adequacy of self-explanation. Those are attacked in later cuts rather than smuggled into the meaning of `explainsFact`.
