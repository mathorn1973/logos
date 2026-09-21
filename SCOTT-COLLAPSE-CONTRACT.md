# SCOTT-COLLAPSE-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - NOT ON MAIN**.

Base: `main` at `4c9b726`, after the `totality-constitution-1` closure and the semantic line audit.

Local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

This contract is written before any Lean for this cut exists. The design was settled on
paper, in conversation, on 2026-09-21, by reading the accepted definitions on `main`
(`Frame`, `Formula`, `box`, `Symmetric`, `Model`, `ContingencyWitness`, `SingleSuccessor`
and the foundation-side theorems of `totality-constitution-1`). Nothing of this cut has been
run. A target in section 5 may therefore fail, and if one does, the failure is recorded here
and in the pull request as a result. Section 6 says in advance what each outcome would mean.

One change happened on paper before freezing and is recorded so that it is not mistaken for
a post-hoc adjustment. The conversation that proposed this cut predicted the frame collapse
by the classical route: possible exemplification, the all-positive property as an essence,
its necessary instantiation, then the collapse schema applied to world identity. While
drafting this contract a shorter route was found that goes through definition D3 alone and
uses neither D1, A3 nor A4. The targets below are stated for the shorter route, and the
prediction that A3 and A4 are idle is itself a target that may fail.

The source facts about Scott's version (the axiom list, consistency, the need for symmetry,
modal collapse) are taken from the published mechanisations and are not re-derived here
except where a target says so.

## 1. Motivation

`PROJECT-RULES.md` lists Goedel-Scott as a separate formal line and the repository contains
nothing of it. `totality-constitution-1` put a new position on the map: the denial of

```text
W   something actual is not necessary
```

which is necessitarianism about the actual world, and it recorded the frame on which that
position is automatic: `SingleSuccessor`, where the actual world accesses only itself.

Scott's axioms are known to entail modal collapse, `phi -> box phi`. In a shallow embedding,
where a formula is an arbitrary predicate on worlds, modal collapse applied to the predicate
"is the actual world" is `SingleSuccessor` itself. If that goes through, Scott's package
does not sit beside the LOGOS question as a rival argument for necessary reality. It sits on
the position that denies the presupposition of the question.

So the cut has one question:

> Stated over a LOGOS frame, where does Scott's axiom package sit on the map drawn by
> `totality-constitution-1`, and which of its premises put it there?

## 2. Claim type

```text
formal definition   Property, Carrier, pNot, NecEntails, AllPositive, Essence,
                    NecInstantiated, SeesOnlyItself, BackAccess,
                    ScottCoreAxioms, ScottAxioms
proved theorem      5.1, 5.2, 5.3, 5.4, 5.6
countermodel        5.5 (one consistency witness, four independence models),
                    5.7 (one grounding model with two positivity carriers)
interpretation      section 7 only
```

`Carrier`, `ScottCoreAxioms` and `ScottAxioms` are the only new structures. The two axiom
records are premises passed explicitly to theorems, in the same way as every assumption
record on the grounding line. They are not established, and no result on the grounding line
or the semantic line may depend on them.

## 3. Language

A new line, in namespace `Logos.GoedelScott`, importing the logic layer and nothing else.

```text
Property F Ind     :=  Ind -> F.World -> Prop

Carrier F Ind
  dom              :  F.World -> Ind -> Prop        domain of individual quantification
  positive         :  Property F Ind -> F.World -> Prop

pNot phi           :=  fun x w => not (phi x w)
NecEntails C phi psi w
                   :=  forall v, access w v -> forall x, dom v x -> phi x v -> psi x v

AllPositive C      :=  fun x w => forall phi, positive phi w -> phi x w            (D1)
Essence C phi x w  :=  phi x w  and  forall psi, psi x w -> NecEntails C phi psi w (D2)
NecInstantiated C  :=  fun x w => forall phi, Essence C phi x w ->
                         forall v, access w v -> exists y, dom v y and phi y v     (D3)

SeesOnlyItself F w :=  forall v, access w v -> v = w
BackAccess F w     :=  forall v, access w v -> access v w
```

Four deliberate choices.

