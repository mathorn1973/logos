# DESIGN CONTRACT — ABSOLUTE-GROUND-1

Status: **NON-CANONICAL DESIGN CONTRACT**.

This contract governs the grounding-based metaphysical branch of LOGOS. It is independent of Gödel–Scott and TWIST-J. Its central question is deliberately minimal:

> If anything at all exists, is some necessary ungrounded reality forced?

The branch does not attempt to define divine attributes. Any identification of the formal result with God is interpretive and lies outside the proof core.

## 1. Purpose

The formal target is to separate three questions that must not be conflated:

```text
EXISTENCE   must some necessary ungrounded reality exist?
UNITY       if so, must there be only one ultimate root?
CREATION    how, if at all, should a derived order be related to that root?
```

The first question is primary. A3 is not allowed to carry hidden weight in the existence argument.

The system must support both derivations and explicit countermodels showing what becomes possible when a substantive commitment is removed.

## 2. Semantic language

A model contains:

```lean
structure Grounding.Model where
  frame : Frame
  Entity : Type v
  actual : frame.World
  existsAt : frame.World → Entity → Prop
  directGrounds : frame.World → Entity → Entity → Prop
  created : Entity → Prop
```

`directGrounds` is ontological grounding, not temporal causation.

The formal language contains no entity named `Nothing`. Nothingness is not modeled as a cause, state, vacuum, zero, or member of the entity carrier.

The core definitions are:

```text
Actual
DerivedAt / Derived
UngroundedAt / Ungrounded
GroundAncestor / UltimatelyGrounds
Necessary / Contingent
AbsoluteGround
NecessarilyAseitic
```

No predicate for personality, intelligence, consciousness, will, goodness, omniscience, omnipotence, revelation, Trinity, or any other positive divine attribute belongs in this branch.

## 3. Commitments A0-A8

```text
A0  actual_nonempty
    Something actually exists.

A1  grounds_existents
    If a grounds x at world w, both a and x exist at w.

A2  grounding_wellFounded
    Actual grounding has no infinite descent toward ever deeper grounds.

A3  common_ground
    Any two actual entities have a common actual grounding ancestor.

A4  contingent_is_derived
    Every actually existing contingent entity is derived.

A5  actual_reflexive
    The actual world accesses itself.

A6  created_is_derived
    Every actually existing created entity is derived.

A7  created_nonempty
    At least one actually existing entity belongs to the created order.

A8  aseity_essential
    If an entity is actually ungrounded, then at every accessible world where
    it exists it remains ungrounded.
```

These commitments are Lean structures passed explicitly to theorems. They are not global project axioms.

## 4. Exact dependency boundary

The hierarchy is intentionally split.

```text
FoundationAxioms
    A0 + A1 + A2

NecessaryExistenceAxioms
    A0 + A1 + A2 + A4 + A5
    NO A3

StructuralAxioms
    A0 + A1 + A2 + A3

NecessaryGroundAxioms
    A0 + A1 + A2 + A3 + A4 + A5
```

The verified theorem boundary is:

```text
A0-A2            existence of some actual ungrounded root
A0-A2+A4+A5      existence of some necessary ungrounded root
A0-A3            uniqueness of actual ungrounded roots and universal ancestry
A0-A6            unique AbsoluteGround, including not-created transcendence
A7               non-vacuity of the created order; not needed for the above
A0-A6+A8         necessary aseity of the unique AbsoluteGround
```

The load-bearing minimal theorem is:

```lean
exists_necessary_ungrounded :
  NecessaryExistenceAxioms M →
  ∃ a, Ungrounded M a ∧ Necessary M a
```

A3 is absent from its signature.

## 5. A4 and its cleaner form

Under A5, Lean proves equivalence between the original A4

```text
Actual x -> Contingent x -> Derived x
```

and the cleaner formulation A4':

```text
Actual x -> not Necessary x -> Derived x
```

formalized as `NonNecessaryIsDerived`.

The philosophical reading is therefore:

