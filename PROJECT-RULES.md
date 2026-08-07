# LOGOS PROJECT RULES

Status: **PROJECT-WIDE GOVERNANCE**.

These rules govern repository structure, claim typing, dependency direction, review, and promotion. They are not metaphysical axioms and do not belong to any one formal cut.

## 1. Conditionality

LOGOS does not assert philosophical or theological conclusions unconditionally. Every theorem must expose the definitions, semantics, frame conditions, carrier assumptions, and axiom records on which it depends.

Lean verifies consequence. Human judgment remains responsible for whether the formal language captures the intended concept and whether the premises are true of reality.

## 2. Claim typing

Every substantial claim belongs to one of these classes:

```text
formal definition
formal assumption
proved theorem
countermodel
consistency witness
open conjecture
bridge
interpretation
confession
metaphor
```

A bridge, interpretation, confession, or metaphor is never a formal premise merely by appearing in the repository.

## 3. Import firewall

The allowed dependency direction is:

```text
Logic
  ↓
Ontology language
  ↓
Formal systems / axiom records
  ↓
Theorems and countermodels
  ↓
Interpretation bridges
  ↓
Essays and exposition
```

Forbidden reverse dependencies include:

```text
Essays -> Theorems
Interpretation -> Logic
TWIST-J bridge -> General ontology
Gödel–Scott branch -> Grounding core, unless a later cut explicitly declares and reviews such a bridge
Metaphor -> Formal premise
Confession -> Formal premise
```

General ontology should remain independent of TWIST-J and of any specific theological formalization.

## 4. Research lines

Git stack order is not automatically logical dependency.

Current major research lines are:

```text
MODAL / GENERAL LOGIC
GROUNDING / ABSOLUTE-GROUND
TOTALITY / EXPLANATION
GÖDEL–SCOTT
OPTIONAL INTERPRETATION BRIDGES
```

Gödel–Scott is a separate formal branch. It is not a mandatory continuation of the grounding/totality sequence.

Before restacking or merging a research cut, inspect actual Lean imports and theorem signatures. If a cut does not depend on another cut, prefer rebasing it directly on the weakest accepted `main` state that supplies its real dependencies.

## 5. No hidden strengthening

Theorem signatures must use the weakest assumption record actually needed by the proof.

When a stronger record extends a weaker one, the load-bearing theorem should be stated against the weaker record whenever possible. Stronger extensions may have separate theorems, but may not silently become premises of the core result.

For `absolute-ground-1`, this means in particular:

```text
NecessaryExistenceAxioms = A0 + A1 + A2 + A4 + A5
```

and the minimal necessity theorem must not require A3 or A6–A8.

## 6. Audit requirements

Trusted cuts must satisfy all applicable checks:

```text
whole-project Lean build
no sorry / sorryAx
#print axioms audit
exact theorem-boundary audit for load-bearing signatures
countermodels for substantive independence claims where practical
```

A documentation statement that an assumption is unused is not enough when the boundary can be pinned by Lean.

## 7. Cut contracts

Each research cut may have a cut-specific design contract describing its semantic language, explicit commitments, intended theorems, countermodels, and acceptance tests.

Cut contracts are local records. They do not define project-wide branch topology or override this file.

Historical contracts may remain in the repository, but must be marked as historical when their planning sections are superseded.

## 8. Merge closure rule

A cut is not operationally complete at the instant its code PR merges.

The merge operation is complete only after an immediate closure update brings repository truth into sync with `main`:

```text
README: branch/in-review wording -> accepted/on-main wording
STATUS: current branch/base -> actual main state
contracts: obsolete planning language marked historical or corrected
open stack: bases and dependency notes refreshed
```

This closure should be part of the same promotion session and should not be deferred to a later research cut.

When practical, CI should enforce machine-checkable boundaries in the same closure update.

## 9. Protected-main discipline

Do not weaken branch protection to work around infrastructure failures. If CI fails before repository checkout or Lean execution, record the incident and retry without altering logical source.

A cut is promoted only after the required protected check succeeds on the exact head to be merged.

## 10. Interpretation discipline

No formal theorem should be named or documented in a way that silently identifies a mathematical object with God, creation, revelation, freedom, consciousness, or a physical theory unless the identification is itself an explicit bridge or interpretation layer.

In particular:

```text
necessary ungrounded entity != God by logic alone
mathematical grounding != temporal causation
created-order predicate != full doctrine of creatio ex nihilo
Kripke accessibility != metaphysical possibility without an explicit bridge
```

## 11. Human responsibility

Formal success closes derivability questions, not metaphysical truth questions. When Lean isolates a fork between explicit premises or countermodels, the next task is philosophical analysis of those premises, not relabeling the theorem as unconditional fact.