**Full comprehension.** A property variable ranges over every function of type
`Ind -> F.World -> Prop`, including functions that mention a particular world, such as
`fun y v => y = x and v = w`. This is what a shallow embedding gives and it is the reading
under which the published collapse result is stated. It is a **commitment**, it is the
commitment this cut turns on, and section 7 says what rejecting it leaves.

**The domain is a parameter.** `dom` restricts individual quantification in D2, D3 and A2.
Taking `dom` constantly true gives possibilist quantification; taking `dom := M.existsAt`
gives actualist quantification over a LOGOS model. Every theorem of the cut is stated for an
arbitrary `dom`, so no result depends on how existence is represented.

**D2 carries Scott's conjunct.** `Essence` includes `phi x w`. Goedel's original definition
omits it and is known to be inconsistent. The original is not formalised here.

**Names are structural.** D1 is named `AllPositive` and D3 `NecInstantiated`. The source
calls them God-like and necessary existence. The source names appear in the mapping of
section 4 and nowhere in Lean, because no theorem of the cut uses any reading of either
predicate, and because the formal layer carries no theological predicate.

`BackAccess` is symmetry at one world: every world the designated world accesses accesses it
back. It is implied by `Symmetric F` and is strictly weaker.

## 4. Assumptions and source mapping

All five axioms are asserted valid, that is, at every world.

```text
source   Lean field                 statement
A1       positive_neg               positive (pNot phi) w  <->  not (positive phi w)
A2       positive_mono              positive phi w -> NecEntails C phi psi w -> positive psi w
A5       positive_necInstantiated   positive (NecInstantiated C) w
A3       positive_allPositive       positive (AllPositive C) w
A4       positive_rigid             positive phi w -> forall v, access w v -> positive phi v

ScottCoreAxioms C   :=  A1, A2, A5
ScottAxioms C       :=  ScottCoreAxioms C, A3, A4
```

Source theorems, for orientation: T1 positive properties are possibly exemplified, C the
all-positive property is possibly exemplified, T2 the all-positive property is an essence of
whatever has it, T3 the all-positive property is necessarily exemplified.

The frame premise is `BackAccess F a` at the designated world `a`. No other frame condition
is assumed by any theorem.

## 5. Targets

### 5.1 D3 is a frame condition

```text
NecInstantiated C x w  <->  forall v, access w v -> (v = w and dom w x)
```

for every carrier, with **no axiom record among the hypotheses**. Predicted to hold and to
depend on no axioms. The forward direction instantiates D3 at the property
`fun y v => y = x and v = w`, which is an essence of `x` at `w` by construction.

Corollary: `NecInstantiated C x w -> SeesOnlyItself F w`.

### 5.2 T1 from A1 and A2

```text
positive_neg -> positive_mono -> positive phi w ->
    exists v, access w v and exists x, dom v x and phi x v
```

Predicted to hold and to be classical: the argument refutes the absence of a witness and
then needs the witness.

### 5.3 The core package forces the single-successor frame

```text
ScottCoreAxioms C -> BackAccess F a -> SeesOnlyItself F a and access a a
```

Predicted to hold, classical through 5.2. The signature takes the core record, so A3 and A4
cannot be used, and it takes `BackAccess` at `a`, not `Symmetric F`. Reflexivity at the
designated world, which is `A5` of the grounding line, is a conclusion here and not a
hypothesis.

### 5.4 What follows on that frame

```text
collapse          ScottCoreAxioms C -> BackAccess F a ->
                    forall p : Formula F, p a -> box F p a
T3                ScottCoreAxioms C -> (forall w, positive (AllPositive C) w) -> BackAccess F a ->
                    box F (fun v => exists x, dom v x and AllPositive C x v) a
T3 is free        ScottCoreAxioms C -> BackAccess F a ->
                    (box F (fun v => exists x, dom v x and AllPositive C x v) a
                      <->  exists x, dom a x and AllPositive C x a)
```

Predicted to hold. `collapse` is a corollary of 5.3, not a separate argument. T3 is stated
with A3 as a separate hypothesis rather than through `ScottAxioms`, so that A4 is visibly
absent. "T3 is free" needs no A3: on the forced frame the box adds nothing to the plain
existential, which is the same reading `totality-constitution-1` recorded for
`exists_necessary_ungrounded`. **Predicted: no result of the cut uses A4, and A3 is used
only by T3.**

