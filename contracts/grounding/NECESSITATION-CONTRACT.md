# NECESSITATION-1 DESIGN CONTRACT

Status: **PROPOSED CUT CONTRACT - IN REVIEW**.

Base: `main` at `c94d6cb`, with the documentation restructure of PR #38 on top. That PR changes
no Lean source.

Local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 0. Provenance

Read this before treating the contract as a preregistration.

The question of this cut came out of a review of the whole programme on 2026-09-22. In that
review, before this contract was written, a scratch Lean file outside the repository proved a
version of the totality-side result. It used a stronger, per-source form of necessitation. It
worked through the constitution law and `W`. And it checked that the accepted model
`Witnessed.NecessaryExplainer` escapes only because its explanation does not necessitate. For
the totality side, this run is therefore **not a blind preregistration**: a proof of a stronger
variant was known.

Nothing else in section 5 had been written or run. That covers the foundation side, the
full-ground form of necessitation, the law-free and `W`-free statements, the equivalence form and
every model. Targets there may fail. If one does, the failure is recorded here and in the pull
request as a result. Section 6 says in advance what each outcome would mean.

## 1. Motivation

Both routes of the programme end in a necessary source of something contingent. The foundation
route ends in a necessary ungrounded entity that grounds the rest. The totality route ends,
under local sufficient explanation, in a necessary source that explains the fact that all
contingent things exist.

Neither route says anything about how the source relates to what it grounds or explains across
worlds. `directGrounds` and `explainsFact` are primitive relations with no modal law. So the
formal layer leaves open whether the source *necessitates* its target: whether, wherever the
source exists, the target exists or obtains too.

That gap carries weight. A necessitating link from a necessary source makes its target
necessary. If every link from the necessary to the contingent necessitates, then nothing is
contingent and `W` fails. This is the modal collapse argument against the principle of
sufficient reason (van Inwagen), and it is the standard objection to exactly the totality route.
It is invisible on `main` today, because nothing constrains the modal behaviour of the link.
The accepted model `Witnessed.NecessaryExplainer` satisfies the core, local sufficient
explanation and `W` only because its explanation does not necessitate.

So the cut has one question:

> What happens to each route when the link from source to target is required to necessitate?

## 2. Claim type

```text
formal definition   GroundingNecessitates, ExplanationNecessitates
proved theorem      5.1, 5.2, 5.3
countermodel        5.4 and 5.5 (new models, and reuse of accepted ones)
interpretation      section 7 only
```

`GroundingNecessitates` and `ExplanationNecessitates` are **premises**. They are stated as
`Prop`s and appear only as hypotheses of the theorems of this cut. They are never asserted
globally, never added to an accepted record, and never used outside the cut.

## 3. Language

Inherited: `Model`, `FactModel`, `RegressTotality`, `FactGroundingRoles`,
`EntityExplanationModel`, `TotalityExplanationCore`, `NecessaryExistenceAxioms`, and the
predicates `Actual`, `Necessary`, `Contingent`, `Derived`, `Ungrounded`, `ActualGrounds`,
`NecessaryFact`, `ExplainedFact`, `ActualExplainsFact`, `ContingentExplanatoryAbsoluteFact` and
`LocalFactSufficientExplanation`.

New definitions, in one ontology module:

```text
GroundingNecessitates M :=
    forall x, Derived M x ->
      box M.frame
        (fun w => (forall a, ActualGrounds M a x -> M.existsAt w a) -> M.existsAt w x)
        M.actual

ExplanationNecessitates G p :=
    ExplainedFact G p ->
      box M.frame
        (fun w => (forall a, ActualExplainsFact G a p -> M.existsAt w a) -> F.holdsAt w p)
        M.actual
```

Four deliberate choices.

**Full ground, not single ground.** The antecedent is that *all* actual immediate grounds of
`x` exist, not that some one of them does. This is the weaker premise, and it is the reading of
grounding usually called grounding necessitarianism: a full ground necessitates what it grounds.
A single immediate ground may be partial and need not necessitate anything. The per-ground form
implies the full-ground form, so every result proved from the full-ground form also holds under
the per-ground form.

