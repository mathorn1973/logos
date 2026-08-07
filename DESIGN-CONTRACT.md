# DESIGN CONTRACT — CUT 1: MODAL FOUNDATION

Status: **HISTORICAL CUT CONTRACT — CUT ACCEPTED ON MAIN**.

This contract records the design boundary of the first LOGOS cut. Project-wide governance, claim typing, import firewall, branch topology, and merge-closure rules now live in `PROJECT-RULES.md`.

This document is not a proof of God, a theology, or a metaphysical canon.

## 1. Purpose

CUT 1 built the smallest semantic core needed to distinguish:

```text
truth        phi
necessity    box phi
possibility  diamond phi
contingency  diamond phi and diamond not-phi
validity     phi holds at every world of a model
```

The cut supports both proofs and countermodels.

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

Necessity and possibility are defined from `access`. They are not primitive project axioms.

## 3. Frame conditions

CUT 1 defines, but does not globally assume:

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

## 4. Project-wide claim typing

CUT 1 introduced the first metadata vocabulary for definitions, assumptions, theorems, conjectures, bridges, interpretations, confessions, and metaphors.

That vocabulary is no longer a CUT-1-local rule. Its canonical project-wide form is maintained in `PROJECT-RULES.md`.

The governing principle remains: an interpretation, confession, or metaphor does not become a proof premise by being written next to formal mathematics.

## 5. Project-wide import firewall

The dependency firewall first stated in CUT 1 is now project-wide governance and is maintained in `PROJECT-RULES.md`.

The intended direction remains:

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

CUT-specific contracts may strengthen local boundaries but may not reverse the project-wide direction.

## 6. Acceptance tests

CUT 1 was accepted only after:

1. the project built with the committed Lean toolchain;
2. K elaborated with no frame assumption;
3. T, B, 4, and 5 elaborated under exactly their named frame conditions;
4. `Logos/Audit.lean` exposed no hidden project axiom for those theorems;
5. no `sorry` occurred in trusted source;
6. no theological or physical predicate entered the modal core; and
7. README and STATUS matched the accepted source boundary.

## 7. Historical continuation

The only direct continuation committed by this CUT-1 contract was the finite-model/countermodel layer. That work became `finite-countermodels-2` and is now on `main`.

The old planning list that placed Gödel–Scott as step 3 of one linear main sequence is superseded.

Current project topology is governed by `PROJECT-RULES.md`:

```text
modal/general logic          accepted shared base
grounding/absolute-ground    independent metaphysical line
totality/explanation         second grounding research line
Gödel–Scott                  separate formal branch
TWIST-J                      optional interpretation/adapter work, never a dependency of general ontology
```

Git stack order is not evidence of logical dependency.

## 8. Human responsibility

Lean establishes consequence from formal premises. It does not decide, merely by proving an implication, whether the premises are true of reality, whether a formal predicate captures the intended philosophical concept, or whether a bridge from mathematics to theology is justified.

Those judgments remain explicit human obligations of LOGOS.