### 5.5 Consistency and independence

One consistency witness: a carrier over a one-world reflexive frame satisfying the full
`ScottAxioms` and `BackAccess`, so that 5.3 is not vacuous.

Four independence models. Each is predicted to satisfy **all five axioms except the one
dropped**, including the idle A3 and A4, and to refute `SeesOnlyItself` at the designated
world. Frame conditions are taken as strong as the model allows, so that each non-redundancy
statement is about the dropped premise and not about a weak frame.

```text
NoBackAccess   all of A1-A5, frame reflexive and transitive, not BackAccess
               worlds a, b; a accesses a and b, b accesses b; positive phi w := phi i b
DropA5         A1-A4, equivalence frame, not A5
               two worlds, full access; positive phi w := phi i a
DropA1         A2-A5, equivalence frame, not A1
               two worlds, full access; everything is positive
DropA2         A1, A3, A4, A5, equivalence frame, not A2
               two worlds, full access; positive phi w := not (phi i a)
```

Each model comes with a non-redundancy theorem of the form

```text
not (forall F Ind C a, <every premise but one, at full strength> -> SeesOnlyItself F a)
```

which is a statement about all proofs, not about one proof term. A compile-failure
experiment is not an independence argument and is not used.

### 5.6 The seam with the grounding line

For a grounding model `M` and any `C : Carrier M.frame M.Entity`, under
`ScottCoreAxioms C` and `BackAccess M.frame M.actual`:

```text
SingleSuccessor M
M.frame.access M.actual M.actual
not (ContingencyWitness M)
forall x, Necessary M x <-> Actual M x
FoundationAxioms M -> NecessaryExistenceAxioms M                       (A4 of the grounding line is vacuous)
(exists a, Ungrounded M a and Necessary M a) <-> exists a, Ungrounded M a
```

Predicted to hold. The last four are obtained from the first two through the accepted
foundation-side theorems of `totality-constitution-1`. They hold for every `dom`, so the
denial of `W` does not depend on whether Scott's individual quantifiers are read as
possibilist or actualist.

The seam does **not** use `ConstitutedTotality` or `TotalityRequiresMembers`.
`TOTALITY-CONSTITUTION-CONTRACT.md` section 2 confines the constitution law to its own cut,
and that confinement is respected: no statement about the totality fact is made here.

### 5.7 The package says nothing about grounding position

One grounding model with one world and two entities, `root` grounding `leaf`, satisfying
`NecessaryExistenceAxioms`. Two carriers over it with `dom := existsAt`, both satisfying the
full `ScottAxioms` and `BackAccess`:

```text
RootCarrier    positive phi w := phi root w    the all-positive individual is ungrounded
LeafCarrier    positive phi w := phi leaf w    the all-positive individual is derived,
                                               and root is not all-positive
```

Predicted to hold. The first carrier shows the union of the two premise packages is
consistent. The pair shows that, with the grounding side held fixed, Scott's package does not
determine where its distinguished individual sits in the grounding order.

## 6. What each outcome would mean, stated in advance

```text
all of 5.1 to 5.7 hold     over a LOGOS frame and under full comprehension, A1, A2 and A5
                           with back-access at the actual world force the single-successor
                           frame. Scott's package sits on the position that denies W. The
                           all-positive predicate, A3 and A4 play no part in putting it
                           there. The union with the foundation package is consistent and
                           degenerate: the grounding side contributes what A0-A2 already
                           give, and the position of the distinguished individual in the
                           grounding order is undetermined. STATUS lists Scott's package
                           under the denial of W and records full comprehension as the
                           commitment the placement depends on.

5.1 fails                  D2 or D3 is mis-specified, or the essence built in the argument
                           is not one. A specification failure, recorded, not repaired by
                           changing the definitions after the fact.

5.3 fails from the core    the paper argument was wrong and A3 or A4 is needed. The theorem
record                     is restated against the weakest record that works, the prediction
                           of idleness is recorded as refuted, and 5.5 gains a model for
                           each axiom that turned out to be needed.

5.3 needs more than        the frame premise was under-specified. Recorded, and the
BackAccess                 NoBackAccess model is re-examined, since it would then be too weak
                           a witness.

an independence model      that premise is redundant given the others. 5.3 is restated
cannot be built            without it and the redundancy is reported as the finding.

the consistency witness    the full package is inconsistent in this embedding. That would be
fails                      a much larger claim than anything expected, would contradict the
                           published consistency result, and is investigated as a probable
                           error in section 3 before anything is said.

5.7 LeafCarrier fails      Scott's package constrains grounding position after all.
                           Unexpected; investigated before anything is claimed, not
                           reported as a bridge.

axiom use differs          recorded in the audit and in section 10. The statements stand.
```