**The full ground is the plurality of actual immediate grounds.** Someone who holds that a full
ground also includes a further fact, for instance that these are all the grounds, reads the
plurality alone as less than a full ground. For that reader `GroundingNecessitates` is stronger
than grounding necessitarianism. The same holds for the explanatory sources in
`ExplanationNecessitates`.

**Explanation is local and conditional.** `ExplanationNecessitates` speaks about one fact, and
only when that fact is explained. An unexplained fact satisfies it vacuously. This matches the
local form of sufficient explanation the core uses.

**Rigid sources.** The grounds and sources are fixed at the actual world. The premise says that
*these* sources necessitate the target, not that whatever grounds the target at another world
does.

The cut does not use the constitution law or `ContingencyWitness`. Both are confined to
`totality-constitution-1` by its contract and by CI. Where a result of this cut says "every
actual entity is necessary", that is the denial of `W` written out. Section 5.6 says what
composing with the constitution law would give and why it is not done here.

## 4. Assumptions

`GroundingNecessitates` and `ExplanationNecessitates` as above, as hypotheses only. On the
foundation side the fields A1, A2, A4 and A5 of the accepted records appear as separate
hypotheses, with the types they have in `FoundationAxioms` and `NecessaryExistenceAxioms`, so
that A0 can be left out. No new `structure`, `class` or `axiom` anywhere in the cut.

## 5. Targets

### 5.1 A necessitating link from necessary sources

```text
GroundingNecessitates M  ->  Derived M x  ->
    (forall a, ActualGrounds M a x -> Necessary M a)  ->  Necessary M x

ExplanationNecessitates G p  ->  ExplainedFact G p  ->
    (forall a, ActualExplainsFact G a p -> Necessary M a)  ->  NecessaryFact F p
```

Predicted to hold without axioms. This is distribution of the box and nothing more.

### 5.2 Foundation route: necessitating grounding is necessitarianism

```text
A1 -> A2 -> A4 -> A5 -> GroundingNecessitates M  ->  forall x, Actual M x -> Necessary M x
A1 -> (forall x, Actual M x -> Necessary M x)  ->  GroundingNecessitates M
```

The first is predicted to hold by well-founded induction along A2. At a derived entity, A1 makes
every actual ground actual, the induction hypothesis makes it necessary, and 5.1 finishes. At an
ungrounded entity, A4 and A5 give necessity as in `ungrounded_is_necessary`. A0 is predicted to
be unnecessary. The ungrounded case is predicted to need classical logic; that use is recorded.

The second is predicted to hold without axioms, using only A1.

Together, under A1, A2, A4 and A5, `GroundingNecessitates M` is equivalent to every actual entity
being necessary. A corollary states the first direction against `NecessaryExistenceAxioms`.

### 5.3 Totality route: necessitating explanation is necessity of the totality fact

```text
TotalityExplanationCore M F G E R  ->  ExplanationNecessitates G R.totality  ->
    NecessaryFact F R.totality  \/  ContingentExplanatoryAbsoluteFact G R.totality

...  ->  LocalFactSufficientExplanation G R.totality  ->  NecessaryFact F R.totality

NecessaryFact F p  ->  ExplanationNecessitates G p
```

The first is predicted to hold through the accepted trichotomy: its middle disjunct collapses
into the first by 5.1 and `totality_explainer_is_necessary_from_core`. The second follows. Both
are predicted to need classical logic through the accepted results they use.

The third is predicted to hold without axioms and without any premise.

Together, under the core and local sufficient explanation, `ExplanationNecessitates G R.totality`
is equivalent to `NecessaryFact F R.totality`. No constitution law, no `W`, no A2.

### 5.4 Independence, foundation side

