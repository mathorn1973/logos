# TRUTH-FACT-SEAM-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - NOT ON MAIN**.

Base: `main` after the `self-closure-1` closure.

Local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

This contract is written before any Lean for this cut exists. The design below was settled analytically in discussion and nothing has been run against it. Unlike `INTERNAL-TRUTH-CONTRACT.md` and `SELF-CLOSURE-CONTRACT.md`, whose section 0 records prior implementation exposure, there is none here.

That has a consequence and the consequence is the point: **a target in section 5 may fail.** If one does, the failure is recorded in this contract and in the pull request as a result, not silently replaced by whatever turned out to be provable. Section 6 states in advance what each outcome would mean, so that neither outcome can be reported as a success after the fact.

## 1. Motivation

`internal-truth-1` introduced a truth carrier. `TOTALITY-REGRESS-1` already had a fact carrier. Both are, informally, about "what is the case". The obvious worry, recorded as an open item in `STATUS.md` since the promotion of `internal-truth-1`, is that the second is the first renamed:

```text
Truth (s, w)  :=  holdsAt w (f s)      for some f : Sentence -> Fact
```

If that identity is forced, the semantic self-reference line adds a vocabulary and no axis.

Two non-entailments between `RegressTotality` and the language structure would not settle this. The signatures are disjoint, so any two such models can be glued as unrelated worlds and the non-entailments come for free. The renaming worry is a **definability** worry: is the truth side a function of the fact side? A definability question needs the two sides linked, hence a bridge, hence a separate cut. This is the same manoeuvre `route-seam-1` used for the relation between the foundation and totality routes.

## 2. Claim type

```text
formal definition   LinkedModel, Bridge
proved theorem      S1a
countermodel        S1b, S2
interpretation      section 7 only
```

`LinkedModel` and `Bridge` are new structure and a new premise. They are confined to this cut and no result outside it may depend on them.

## 3. Language

Inherited from both lines, joined by one new structure.

```text
LinkedModel (M : Model) (F : FactModel M) (TV : TruthValues)
  L            : SemLanguage TV
  sentenceFact : L.Sent -> F.Fact

Bridge K  :=  forall s, ActualFact F (K.sentenceFact s) <-> TV.isT (K.L.val s)
```

Three deliberate choices.

**The bridge relates `holdsAt` to `val`, not to `T`.** `val` is the external valuation of the language and `holdsAt` is the fact-side valuation. Relating `holdsAt` to `T` instead would presuppose the identification under test.

**The bridge is at the actual world only.** `ActualFact` is `holdsAt` at `M.actual`. Facts carry modal structure; sentences as given here do not.

**The bridge uses `isT`, not equality of values.** A fact obtains or does not. That is exactly the information a two-valued designation carries, and it is less than a value in `V` carries whenever `V` has more than two values. Section 5 turns on that gap.

## 4. Assumptions

No new assumption beyond `Bridge`. `Scope`, `Disq`, `NoGap`, `NoGlut` are used as already defined in `Logos.Systems.InternalTruth`. `SelfClosed` and `Bivalent` as already defined in `Logos.Systems.SelfClosure`.

## 5. Targets

Two linked models are said to *share the fact side* when they have the same `M`, the same `F`, the same `Sent`, `Code`, `q`, and the same `sentenceFact`.

### 5.1 S1a, collapse under bivalence

Over a two-valued carrier in which `isT` determines the value, two linked models sharing the fact side and both satisfying `Bridge`, `Scope` and `Disq` have the same `val` and the same `T` on the image of `q`.

Predicted to hold. If it does, the truth side **is** a function of the fact side under those hypotheses, and the renaming worry is vindicated for that case.

### 5.2 S1b, no collapse without bivalence

Over a carrier with two distinct values both designated true, two linked models sharing the fact side, both satisfying `Bridge`, `Scope` and `Disq`, with different `val` and different `T` on the image of `q`.

Predicted to hold. If it does, the truth side is not a function of the fact side in general, and the collapse of 5.1 is conditional on a premise that `internal-truth-1` already isolated as droppable.

### 5.3 S2, the fact side is not a function of the language side

Two fact models over the same `M`, agreeing at the actual world, admitting the same language and the same `sentenceFact` with `sentenceFact` surjective, both satisfying `Bridge`, and differing in `holdsAt` at a non-actual world.

Surjectivity is required so that the result cannot be dismissed as an artefact of facts the bridge never mentions. The residual freedom is then modal rather than extensional, which is a sharper statement than the one first proposed for this cut.

## 6. What each outcome would mean, stated in advance

```text
S1a holds, S1b holds     the axis is conditionally new. It collapses into the
                         fact carrier exactly when the carrier is bivalent and
                         the language is self-closed, and not otherwise. This
                         is a boundary, not a victory for either side.

S1a holds, S1b fails     the axis is a renaming under every carrier tried.
                         Recorded as a dead end in the sense of the project's
                         epistemic discipline, and STATUS updated to say the
                         truth carrier adds vocabulary and no axis.

S1a fails                the bridge is too weak to force collapse even in the
                         bivalent case, and the contract has mis-specified
                         either the bridge or the sharing condition. Recorded
                         as a specification failure, not repaired by weakening
                         the target.

S2 fails                 the fact side is determined by the language side
                         under a surjective naming map, which would be a much
                         stronger link than anything expected here and would
                         need its own investigation before anything is claimed.
```

## 7. What this does not establish

Nothing about an absolute, a God, or any theological notion.

Nothing about whether either carrier corresponds to anything. Both are formal.

`Bridge` is a substantive semantic commitment, not a discovery. It says a sentence's fact obtains exactly when the sentence is designated true. Someone who rejects that reading rejects the whole cut, and the results say nothing to them.

No result of the grounding line may depend on anything in this cut. Adding a bridge module joins two lines that were previously disjoint, and that is the main risk this cut introduces.

## 8. Boundary

```text
NO A0-A8            NO God predicate        NO Goedel-Scott premise
NO TWIST-J          NO physical predicate   NO theological predicate
NO new grounding, explanation, constitution or modality premise
NO SemanticClosure  NO arithmetic           NO mathlib
```

Structural requirement specific to this cut: the seam module must be a **leaf**. No module of the grounding line and no module of the semantic self-reference line may import it. This is stronger than the general firewall and is required because the cut is the first thing in the repository to mention both lines.

## 9. Acceptance tests

```text
T1   lake build succeeds
T2   no sorry, sorryAx or native_decide in the new file
T3   #print axioms on every result reports at most
     propext, Classical.choice, Quot.sound
T4   S1a stated with explicit sharing hypotheses, not by construction
T5   S1b and S2 exhibited as concrete models
T6   S1b uses a carrier with two distinct values both designated true, and
     the two models differ in T on the image of q
T7   S2's naming map is proved surjective
T8   no module imports the seam module
T9   no grounding-line theorem signature changes
```
