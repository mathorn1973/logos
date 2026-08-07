# A2–A3–A4 ATTACK

Status: **NON-CANONICAL ATTACK NOTE**.

This note freezes the next philosophical target of `ABSOLUTE-GROUND-1`.
The program does not attempt to define divine attributes.  Its central question is narrower:

> If anything at all exists, is some necessary ungrounded reality forced, or can reality be bottomless or brute?

## 1. Minimal theorem now isolated

The Lean hierarchy now separates unity from existence.

```text
A0  something is actual
A1  grounding relates existents
A2  actual grounding is well founded
A4  actual contingent beings are derived
A5  the actual world accesses itself
```

These assumptions are bundled as `NecessaryExistenceAxioms`.  They contain no A3.
Lean proves:

```lean
exists_necessary_ungrounded :
  NecessaryExistenceAxioms M →
  ∃ a, Ungrounded M a ∧ Necessary M a
```

Therefore the minimal existence claim does not depend on a monist or common-ground premise.

A3 enters only when asking for uniqueness and universal grounding ancestry.

## 2. A2 — genuine infinite regress attack

The old finite cycle is retained as a simple independence check, but it is not the serious philosophical opponent.

`Logos.Models.Grounding.InfiniteRegress` now gives a genuine acyclic bottomless model.

Entities are finite structural terms.  From every entity `x`, a strictly larger term `lift x` immediately grounds `x`.  For any two entities `x` and `y`, `join x y` immediately grounds both.  Thus the model has an indefinitely extendable grounding chain without using a grounding cycle.

Verified properties:

```text
A0  holds
A1  holds
A3  holds
A4  holds
A5  holds
A2  fails
```

Additional witnesses:

```text
tower_step
    gives an explicit endless chain of further grounds

regress_no_ungrounded
    every entity is derived; there is no root

regress_reverse_wellFounded
    the reverse relation is structurally well founded, witnessing acyclic orientation

regress_not_wellFounded
    grounding itself is not well founded
```

So A2 is not a disguised consequence of A0, A1, A3, A4, and A5.

The philosophical question is now exact:

> Can an order made entirely of derivative members be an adequate ultimate explanation merely because the regress has no first member?

Rejecting A2 means answering yes, or at least allowing that possibility.

## 3. A3 — unity is not existence

The disconnected two-root model has been upgraded to satisfy `NecessaryExistenceAxioms`.

It therefore satisfies A0–A2 and A4–A5 while A3 fails.
Both roots are proved:

```text
actual
ungrounded
necessary
distinct
```

Hence:

```text
A2 + A4 do not force one absolute root.
A2 + A4 do force at least one necessary ungrounded root.
A3 rules out fundamental plurality.
```

This is the exact role of A3.

The philosophical question is separate from the existence argument:

> Can reality consist of two or more genuinely independent necessary foundations with no deeper common ground?

This question should not be used to burden the prior question whether any necessary foundation exists at all.

## 4. A4 — brute contingency

The original A4 is:

```text
Actual x → Contingent x → Derived x
```

Under A5, Lean now proves it equivalent to the cleaner formulation `A4'`:

```text
Actual x → ¬ Necessary x → Derived x
```

formalized as `NonNecessaryIsDerived`.

So the intended metaphysical content can be stated without the extra modal wording:

> What actually exists but need not exist is not ontologically ultimate.

The existing brute-fact model refutes both forms simultaneously.  It contains one entity that:

```text
actually exists
is ungrounded
is not necessary
```

and therefore witnesses exactly what denial of A4 permits: an unexplained contingent ultimate fact.

The philosophical question is now exact:

> Is a contingent ungrounded fact a genuine stopping point, or does its contingency itself prevent it from being ultimate?

## 5. Current logical map

```text
A0 + A1 + A2
        |
        v
some actual ungrounded root
        |
      + A4 + A5
        |
        v
some necessary ungrounded root
        |
      + A3
        |
        v
one universal ungrounded root
```

A6 and later creation vocabulary are not needed for the central question in this note.

## 6. What is not being attempted

This attack does not try to derive or define properties of God.
It does not formalize personality, intelligence, goodness, will, omnipotence, omniscience, or any positive characterization of the transcendent.

The only target is whether reality can terminate in anything less than necessary ungrounded being — or avoid termination through an infinite regress.

## 7. Next work

The next work should attack the three escape routes rather than add conclusions:

```text
A2  Is bottomless derivative grounding explanatory or merely endless deferral?
A4  Is contingent brute ultimacy coherent as an ontological stopping point?
A3  If necessary foundations exist, can more than one be genuinely independent?
```

Order of work:

```text
1  A2 — strongest case for infinite regress
2  A4 — strongest case for brute contingency
3  A3 — only after existence is settled, investigate fundamental plurality
```

No promotion of the metaphysical premises themselves follows from Lean success.  Lean has isolated the forks; human argument must now address them.
