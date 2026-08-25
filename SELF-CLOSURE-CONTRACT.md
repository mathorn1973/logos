# SELF-CLOSURE-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - NOT ON MAIN**.

Base: `feat/internal-truth-1`, on top of `main` at `6a16b8d`. This cut is stacked; it does not build against `main` alone.

Local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

The question came from a claim made in discussion: that semantic self-closure, unavailable to a totalising formal description generally, might be available to an absolute. This cut answers only the formal part of that and takes no position on the claim. Section 9 records why the formal part does not support it.

Two honesty notes, on the model of `INTERNAL-TRUTH-CONTRACT.md` section 0.

**No new semantics.** Everything in section 3 is inherited from `INTERNAL-TRUTH-CONTRACT.md`, frozen there. `SelfClosed` and `Bivalent` are named conjunctions of premises already defined; this cut introduces no carrier, no premise, and no design decision of its own. The failure mode the cycle rule guards against, definitions drifting toward what a proof needs, has almost no surface here.

**But the target list was assembled while exploring, not before.** Section 5 was written after the models existed. That is a real risk of a different kind: targets chosen to match what turned out to be provable. What limits it is that section 5 contains one negative result which is a restatement, and three positive results whose only content is the existence of explicit models. A model either exists or it does not. Whether that is sufficient is a human judgement and is recorded so it can be made.

## 1. Motivation

`internal-truth-1` shows seven conditions jointly unsatisfiable. It is stated negatively and read most naturally as a list of things that must be given up. It leaves open the obvious positive question:

```text
How much can a semantically self-closed language actually have?
```

Self-closure here means only this: the internal truth predicate applies to every sentence of the language and returns exactly the external value there. `Scope` and `Disq` together, nothing else.

The interest is in whether self-closure is a knife-edge, available only to degenerate languages, or whether it survives real richness. That distinction is what separates a genuine option from a curiosity.

## 2. Claim type

Per `PROJECT-RULES.md` section 2:

```text
formal definition   SelfClosed, Bivalent
restatement         selfClosed_excludes_exprNegT
                    contrapositive of no_internal_truth, no content beyond it
countermodel        SimpleLang, MaxLang, OmegaLang, OmegaMaxLang
re-presentation     self_closure_possible
                    the witness already exists in the internal-truth-1
                    independence set; only its framing is new
proved theorem      the maximality results of 5.3 and 5.4
interpretation      section 9 only
```

The typing above is load-bearing. Two of the five results carry no new mathematical content and must not be reported as if they did.

## 3. Language

None introduced. Inherited entirely from `Logos/Ontology/Semantics/Language.lean`.

```text
SelfClosed L  :=  Scope L /\ Disq L
Bivalent TV   :=  NoGap TV /\ NoGlut TV
```

## 4. Assumptions

None introduced.

## 5. Targets

### 5.1 The bound, as a restatement

```text
selfClosed_excludes_exprNegT :
  SelfClosed L -> Bivalent TV -> NegSwapT TV -> Diag L -> not (ExprNegT L)
```

Immediate from `no_internal_truth`. Stated only so the models below have something to be measured against.

### 5.2 Self-closure is satisfiable

An explicit model with `SelfClosed`, `Diag`, `NegSwapT` and `Bivalent` all holding, plus a second model in which the predicate carrier is empty, so that `ExprNegT` fails because there are no internal predicates at all rather than because one of them returns the wrong value. The two failure modes are different and the cut must exhibit both.

### 5.3 The bound is tight at finite size

A model in which the predicate carrier realises **every** function `Code -> V` except exactly one, and that one is the negated internal truth predicate. Required as three separate statements: that every other function is realised, that this one is not, and that this one is the negated truth predicate.

This is the point of the cut. Without it, self-closure is only known to be possible, not known to be cheap.

### 5.4 Richness

A model with infinitely many sentences, and a model that is simultaneously infinite and maximal in the sense of 5.3.

