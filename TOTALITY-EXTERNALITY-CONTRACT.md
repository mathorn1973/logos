# DESIGN CONTRACT — TOTALITY-EXTERNALITY-1

Status: **NON-CANONICAL PRE-PROOF CONTRACT**.

This contract is the authoritative preregistration for the restacked `TOTALITY-EXTERNALITY-1` cut. It is written against the current protected `main` after `TOTALITY-REGRESS-1` and its documentation closure.

The earlier organic branch contract is retained only as historical work. Its contract-before-proof ordering could not be independently reconstructed from the available repository interface, so no theorem from that branch is accepted merely because it already elaborates.

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

The inferential roles are not symmetric.

The clause

```text
not inside(a)
```

is inherited directly from E for the witness produced by F4. The genuinely derived step is that this external witness must be necessary: if it were non-necessary, C would place it back inside the totality and contradict E.

Therefore the independence models for F4/E/C establish non-redundancy. They do **not** establish that each premise is equally distant from the conclusion. This cut specifically attacks that fact about E.

## 2. Role split

Introduce two relations over facts:

```text
constitutesFact
explainsFact
```

with the intended bookkeeping distinction:

```text
constitutesFact  internal or mereological support for a fact
explainsFact     a registered explanatory source for why the fact obtains
```

These are separate primitives. The formal layer must not define either one in terms of the other.

Crucially, the word `explains` in this cut is only a typed relation name. No definition may silently build in adequacy, completeness, non-circularity, sufficient reason, or any other normative success condition. Such conditions, if needed, must appear later as explicit premises.

The mere existence of models separating the two relations is therefore only a semantic non-identification test. It is not by itself a philosophical theory of explanation.

## 3. Old and new sufficient-ground principles must be compared explicitly

The accepted fact-level principle is:

```text
F4(p):
ActualFact(p) and not NecessaryFact(p)
->
DerivedFact(p)
```

where `DerivedFact` uses the old generic `groundsFact` relation.

The proposed explanatory principle is:

```text
EF4(p):
ActualFact(p) and not NecessaryFact(p)
->
ExplainedFact(p)
```

where `ExplainedFact` uses the new `explainsFact` relation.

No theorem or documentation may call EF4 a weakening, refinement, or decomposition of F4 merely because E becomes narrower. At the primitive-language level F4 and EF4 are different commitments.

Before any main theorem is accepted, the model suite must determine their relation.

Required:

```text
model F4-not-EF4
model EF4-not-F4
```

If both models elaborate, F4 and EF4 are independent axes in the current semantics. The cut must then say so explicitly. Any later bridge such as

```text
ExplanationImpliesGrounding
```

is a new premise and must be typed and audited separately.

## 4. Old and revised externality

Old E is:

```text
E:
ActualGroundsFact(a, totality)
->
not inside(a)
```

The proposed role-specific premise is:

```text
E_expl:
ActualExplainsFact(a, totality)
->
not inside(a)
```

The cut may call `E_expl` weaker than old E only after exhibiting a model in which:

```text
E_expl holds
E fails
```

while the same totality structure is in use.

The reason for the distinction must be visible in the model: an internal member may constitute or generically ground the totality fact without being its explanatory source.

## 5. Mandatory pre-theorem model suite

The following tests are preregistered and must be implemented before the main proof layer is promoted.

### R1 — constitutive support without explanation

A model with some `a,p` such that:

```text
ActualConstitutesFact(a,p)
not ActualExplainsFact(a,p)
```

### R2 — explanation without constitutive support

A model with some `a,p` such that:

```text
ActualExplainsFact(a,p)
not ActualConstitutesFact(a,p)
```

R1 and R2 establish only that the two relation symbols are not definitionally collapsed.

### R3 — revised externality is genuinely weaker than old E

A totality model satisfying:

```text
E_expl
not E
```

This is the required weakening witness for the externality axis.

### R4 — old F4 does not imply EF4

A model satisfying:

```text
F4
not EF4
```

This detects the exact trap in which E is weakened while the sufficient-ground premise is silently strengthened or replaced.