For the first statement of 5.2, one model for each hypothesis, satisfying the other three
hypotheses and `GroundingNecessitates` while some actual entity is not necessary:

```text
UnactualGround         A1 fails   an actual contingent entity grounded by an entity that
                                  does not actually exist
NecessitatingRegress   A2 fails   an infinite descending chain of contingent entities,
                                  each grounded by the next
bruteModel (accepted)  A4 fails   an actual, ungrounded, non-necessary entity
NoSelfAccess           A5 fails   the actual world does not access itself
```

Each comes with a non-redundancy theorem quantifying over all models in `Type`.

Both sides of the equivalence are inhabited under A1, A2, A4 and A5:

```text
freeCreationModel (accepted)   some actual entity is not necessary; grounding does not
                               necessitate
NecessaryCreation              every actual entity is necessary and grounding necessitates,
                               on a frame with two accessible worlds
```

`NecessaryCreation` must not live on a frame where the actual world accesses only itself, so
that its necessity is not degenerate.

### 5.5 Independence, totality side

For the second statement of 5.3, one model for each hypothesis, satisfying the other two while
the totality fact is not necessary:

```text
NonNecessitatingExplainer   ExplanationNecessitates fails   a necessary source explains a
                                                            totality fact that fails at a
                                                            world where the source exists
BruteTotality (accepted)    local sufficient explanation    the totality fact is unexplained,
                            fails                           so necessitation holds vacuously
SelfCitingExplainer         the core fails                  a contingent member explains the
                                                            totality fact and necessitates it
```

Each comes with a non-redundancy theorem quantifying over all models in `Type`.

Both sides of the equivalence are inhabited under the core and local sufficient explanation:
`NonNecessitatingExplainer` on the non-necessitating side, and a model `NecessaryTotality` on
the other, where the totality fact is necessary and explained.

`NonNecessitatingExplainer` has the shape of the accepted `Witnessed.NecessaryExplainer`. It is
rebuilt rather than imported, because that model lives in a module whose importers
`totality-constitution-1` confines.

Every new model states whether some actual entity is not necessary, written out as
`exists x, Actual M x /\ not Necessary M x`.

### 5.6 What composition with the constitution law would give

This is not a Lean target of the cut. It is written here so the cut does not overstate itself.

Under the constitution law and completeness, `NecessaryFact F R.totality` is equivalent to the
denial of `W` (`necessaryFact_iff_not_contingencyWitness`, accepted). Composing that with 5.3
reads: under the core, the law, local sufficient explanation and necessitating explanation, `W`
fails. The composition is two steps of propositional logic. Stating it in Lean would make a
result outside `totality-constitution-1` depend on its law, which that cut's boundary forbids.
It is left as a reading. Amending the confinement would be a separate, reviewed change.

## 6. What each outcome would mean, stated in advance

```text
all of 5.1 to 5.5 hold    on each route, a necessitating link from the necessary
                          source is equivalent to the collapse of contingency on
                          that route: every actual entity is necessary on the
                          foundation route, and the totality fact is necessary on
                          the totality route. Given W, both routes reach a
                          necessary reality only with a link that does not
                          necessitate. STATUS gains a live question on
                          non-necessitating links, and MAP records the constraint
                          on the necessary-reality position.

5.2 needs A0              A0 is recorded as load-bearing; no change to the target.

5.2 fails in the          the result needs the stronger per-ground premise. That is
full-ground form but      a change of premise and is recorded as one: the theorem
holds per ground          is stated with the per-ground premise, and the gap is a
                          result about what grounding necessitarianism alone gives.

a model of 5.4 or 5.5     the corresponding hypothesis is redundant. The theorem is
cannot be built           restated without it, and the redundancy is reported as a
                          result, not absorbed.

5.3 needs the law or W    the totality side does not collapse at the level of the
                          fact; a specification error in section 3, recorded and
                          not repaired by weakening the target.

BruteTotality fails       ExplanationNecessitates is not vacuous on unexplained
ExplanationNecessitates   facts, which contradicts its definition; a specification
                          error, recorded.

5.2 or 5.3 turn out       recorded in the audit; no change to the statements.
constructive, or 5.1
needs axioms
```