### 5.5 Axiom discipline

The finite maximality result must not use `Classical.choice`. If the infinite maximality result needs it, that must be visible in the audit rather than absorbed silently, and the reason must be stated.

## 6. What this establishes

Self-closure is not a knife-edge. It survives an infinite sentence type and a predicate carrier missing exactly one function. The cost of self-closure, in this setting, is nameable and is a single function: the negation of the language's own truth predicate.

## 7. What this does not establish

Nothing about an absolute, a God, simplicity, or any theological notion. No such predicate appears, and section 9 is interpretation that may not be imported.

Not that anything is self-closed. These are consistency results: the position is available, unlike a position wanting both self-closure and full expressive power.

Not that self-closure is desirable, or that a language having it is better off. The models that have it are expressively poorer by exactly the excluded function, and section 9 says why that matters.

Not a formalisation of Tarski. Inherited boundary from `INTERNAL-TRUTH-CONTRACT.md` section 7 applies unchanged.

Nothing about necessary reality, grounding, or the totality fact.

## 8. Boundary

```text
NO A0-A8            NO God predicate        NO Goedel-Scott premise
NO TWIST-J          NO physical predicate   NO theological predicate
NO Entity carrier   NO Fact carrier         NO World carrier
NO grounding, explanation, constitution or modality vocabulary
NO SemanticClosure  NO arithmetic           NO mathlib
NO new premise      NO new carrier
```

Import firewall:

```text
Logos/Systems/SelfClosure/Axioms.lean       -> Systems.InternalTruth.Axioms
Logos/Systems/SelfClosure/Theorems.lean     -> Systems.SelfClosure.Axioms
                                               Systems.InternalTruth.Theorems
Logos/Models/Semantics/SelfClosure.lean     -> Systems.SelfClosure.Theorems
                                               Models.Semantics.InternalTruthIndependence
```

Leaf: no existing module may import any file of this cut.

## 9. Remaining philosophical boundary

Interpretation. Not importable, never a premise.

**What the motivating claim gets and what it does not.** The formal answer is that a self-closed language is possible and can be rich. Reading the empty predicate carrier of `SimpleLang` as simplicity, or `MaxLang` as an absolute that knows itself, is a bridge, and this repository does not contain that bridge. Per `PROJECT-RULES.md` section 10 no theorem here may be named or documented so as to suggest otherwise.

**The direction of the cost matters and cuts against the motivating claim.** Self-closure here is bought with expressive poverty, not with plenitude. A self-closed language is self-closed because it cannot express one specific thing about itself. Any position wanting something both maximally articulate about itself and semantically self-closed is asking for exactly the combination `no_internal_truth` rules out. That is a fork inside the motivating claim, not support for it.

**A second cost, less visible.** If a structure's self-relation is not representational at all, in the way `SimpleLang` has no predicates, then it is not a description either. The question that started this line, what makes a total description true, is then dissolved rather than answered, and such a structure grounds the truth of anything else only via a further bridge, which would be a new premise.

**Open.** Whether maximality in the sense of 5.3 can be stated for an arbitrary code type without `Classical.choice`. At finite size it is choice-free; at `Nat` it is not, in the proof given here.

## 10. Acceptance tests

Against `feat/internal-truth-1` with `leanprover/lean4:v4.30.0`, `lake-manifest.json` packages empty. Results in the pull request.

```text
T1   lake build succeeds
T2   no sorry, sorryAx or native_decide in the new files
T3   #print axioms on every result reports at most
     propext, Classical.choice, Quot.sound
T4   the finite maximality result uses no Classical.choice
T5   the two failure modes of 5.2 are both exhibited: predicate carrier
     empty, and predicate carrier nonempty with the wrong predicate
T6   5.3 present as three separate statements
T7   an infinite model, and an infinite maximal model
T8   forbidden-token scan over the new files is empty
T9   no existing module imports any file of this cut
T10  no new premise or carrier is introduced anywhere in the cut
```
