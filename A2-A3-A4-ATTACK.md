# A2–A3–A4 ATTACK

Status: **NON-CANONICAL ATTACK NOTE, REVISED AFTER THE EXPLANATION LINE**.

This note was written before the totality/explanation line existed. It has been revised
against `main` as of `route-seam-1`. Two of its three targets changed shape; one did not.
The original agenda is corrected in place rather than deleted, and each section says what
the later cuts did to it.

This note freezes the philosophical targets of `ABSOLUTE-GROUND-1`.
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

**Revision note.** Partly superseded. The totality line was built to work without A2, so the
question is no longer whether a bottomless order can be refuted, but what a bottomless order
costs once the totality premises are added on top of it. `route-seam-1` also deflated the
regress record itself: a `RegressTotality` carries an infinite descending chain plus a
designated fact, and its fact layer, that designated fact and its `inside` predicate are
largely free data. A bare infinite regress is a chain plus a label, not an explanation and
not by itself an opponent position. The section below stands as the independence result it
always was; the philosophical question at its end is restated accordingly.

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

**As the question now stands.** Rejecting A2 is not by itself a position. It makes the
foundation route unavailable and nothing more; the bare record that replaces it discharges
the totality conclusion trivially, by `bare_totality_necessary`. The live question is
therefore the conjunction:

> Can an order made entirely of derivative members, together with source actuality, local
> explanatory adequacy and completeness over a represented totality, avoid a necessary
> explanatory source without accepting a contingent explanatory absolute?

`fact-sufficient-explanation-1` answers that this is exactly the third disjunct of the
accepted trichotomy, and `carrier-schema-1` answers that reaching it always requires
exempting some carrier from completeness, scope or adequacy.

## 3. A3 — unity is not existence

**Revision note.** Unchanged by the later cuts. A3 remains a question about plurality of
foundations on the foundation side only. The totality route has no unity premise and says
nothing about how many explanatory sources there are.

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

**Revision note.** Still live, but the original formulation is too narrow. The later cuts
separated three distinct positions that A4 as written treats as one:

```text
brute contingent entity      an actual, ungrounded, non-necessary entity
                             refuted by A4; the original target of this section

brute contingent fact        the totality fact is actual, non-necessary and unexplained
                             untouched by A4; the third disjunct of the accepted
                             trichotomy, and equivalent to denying local sufficient
                             explanation for that fact

relocation to a carrier      the unexplained item moved onto a fresh carrier, for
                             instance a modal condition licensing failure
                             untouched by A4; available exactly when the new carrier is
                             exempt from completeness, scope or adequacy
```

The three are not variants of one thesis. A4 governs only the first. Arguments against it do
not transfer to the other two, and the later cuts show the other two are where the surviving
opponent position actually lives.

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

Stated for the entity case only. For the fact case and the carrier case the corresponding
questions are recorded in `STATUS.md` as live commitments, not here.

## 5. Current logical map

### Foundation side

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

### Totality side

```text
TotalityExplanationCore = source actuality + local adequacy + completeness
        |
        v
NecessaryFact(totality)
  or an actual necessary explanatory source
  or a contingent explanatory absolute totality fact
```

The middle disjunct yields a necessary explanatory source that need not be ungrounded, so it
does not reach `AbsoluteGround`. The third disjunct is the surviving opponent position, and
is equivalent to denying local sufficient explanation for the totality fact.

### The seam

The two sides do not stack. A2 is a field of the foundation package and is refuted by the
mere presence of a regress record, so no model carries both premise packages and any theorem
stated over both is vacuous.

Well-foundedness against the availability of a bare regress record is an exhaustive
**structural** dichotomy. The full premise packages are **not** exhaustive and may fail
together: well-founded grounding by itself supplies neither A0, A1, A4 nor A5, and the
availability of a regress record by itself supplies neither source actuality, nor local
adequacy, nor completeness.

Nothing in this map licenses the reading that one route applies whenever the other does not.

## 6. What is not being attempted

This attack does not try to derive or define properties of God.
It does not formalize personality, intelligence, goodness, will, omnipotence, omniscience, or any positive characterization of the transcendent.

The only target is whether reality can terminate in anything less than necessary ungrounded being — or avoid termination through an infinite regress.

## 7. Where the questions now live

The original three-item agenda is superseded. Two of its items were absorbed by the totality
line and one was not, and the live list is no longer a list of escape routes to attack but a
list of commitments the formal layer states without establishing, plus one interpretive
question. That list is maintained in `STATUS.md` under
`Current live philosophical commitments and questions`, and this note should not duplicate
it.

What remains specific to this note:

```text
A3   only on the foundation side: can more than one necessary foundation be
     genuinely independent? Untouched by the later cuts.

A4   only for the entity case: is a contingent ungrounded entity a genuine
     stopping point? The fact case and the carrier case are separate questions
     and are tracked in STATUS.
```

No promotion of the metaphysical premises themselves follows from Lean success. Lean has
isolated the forks; human argument must now address them. What the later cuts changed is
which forks are the real ones.