## 7. What this does not establish

Nothing about an absolute, a God, or any theological notion.

Nothing about whether grounding or explanation necessitates. The two definitions are premises
of this cut's theorems and nothing more. The result is conditional in both directions: *if* the
link necessitates, contingency collapses on that route; *if* `W` holds, the link does not
necessitate.

Nothing about whether a non-necessitating link is coherent, adequate, or itself a brute element.
Suppose a necessary source explains a contingent totality fact without necessitating it. Then
there is an accessible world where the source exists and the fact fails. Whether the source
*adequately* explains why the fact obtains rather than fails is exactly the question the cut
opens. It does not answer it.

Nothing about `W`, the constitution law, or which position of `MAP.md` section 1 is correct.

No novelty is claimed for the argument itself. The modal collapse argument is known. What the
cut adds is its placement in LOGOS: it applies to both routes, and on the foundation route it
needs only the full-ground reading of grounding.

## 8. Boundary

```text
NO constitution law            NO ContingencyWitness import; W appears only written out
NO A0 in 5.2                   NO A3 / A6-A8 anywhere in the cut
NO God predicate               NO theological predicate          NO physical predicate
NO Goedel-Scott                NO TWIST-J                        NO mathlib
NO new structure, class or axiom
NO global assertion of GroundingNecessitates or ExplanationNecessitates
NO modal-layer vocabulary of grounded-modality-1 in the cut's Systems module
NO change to any existing theorem signature or existing module
NO claim that grounding or explanation necessitates, or that it does not
```

Structural requirement: the new modules are leaves. Nothing on `main` imports them, and only
`Logos.lean` and the cut's audit file may import them.

## 9. Acceptance tests

```text
T1   lake build succeeds from the pinned toolchain
T2   no sorry, sorryAx or native_decide in the new files
T3   #print axioms on every result reports at most propext, Classical.choice,
     Quot.sound; the results predicted axiom-free in section 5 are checked
     individually and recorded
T4   5.2 and 5.3 are stated over arbitrary models, not over any construction
T5   the foundation hypotheses of 5.2 have exactly the types of the accepted
     record fields, and A0 does not occur in the first statement of 5.2
T6   every model of 5.4 and 5.5 is exhibited with each premise proved and the
     failing premise refuted explicitly
T7   each non-redundancy theorem quantifies over all models in Type
T8   NecessaryCreation has at least two worlds accessible from the actual world
T9   static guard: no structure, class or axiom declaration in the new files
T10  static guard: no module outside the cut imports it, except the audit file
T11  static guard: no constitution-law or ContingencyWitness token in the new files
T12  no existing theorem signature changes; git diff on pre-existing Lean files is
     confined to Logos.lean import lines
T13  the audit file and the static guards are wired into CI in the same PR
```

## 10. Outcome

Added after implementation. Sections 0 to 9 are unchanged since the contract commit.

```text
5.1   holds; both statements axiom-free
5.2   holds; the forward direction classical (the ungrounded case), the converse
      axiom-free and using A1 only; A0 unused; the corollary against
      NecessaryExistenceAxioms is present
5.3   holds; the first two statements classical through the accepted trichotomy
      and engine; the converse axiom-free and premise-free
5.4   all four models exhibited, each with a non-redundancy theorem over all
      models in Type; freeCreationModel and NecessaryCreation inhabit both sides
5.5   all three models exhibited, each with a non-redundancy theorem over all
      models in Type; NonNecessitatingExplainer and NecessaryTotality inhabit
      both sides
T1-T13  pass; the axioms of every result are printed by
      Logos/NecessitationAudit.lean, and the only change to pre-existing Lean
      is three import lines in Logos.lean
```

By section 6 that is the first row on the foundation route. On the totality route the first
row says more than the cut shows; see correction 1.