## 7. What this does not establish

Nothing about an absolute, a God, or any theological notion, and nothing about whether any
individual has all positive properties.

Nothing about whether Scott's argument is sound. The cut takes his premises as premises. It
does not show them false or inconsistent; 5.5 shows the opposite of inconsistent.

Nothing about Goedel's original axioms, and nothing about the variants that avoid modal
collapse. Whether a collapse-free variant can stand beside `W` is a separate question and is
the natural successor of this cut.

Nothing under a general semantics. **The placement depends on full comprehension.** The
argument of 5.1 quantifies over a property that mentions a particular world. A reader who
holds that property variables range only over properties expressible in the object language
of higher-order modal logic, where no world is nameable, is untouched by 5.1 and 5.3. What
survives for that reader is the published collapse schema for expressible formulas, which
this cut does not re-derive. Whether the denial of `W` survives there depends on whether
existence is expressible, which it is under actualist quantification and identity; that
argument is not formalised here and is not claimed.

Nothing new about `W`. It is not shown true or false. A package that denies it is placed on
the map as consistent.

`positive` is an uninterpreted primitive. The cut gives it no reading and needs none. 5.7
shows how little the axioms say about it: over a one-world frame any individual may be chosen
and everything that individual has may be called positive.

## 8. Boundary

```text
NO A0-A8 as a premise of any GoedelScott module
NO God predicate        NO theological predicate     NO physical predicate
NO TWIST-J              NO mathlib                   NO arithmetic
NO new premise on the grounding line or the semantic line
NO use of ConstitutedTotality or TotalityRequiresMembers
NO interpretation of positive
NO identification of the all-positive individual with any root, ground or explanatory source
NO claim under restricted comprehension
NO claim about Goedel's original axioms, or about the variants of Anderson or Fitting
NO global axiom; the only new structures are Carrier, ScottCoreAxioms, ScottAxioms
NO change to any existing theorem signature or existing Lean module
```

Structural requirements.

The `GoedelScott` modules import `Logos.Logic` and each other and nothing else. No module of
the grounding line or the semantic line imports them.

The seam module is `Logos/Models/Seam/ScottGrounding.lean`. It is a leaf: nothing imports
it except `Logos.lean`. The existing guard on `Logos.Models.Seam` already enforces this for
every module under `Logos/`.

**One existing guard is amended, and this is a review item.** The CI step "Reject imports of
the totality constitution cut outside its own modules" rejects any importer of those modules.
The seam must import them to state its result in terms of `ContingencyWitness` and
`SingleSuccessor` rather than in unfolded copies of them. `TOTALITY-CONSTITUTION-CONTRACT.md`
section 8 restricts importers "in this cut", so the contract of that cut is not broken, but
the guard and the boundary line in `STATUS` are stricter than that contract. The amendment
adds exactly one path, the seam module, to the guard's exemption list, and a new guard
rejects `ConstitutedTotality` and `TotalityRequiresMembers` in the seam module so that the
exemption cannot leak the constitution law. If the owner rejects the amendment, the fallback
is to state 5.6 in unfolded form with no import, and that is recorded as a departure.

## 9. Acceptance tests