> What actually exists but need not exist is not ontologically ultimate.

The brute-fact countermodel refutes both forms.

## 6. Logical foundation and classical reasoning

The grounding argument is formalized in classical Lean, not as a fully constructive proof.

Classical reasoning enters in two load-bearing places:

```text
1  the root construction decides whether an actual entity is Derived;
2  the necessity argument uses not box E(a) -> diamond not E(a).
```

The CI axiom audit reports the load-bearing existence and necessity theorems as depending only on Lean's standard logical foundations:

```text
propext
Classical.choice
Quot.sound
```

No project-specific axiom may be hidden behind these foundations.

## 7. Required A2 attack: genuine infinite regress

The finite grounding cycle remains a simple regression test, but it is not the serious philosophical opponent.

`Logos.Models.Grounding.InfiniteRegress` must provide an acyclic bottomless grounding order satisfying:

```text
A0  holds
A1  holds
A3  holds
A4  holds
A5  holds
A2  fails
```

It must also exhibit:

```text
an explicit endless tower of further grounds;
no ungrounded entity;
well-founded reverse structural descent as the acyclicity witness;
non-well-founded grounding in the intended direction.
```

This model isolates the actual content of denying A2: endless derivative grounding without a first ground.

## 8. Required A3 separation

The disconnected two-root model must satisfy `NecessaryExistenceAxioms` while failing A3.

It must prove that two distinct entities are both:

```text
actual
ungrounded
necessary
```

This establishes the exact logical role of A3:

> A3 is not required for a necessary foundation to exist. A3 rules out fundamental plurality and yields one universal root.

## 9. Required A4 attack

The brute-fact model must exhibit an entity that is:

```text
actual
ungrounded
not necessary
```

and must refute both original A4 and A4'.

This isolates the alternative to A4: contingent brute ultimacy.

## 10. Positive no-collapse model

`Logos.Models.Grounding.FreeCreation` must exhibit a concrete two-world model in which the root is necessary while a derived entity is contingent.

It must prove:

```text
Necessary root
Contingent derived entity
not (forall x, Actual x -> Necessary x)
```

The existence of a necessary foundation must not collapse all actuality into necessity.

## 11. Interpretation firewall

The formal conclusion of the minimal theorem is only:

> Some actual ungrounded entity exists necessarily under A0-A2 and A4-A5.

With A3 and the later bridge assumptions, stronger grounding conclusions follow.

The proof core must not infer or define positive properties of God. In this program, transcendence is treated as a boundary on description, not an invitation to construct an inventory of divine attributes.

Forbidden dependencies include:

```text
God interpretation -> grounding theorem
Gödel–Scott        -> ABSOLUTE-GROUND-1 core
TWIST-J            -> ABSOLUTE-GROUND-1 core
confession         -> formal premise
metaphor           -> formal premise
```

## 12. Acceptance tests

This branch is acceptable only if:

1. the whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs in trusted source;
3. all metaphysical commitments occur only as explicit theorem parameters or concrete model data;
4. `exists_necessary_ungrounded` has no A3 dependency;
5. A4 and A4' are proved equivalent under A5;
6. the genuine infinite-regress A2 model elaborates;
7. the two-necessary-root A3 model elaborates;
8. the brute A4/A4' model elaborates;
9. the positive anti-modal-collapse model elaborates;
10. `Logos/Audit.lean` exposes the logical axioms of every load-bearing result;
11. no `God` predicate or Gödel–Scott premise is present in the grounding core;
12. README and STATUS state that the branch is conditional and non-canonical.

## 13. Human responsibility

Lean has isolated the forks. It cannot decide merely from successful derivation whether A2, A3, or A4 is true of reality.

The philosophical work is therefore concentrated on three questions:

```text
A2  Is endless derivative grounding an ultimate explanation or endless deferral?
A4  Can a contingent ungrounded fact be ontologically ultimate?
A3  If necessary foundations exist, can more than one be genuinely independent?
```

The order of attack is A2, then A4, then A3.
