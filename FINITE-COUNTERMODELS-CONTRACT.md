# DESIGN CONTRACT — CUT 2: FINITE FRAMES AND COUNTERMODELS

Status: **NON-CANONICAL DESIGN CONTRACT**.

This contract governs the second LOGOS cut. It extends the modal semantic core
with explicit finite frames and pointed refutations. It introduces no theology
and no ontological axiom system.

## 1. Purpose

The first cut proves that standard modal principles hold under named frame
conditions. The second cut must prove the negative half: when a condition is
absent, a concrete finite frame and valuation can make the corresponding
principle false at a designated world.

A theorem prover that only confirms intended formulas is not yet an adequate
philosophical laboratory. LOGOS must also exhibit exact failures.

## 2. Finite-frame evidence

A finite frame carries:

```lean
structure FiniteFrame where
  World : Type u
  access : World → World → Prop
  worlds : List World
  complete : ∀ w, List.Mem w worlds
```

The exhaustive list is explicit evidence of finiteness. Modal semantics still
uses only the underlying Kripke frame. Enumeration adds no accessibility edge,
valuation, or logical premise.

A pointed countermodel contains a frame, a formula, a designated world, and a
proof that the formula is false at that world.

## 3. Frozen countermodels

### T — dead-end world

```text
worlds  {only}
edges   none
value   phi(only) = false
```

At `only`, `box phi` is vacuously true and `phi` is false. Therefore
`box phi -> phi` fails. The frame is symmetric, transitive, and Euclidean, but
not reflexive or serial.

This isolates the role of reflexivity and records the danger of vacuous
necessity at a dead end.

### B — reflexive one-way preorder

```text
worlds  {source, target}
edges   source->source, source->target, target->target
value   phi(source) = true, phi(target) = false
```

At `source`, `phi` is true. At the accessible `target`, `phi` is not possible,
because `target` cannot return to `source`. Hence
`phi -> box diamond phi` fails.

The frame is reflexive, transitive, and serial, but not symmetric or Euclidean.

### 4 and 5 — reflexive symmetric path

```text
worlds  {left, center, right}
edges   every self-loop plus left<->center and center<->right
        no edge left<->right
```

The frame is reflexive, symmetric, and serial, but neither transitive nor
Euclidean.

For principle 4, use a proposition true at `left` and `center`, false at
`right`. At `left`, it is necessary, but it is not necessarily necessary.

For principle 5, use a proposition true only at `left`. At `center`, it is
possible, but at the accessible `right` it is not possible. Thus possibility is
not necessarily possible.

The same path must also witness genuine contingency at `center`: the
proposition true only at `left` is possible, and its negation is possible via
`right`.

## 4. Required machine statements

The cut must contain proofs of:

```text
deadEnd_not_reflexive
deadEnd_symmetric
deadEnd_transitive
deadEnd_euclidean
deadEnd_not_serial
deadEnd_refutes_T

arrow_reflexive
arrow_transitive
arrow_serial
arrow_not_symmetric
arrow_not_euclidean
arrow_refutes_B

path_reflexive
path_symmetric
path_serial
path_not_transitive
path_not_euclidean
path_refutes_4
path_refutes_5
path_has_contingency
```

The refutation theorems must be derived from pointed countermodels, not from an
uninterpreted assertion that validity fails.

## 5. Import boundary

The dependency direction becomes:

```text
Logic.Frame / Logic.Modal
        ↓
Logic.Principles / Logic.FrameConditions
        ↓
Logic.FiniteFrame
        ↓
Models.FiniteCountermodels
        ↓
Audit
```

This cut must not import or define:

```text
God-like
positive property
essence
necessary existence
creation
free will
essay interpretation
TWIST-J bridge
```

## 6. Acceptance conditions

The cut is acceptable only if:

1. all world lists are proved exhaustive;
2. every claimed frame property and failure elaborates;
3. each modal failure is attached to a designated world and valuation;
4. the full library builds from the pinned toolchain;
5. the explicit axiom audit reports no project axiom for every registered
   frame-property theorem, countermodel theorem, and contingency witness;
6. no unfinished proof occurs in trusted Lean source; and
7. an independent semantic review confirms that the formal relations match
   the diagrams and prose above.

## 7. Next boundary

Only after this cut survives review may LOGOS introduce the Gödel–Scott
language and package its premises as an explicit axiom record.

The next cut may define individuals, world-dependent properties, positivity,
God-likeness, essence, and necessary existence. It must not yet claim that the
Gödel–Scott conclusion has been reconstructed until each definition and axiom
has an exact source mapping and the finite-model layer can be used for
regression tests.