```text
T1   lake build succeeds from the pinned toolchain
T2   no sorry, sorryAx or native_decide anywhere
T3   #print axioms on every result reports at most propext, Classical.choice, Quot.sound;
     5.1 is checked individually for no axioms
T4   5.1 has no axiom record among its hypotheses
T5   5.3 is stated against ScottCoreAxioms and BackAccess at the designated world
T6   T3 in 5.4 takes A3 as a separate hypothesis; positive_rigid is referred to by no theorem
     outside the models and the definition of ScottAxioms
T7   the five carriers of 5.5 are exhibited; each independence model is proved to satisfy
     every axiom but the dropped one and to refute SeesOnlyItself
T8   each non-redundancy theorem quantifies over all frames, carriers and designated worlds
T9   the two carriers of 5.7 are over one and the same grounding model
T10  static guard: no axiom declaration in the new files, and exactly three structure
     declarations in the GoedelScott modules
T11  static guard: GoedelScott modules import only Logos.Logic and Logos.*GoedelScott
T12  static guard: nothing under Logos/ imports a GoedelScott module except GoedelScott
     modules and the seam
T13  static guard: the seam module mentions neither ConstitutedTotality nor
     TotalityRequiresMembers
T14  static guard: no theological token in the new Lean files
T15  git diff on pre-existing files is confined to import lines in Logos.lean and to
     .github/workflows/lean.yml
T16  the audit file and every guard are wired into CI in the same pull request
```

## 10. Outcome

Added after implementation. Sections 0 to 9 are unchanged and were committed before any Lean
for the cut existed.

```text
5.1   holds; no axioms, and no axiom record among the hypotheses
5.2   holds; classical
5.3   holds from ScottCoreAxioms and BackAccess at the designated world; classical through 5.2
5.4   holds; collapse is a corollary of 5.3; T3 takes A3 as a separate hypothesis;
      "T3 is free" needs no A3
5.5   all five carriers exhibited; each independence model satisfies every axiom but the
      one dropped, A3 and A4 included; four non-redundancy theorems over all frames,
      carriers and designated worlds
5.6   all six statements hold, for an arbitrary dom; classical through 5.3
5.7   holds; see the first departure below
```

By section 6 that is the first row. Over a LOGOS frame and under full comprehension, A1, A2
and A5 with back-access at the actual world force the single-successor frame. Scott's package
sits on the position that denies `W`. The all-positive predicate, A3 and A4 play no part in
putting it there: `positive_rigid` is referred to by no theorem, and `PositiveAllPositive` only
by T3. The union with the foundation package is consistent and degenerate, and the position of
the distinguished individual in the grounding order is undetermined.

Axiom use is as predicted. 5.1 and its corollary depend on no axioms. The consistency witness
and the three models over the full two-world frame depend on no axioms. `NoBackAccess` and the
grounding model of 5.7 report `propext`, which is the cost of defining a relation by matching
on an inductive type and is inside the permitted set.

Three departures, recorded rather than absorbed.

**5.7 is one family of carriers, not two separately defined ones.** `carrierAt chosen` takes
the entity whose properties are called positive, and `scottAxioms_carrierAt` proves the full
package for every choice. `RootCarrier` and `LeafCarrier` of section 5.7 are its two instances.
The statement is therefore more general than the target: over that grounding model any entity
whatever can be made the all-positive individual.

**The inventory of section 2 was incomplete.** Six definitions were added that it does not
list: the five named propositions `PositiveNeg`, `PositiveMono`, `PositiveAllPositive`,
`PositiveRigid` and `PositiveNecInstantiated`, so that an independence statement can name a
single axiom, and `haecceity`, which names the property section 5.1 wrote inline. None is a
structure and none adds a premise; the two records are built from the five propositions.

**One sentence of section 3 had no target behind it.** It says back-access is strictly weaker
than symmetry. `NoBackAccess.backAccess_at_b` and `NoBackAccess.not_symmetric` now witness
that on the frame the cut already had. It should have been a line of section 5.

One thing the implementation makes plain and the contract understated. By 5.1, A5 under full
comprehension says that being at a world which accesses nothing but itself is positive. T1
then puts such a world within reach, and back-access brings it home. So the conclusion sits
close to the premise, and the distance between them is exactly full comprehension and
back-access. The independence set shows A5 is not redundant and not a renaming of the other
axioms; it does not show that A5 is far from what it is used to prove, and no independence
set can.

Nothing in section 7 changes. The placement depends on full comprehension, `positive` has no
reading, nothing is shown about the soundness of Scott's argument, about the variants that
avoid modal collapse, or about whether `W` is true.