An independent review of the implementation, done before any Lean of the cut was pushed, found
the following. Each is recorded here rather than absorbed.

**1. On the totality route the reading against `W` needs the constitution law.** Sections 1, 6
(first row) and 7 say that, given `W`, a necessitating link is excluded on both routes. On the
totality route the cut shows only that necessitating explanation makes the totality fact
necessary (5.3). Without a law tying that fact to its members, the core, local sufficient
explanation and necessitating explanation hold together with `W`: the model
`LawlessNecessitation`, added after review, and `law_needed_for_W_reading`, stated over all
models. With the law, the step to the denial of `W` is the accepted
`necessaryFact_iff_not_contingencyWitness` (section 5.6), which this cut does not formalise.
So the first row of section 6 holds on the foundation route as written, and on the totality
route only under the constitution law.

**2. On the totality route the equivalence is close to a renaming.** Under the core every
explainer of the totality fact is already necessary. So `ExplanationNecessitates G R.totality`
says exactly that the totality fact, if explained, is necessary
(`explanationNecessitates_iff_explained_imp_necessaryFact`, added after review). Rigid sources
and the plurality of sources do no work on that route, and 5.3 is one step on top of the
accepted trichotomy. The foundation route is different in kind. Its forward direction is a
well-founded induction, and the four models of 5.4 have necessitating grounding together with an
actual entity that is not necessary.

**3. A weaker premise suffices on the foundation route.** The induction uses necessitation only
at links whose actual grounds are all necessary. `actual_necessary_of_necessary_links`, added
after review, states the result from that weaker premise, and
`actual_necessary_of_groundingNecessitates` is its corollary. That form is what the phrase "a
necessitating link from the necessary source" in section 6 describes.

**4. Models changed after review.**
- `UnactualGround` uses three worlds, so its necessitation is not vacuous
  (`ground_exists_somewhere`).
- In `SelfCitingExplainer` the root exists at no world. Source actuality and completeness then
  hold, and the core fails at adequacy alone (`explains_source_actual_holds`,
  `covers_nonNecessary_holds`, `adequacy_fails`).
- A non-redundancy theorem for necessitation itself on the foundation side was added,
  `groundingNecessitates_needed`, from the accepted `freeCreationModel`.

**5. Section 3 overstates one confinement.** It says `ContingencyWitness` is confined to
`totality-constitution-1` "by its contract and by CI". That cut's contract confines the law
explicitly. `ContingencyWitness` is confined only by the import guard on its module, and the
Scott seam imports that module under an exemption. The cut avoids both either way.

**6. Names.** The accepted `BruteTotality` used in 5.5 is `FactSufficientExplanation.BruteTotality`.
A namespace with the same name exists in `Logos.Models.Grounding.ContingentAbsolute`.
`NecessaryCreation` keeps the contract's name, but its `created` predicate is empty and the
name refers to grounding only.

**7. Vacuity, recorded.** `Brute` and `NoSelfAccess` satisfy necessitation because nothing in
them is grounded. `NoSelfAccess` satisfies A4 because nothing is possible from its actual world.
That is enough for non-redundancy, and their docstrings say so.

What the cut establishes, relative to its premises:

```text
foundation route   under A1, A2, A4, A5: necessitating grounding  <->  every actual
                   entity is necessary; necessitation at links out of necessary
                   grounds already suffices for the forward direction
totality route     under the core: necessitating explanation  <->  (explained ->
                   the totality fact is necessary)
                   with local sufficient explanation as well:  <->  the totality
                   fact is necessary
                   the further step to not W needs the constitution law (5.6);
                   without it W survives (LawlessNecessitation)
```

Read against `W`, which is a reading and not a theorem of the cut: whoever holds A4 and `W` must
hold that grounding out of the necessary root does not necessitate. Whoever holds local
sufficient explanation, the constitution law and `W` must hold that the explanation of the
totality fact does not necessitate it.