### R5 — EF4 does not imply old F4

A model satisfying:

```text
EF4
not F4
```

If R4 and R5 both elaborate, the formal result is independence, not premise reduction.

No main theorem may be described as using a strictly weaker total premise package unless these comparison tests justify that claim.

## 6. First theorem layer: E_expl as an explicit premise

Only after R1–R5, the first theorem layer may use:

```text
EF4
E_expl
C
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

This theorem is a role-separated analogue of the accepted totality theorem.

It must **not** be advertised as a theorem from F4. It is conditional on EF4 unless an explicit bridge from F4 to EF4 is separately supplied.

## 7. Second theorem layer: derive E_expl instead of assuming it

The deeper target is to remove primitive `E_expl` and derive it from lower explanatory principles.

### S — scope coverage

```text
if a explains the totality fact,
then a explains every entity inside the claimed explanatory scope
```

### I — explanatory irreflexivity

```text
no actual entity explains itself
```

Then:

```text
S + I -> E_expl
```

because an explainer located inside the totality would, by S, explain itself, contradicting I.

This factorization is a theorem about the chosen explanatory relation. It does not retroactively establish that the relation is an adequate metaphysical explanation relation.

## 8. Main deep theorem boundary

The deepest theorem allowed in this cut has the premise package:

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

Required negative boundary:

```text
NO A2 / WellFounded
NO A3 / common_ground
NO old E
NO ExternalRegressTotalityAxioms
NO primitive E_expl in the deepest theorem
NO creation/transcendence A6-A8
NO God predicate
NO Gödel–Scott premise
NO TWIST-J dependency
```

## 9. Independence of S and I

### Without S

Irreflexivity may hold while an internal contingent entity is labelled as explaining the totality fact without explaining the members in its alleged scope. Pure contingency must remain satisfiable.

### Without I

Scope coverage may hold only because an internal contingent explainer is allowed to explain itself. Pure contingency must remain satisfiable.

These models establish that S and I are not redundant within the derived-externality package.

## 10. Boundary audit requirements

The dedicated boundary audit must pin at least two theorem signatures.

### B1 — role-separated explicit-externality theorem

It may depend on the role-specific records, but must contain no A2 or A3.

### B2 — deepest derived-externality theorem

A wrapper must elaborate from the new scope package alone and must not accept or construct:

```text
ExternalRegressTotalityAxioms
ExternalExplanationAxioms
```

or any A2/A3 record.

The purpose of B2 is to catch exactly the regression in which the old externality premise is accidentally reintroduced through a conversion helper.

## 11. Acceptance tests

The cut is acceptable only if all of the following hold:

1. this contract is committed before the restacked Lean implementation;
2. whole project builds under the pinned Lean toolchain;
3. no `sorry` or `sorryAx` occurs;
4. R1 constitutive-without-explanation elaborates;
5. R2 explanation-without-constitution elaborates;
6. R3 `E_expl` holds while old E fails;
7. R4 F4 holds while EF4 fails;
8. R5 EF4 holds while F4 fails;
9. documentation classifies the F4/EF4 relation exactly as established by R4/R5;
10. the explicit-E_expl theorem has no A2 or A3 dependency;
11. `S + I -> E_expl` elaborates;
12. no-S and no-I countermodels elaborate;
13. the deepest theorem contains no A2, A3, old E, or primitive E_expl premise;
14. the boundary audit cannot obtain the deepest theorem through `ExternalRegressTotalityAxioms` or `ExternalExplanationAxioms`;
15. central, scope, and dedicated boundary audits pass;
16. no theological interpretation enters the proof core.

## 12. Interpretation boundary

A successful cut will not prove that explanation is metaphysically fundamental or that every contingent fact has an adequate explanation.

At most it will establish this conditional map:

```text
if EF4 is accepted for the typed explanation relation,
and if that relation covers the totality scope,
and if it is irreflexive for the relevant source,
and if the totality covers every non-necessary actual entity,
then pure contingency fails.
```

Whether EF4, S, or I is philosophically adequate remains a human question and is the explicit attack surface for later cuts.
