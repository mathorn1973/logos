# DESIGN CONTRACT — CUT 1: MODAL FOUNDATION

Status: **NON-CANONICAL DESIGN CONTRACT**.

This contract governs the first LOGOS cut. It defines a formal laboratory, not a proof of God, a theology, or a metaphysical canon.

## 1. Purpose

The first cut builds the smallest trustworthy semantic core needed to distinguish:

```text
truth        phi
necessity    box phi
possibility  diamond phi
contingency  diamond phi and diamond not-phi
validity     phi holds at every world of a model
```

The cut must support both proofs and countermodels. A system that can prove intended consequences but cannot express failed consequences is not yet an adequate philosophical laboratory.

## 2. Primitive objects

The primitive semantic object is a Kripke frame:

```lean
structure Frame where
  World : Type u
  access : World → World → Prop
```

A formula over a frame is a world-indexed proposition:

```lean
abbrev Formula (F : Frame) := F.World → Prop
```

Necessity and possibility are defined from `access`. They are not primitive axioms.

## 3. Frame conditions

The cut defines, but does not globally assume:

- reflexivity;
- symmetry;
- transitivity;
- seriality;
- Euclideanness.

The standard modal principles are proved only under their exact hypotheses:

```text
K   no frame condition
T   reflexive
B   symmetric
4   transitive
5   Euclidean
```

No file may silently replace one frame class with another.

## 4. Claim typing

Later philosophical work needs a vocabulary that distinguishes kinds of commitment. The first cut introduces labels for:

```text
definition
assumption
theorem
conjecture
bridge
interpretation
confession
metaphor
```

These labels are metadata only. They do not turn an interpretation or confession into a proof premise. That protection must ultimately be enforced by the import graph and theorem signatures.

## 5. Import firewall

The intended dependency direction is:

```text
Logic
  ↓
Ontology language
  ↓
Formal systems
  ↓
Theorems and countermodels
  ↓
Interpretation
  ↓
Essays
```

Forbidden directions include:

```text
Essays -> Theorems
Interpretation -> Logic
TWIST-J bridge -> General ontology
Metaphor -> Formal premise
Confession -> Formal premise
```

The first cut contains no `Systems`, `Interpretation`, `Essays`, or `TwistJBridge` module.

## 6. First acceptance tests

The cut is acceptable only if:

1. the project builds with the committed Lean toolchain;
2. the K distribution theorem elaborates with no frame assumption;
3. T, B, 4, and 5 elaborate under exactly their named frame conditions;
4. `Logos/Audit.lean` reports no project axiom for these theorems;
5. no `sorry` occurs in trusted source;
6. no theological or physical predicate is present;
7. the README and STATUS boundary match the Lean source.

## 7. Next cut boundary

The next cut may add finite frames and explicit countermodels. It must not add the Gödel–Scott axioms until the modal basis has passed independent review.

The intended order is:

```text
1  modal semantic foundation
2  finite models and countermodels
3  Gödel–Scott language and axiom record
4  derivability audit
5  modal-collapse audit
6  repaired variants
7  interpretation bridge to essays
8  optional TWIST-J adapter
```

## 8. Human responsibility

Lean can establish that a conclusion follows from formal premises. It cannot decide, merely by proving that implication, whether the premises are true of reality, whether a formal predicate captures the intended philosophical concept, or whether a bridge from mathematics to theology is justified.

Those judgments remain explicit human obligations of the program.
