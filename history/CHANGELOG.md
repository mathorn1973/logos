# CHANGELOG

Chronological record of the programme, cut by cut.

This file was assembled in the documentation restructure that introduced `MAP.md`. Its per-cut
records are the sections of `STATUS.md` and the cut descriptions of `README.md` as they stood at
`c94d6cb`, moved here verbatim so that `STATUS.md` can describe the current state only and
`README.md` can state the question and the answer. Nothing of substance was removed: the old
navigation text of `README.md` (its cut list header, "See also" list and status line) was
replaced by the new `README.md`, and everything else is here. Headings inside moved sections
were demoted, and contract file names in them now refer to files under `contracts/`. No theorem
statement changed.

Each record keeps the vocabulary of its time. `MAP.md` section 10 maps retired premise names to
their current counterparts. Records of cuts promoted after the restructure are written here
directly, at each cut's closure.

Pull request numbers are those of the cut PRs; a closure PR follows each cut. `#8` to `#10`
were stacked on `#7` and reached `main` through it.

## Grounding line

### 1. modal-foundation-1 (PR #1)

`modal-foundation-1` - Kripke semantics for necessity, possibility, contingency, and standard modal principles under exact frame hypotheses.

Contract: `contracts/grounding/DESIGN-CONTRACT.md`.

### 2. finite-countermodels-2 (PR #3)

`finite-countermodels-2` - explicit finite frames, pointed refutations, and a genuine contingency witness.

Contract: `contracts/grounding/FINITE-COUNTERMODELS-CONTRACT.md`.

### 3. absolute-ground-1 (PR #4, closure #11)

`absolute-ground-1` - a grounding language, explicit A0-A8 assumption records, the minimal necessary-ground theorem, and independence/countermodels delimiting its assumptions.

Contract: `contracts/grounding/ABSOLUTE-GROUND-CONTRACT.md`.

Record from `STATUS.md`:

`absolute-ground-1` is on protected `main`.

```text
A0 + A1 + A2 + A4 + A5
        ->
some actual ungrounded entity exists necessarily
```

`NecessaryExistenceAxioms` contains A0-A2 and A4-A5. A3 is absent and is used only for uniqueness and universal ancestry. A6-A8 are separate extensions and are not premises of the minimal theorem.

### 4. totality-regress-1 (PR #5, closure #12)

`totality-regress-1` - a separate fact carrier and an A2-free totality route showing that pure contingency is impossible under explicit fact-sufficient-ground, externality, and completeness commitments.

Contract: `contracts/grounding/TOTALITY-REGRESS-CONTRACT.md`.

Record from `STATUS.md`:

`totality-regress-1` is on protected `main`.

Its load-bearing package is:

```text
F4  actual non-necessary facts are entity-grounded
E   a ground of the regress-totality fact is outside the represented regress
C   every actual non-necessary entity is inside the represented totality
```

Lean proves:

```text
NecessaryFact(totality)
OR
exists an actual necessary entity outside the regress grounding the totality fact
```

No A2/well-foundedness or A3/unity premise occurs in this theorem. This route does not prove that the necessary witness is ungrounded; `route-seam-1` pins that by countermodel.

The accepted independence suite shows that pure contingency survives if any one of F4, E, or C is removed.

### 5. totality-externality-1 (PR #6, closure #13)

`totality-externality-1` - a role split between constitution and explanation, a premise-order audit for F4/EF4 and E/E_expl, and a derived-externality theorem from explanatory scope plus irreflexivity.

Contract: `contracts/grounding/TOTALITY-EXTERNALITY-CONTRACT.md`.

Record from `STATUS.md`:

`totality-externality-1` is also on protected `main`.

It separates primitive constitutive and explanatory fact roles and introduces:

```text
EF4    actual non-necessary facts have an explanatory source
E_expl an explanatory source of the totality fact lies outside the represented regress
G      ExplanationImpliesGrounding
S      an explanation of the totality covers every entity inside its claimed scope
I      no actual entity explains itself
```

The verified premise-order map is:

```text
without G:
  F4 and EF4 are independent
  E and E_expl are independent

with G:
  EF4 is strictly stronger than F4
  E_expl is strictly weaker than E
```

Thus `totality-externality-1` is not a net premise reduction. It factors one commitment while exposing that the sufficient-ground axis has moved from generic F4 to stronger EF4 under the natural bridge G.

The deepest accepted theorem uses:

```text
EF4 + S + I + C
```

and proves:

```text
NecessaryFact(totality)
OR
exists an actual necessary explanatory source outside the represented regress
```

Its negative boundary is explicit:

```text
NO A2 / well-foundedness
NO A3 / common-ground premise
NO old E
NO ExternalRegressTotalityAxioms
NO primitive E_expl in the deep theorem
NO ExternalExplanationAxioms conversion in the deep theorem source
NO A6-A8
```

Dedicated type-level and static CI audits enforce this boundary.

### 6 to 10. The explanation line (PRs #7 to #10 stacked, PR #18, closure #19)

`self-explanation-1` - reduction of explanatory irreflexivity first to contingent propriety and then to a local adequacy condition on the totality explanation alone.
`fact-sufficient-explanation-1` - removal of EF4 from the core, and the resulting three-way fork in which a contingent explanatory absolute is a live option.
`contingent-absolute-1` - the modal reading of that option, and the recorded finding that deriving necessity from explanatory ultimacy is equivalent to local EF4.
`grounded-modality-1` - modal conditions as a carrier separate from entities and explanatory sources, with the recorded finding that the axis does not close the fork.
`carrier-schema-1` - the closure argument stated for an arbitrary carrier, with the accepted route shown to be an instance of it.

Contracts: `contracts/grounding/SELF-EXPLANATION-CONTRACT.md`, `FACT-SUFFICIENT-EXPLANATION-CONTRACT.md`, `CONTINGENT-ABSOLUTE-CONTRACT.md`, `GROUNDED-MODALITY-CONTRACT.md`, `CARRIER-SCHEMA-CONTRACT.md`.

Record from `STATUS.md`:

Cuts `self-explanation-1` through `carrier-schema-1` are on protected `main`.

The core no longer asserts that an explanation exists:

```text
TotalityExplanationCore
    ES   a source explaining the actual totality fact is itself actual
    LA   the totality explanation adequately explains each actual member in scope
    C    every actual non-necessary entity is inside the represented totality
```

Lean proves the three-way fork:

```text
NecessaryFact(totality)
OR  an actual necessary explanatory source explains the totality fact
OR  ContingentExplanatoryAbsoluteFact(totality)
```

and the equivalence that fixes the cost of the third disjunct:

```text
local EF4 at the totality fact
    IFF
no contingent explanatory absolute at the totality fact
```

Two recorded failures, kept because they are results:

```text
contingent-absolute-1
    explanatory ultimacy -> necessity  IFF  local EF4
    so that route is not independent of EF4

grounded-modality-1
    no-brute-modality + modal unconditionedness  IFF  actual + necessary
    so the implication partitions necessity rather than deriving it
    and ConditionedBrute satisfies no-brute-modality together with a
    contingent explanatory absolute
```

The carrier-neutral engine:

```text
closure_explainer_is_necessary
    ScopeClosureAxioms K -> K.Explains a -> K.Necessary a

escape_requires_exemption
    K.Explains a -> not K.Necessary a -> not ScopeClosureAxioms K
```

with `TotalityExplanationCore` proved to instantiate `ScopeClosureAxioms`, and three one-item countermodels showing completeness, scope and adequacy are each separately load-bearing.

Negative boundary of the line:

```text
NO closure of the fork; a contingent explanatory absolute remains available
NO claim that any particular carrier exemption is illegitimate
NO claim that the three closure conditions are exhaustive
NO derivation of necessity from explanatory ultimacy
NO joining of the modal layer to the totality argument
     (enforced by a static CI guard)
NO theological or physical predicate anywhere in the line
```

Narrative from `README.md`, "Where the explanation line ended":

Cuts 6 to 10 took the totality route as far as the present language allows. The outcome is a mapped fork, not a closure, and two attempts at closing it are recorded as failures rather than removed.

EF4 is no longer a premise of the core. `TotalityExplanationCore` contains only source actuality, local explanatory adequacy and completeness, and asserts no principle that an explanation must exist. From it Lean proves:

```text
NecessaryFact(totality)
OR
an actual necessary explanatory source explains the totality fact
OR
the totality fact is a contingent explanatory absolute:
  actual, non-necessary, and unexplained
```

The third disjunct is the surviving opponent position. Two routes to removing it were tried:

- `contingent-absolute-1` tested the claim that an explanatorily ultimate fact must be necessary. At the designated actual fact that claim is provably equivalent to local EF4. It is not an independent route around EF4; it is EF4 restated in modal-stability form. Any future argument from ultimacy to necessity must add genuinely new structure rather than rename the old premise.
- `grounded-modality-1` tested whether refusing to identify raw Kripke accessibility with metaphysically licensed possibility closes the position. It does not. The cut's own `ConditionedBrute` model satisfies no-brute-modality together with an unexplained, non-necessary totality fact. The cut's main implication also partitions necessity rather than deriving it: no-brute-modality together with modal unconditionedness is equivalent to actuality together with necessity.

`carrier-schema-1` then answers the general form of the worry those two cuts raise. The engine of the accepted route consults only five predicates of its sources, so it can be stated for an arbitrary carrier:

```text
escape_requires_exemption
    K.Explains a -> not K.Necessary a -> not ScopeClosureAxioms K
```

A contingent item can be offered as an explainer of the target only at a carrier exempted from completeness, scope or adequacy. Offering one from a fresh carrier therefore never dissolves the fork. Three one-item countermodels show each of the three conditions is separately load-bearing, and `TotalityExplanationCore` is proved to be an instance of the schema rather than an analogy to it.

The schema records that an item explains the designated target. It does not record that the item is itself unexplained, and it supplies no interpretation of `Explains` for an arbitrary fresh carrier, so it does not license the stronger reading that an unexplained item is being relocated.

The open question is consequently no longer "can a contingent explainer always be found somewhere fresh". It is: for a proposed carrier, which condition is it exempt from, and is that exemption principled or merely stipulated.

### 11. route-seam-1 (PR #16, closure #20, follow-up #21)

`route-seam-1` - the relation between the foundation route and the totality route, and the deflation of the `RegressTotality` record.

Contract: `contracts/grounding/ROUTE-SEAM-CONTRACT.md`.

Record from `STATUS.md`:

`route-seam-1` is on protected `main`.

Three findings, in order of weight.

**The record is weak.** `RegressTotality` carries an infinite descending grounding chain and
little else; its fact layer, designated fact and `inside` predicate are largely free data.

```text
exists_descending_chain_of_not_wellFounded
    not WellFounded (ActualGrounds M)
      -> exists f, forall n, ActualGrounds M (f (n+1)) (f n)

wellFounded_or_regressTotality
    WellFounded (ActualGrounds M) or Nonempty (RegressTotality M (bareFactModel M))

bare_totality_necessary
    NecessaryFact (bareFactModel M) R.totality
```

The last line is the deflation: the freely constructed witness satisfies the totality
conclusion by its first disjunct with no explanatory premise doing work.

**The presuppositions of the two routes are incompatible.**

```text
regressTotality_refutes_wellFoundedness      no axioms
regressTotality_refutes_foundationAxioms     no axioms
regressTotality_refutes_necessaryExistenceAxioms   no axioms
seam_bridge_is_vacuous                       no axioms
```

**The core fixes modality, not grounding.** `GroundedExplainer` inhabits
`TotalityExplanationCore`, sits on the middle disjunct of the accepted trichotomy, and has a
necessary explanatory source that is itself grounded.

```text
core_fixes_necessity_not_grounding
    every explainer of the totality fact is necessary
    and none of them is ungrounded, in that model
```

The accepted positive model gives the opposite grounding reading, so `Ungrounded(explainer)`
is undetermined by the core.

Negative boundary:

```text
NO claim that the two premise packages are exhaustive; both may fail
NO claim that either route applies whenever the other does not
NO unqualified reading of the totality conclusion as a necessary explanatory source
NO claim that the structural dichotomy supports either route
NO claim that the substantive totality premises are available whenever A2 fails
NO new axiom record; enforced by a static CI guard over the seam layer
```

Narrative from `README.md`, "How the two routes are related":

`route-seam-1` settles a question the two routes had left open by never being compared.

##### The record is weak

`RegressTotality` carries an infinite descending grounding chain. Beyond that, its fact
layer, its designated totality fact and its `inside` predicate are largely free data, so any
actual infinite descent can be dressed as one over a single always-obtaining fact. The record
captures a chain plus a label. Every substantive claim of the totality route arrives with the
premises stated over it, never from the record itself.

The point is made concrete rather than asserted: in the freely constructed witness the
totality fact obtains at every world, so the totality conclusion holds by its first disjunct
with no explanatory premise doing any work.

##### The presuppositions are incompatible

A2 is a field of the foundation package and is refuted by the mere presence of the record.

```text
RegressTotality M F -> not WellFounded (ActualGrounds M)
RegressTotality M F -> not NecessaryExistenceAxioms M
```

No model carries both premise packages, and a theorem stated over both is vacuous, which
`seam_bridge_is_vacuous` states outright. These theorems depend on no axioms at all.

This is a statement about presuppositions, not about conclusions. Well-foundedness against
the availability of a bare regress record is an exhaustive **structural** dichotomy. The
full premise packages of the two arguments are **not** exhaustive and may fail together:
well-founded grounding by itself supplies neither A0, A1, A4 nor A5, and the availability of
a regress record by itself supplies neither local sufficient explanation, nor adequacy, nor
completeness. "One route or the other applies" is not proved and is not true in general.

##### The core fixes modality, not grounding

Against `TotalityExplanationCore` the cut exhibits a model in which the explanatory source of
the totality fact is actual, necessary and outside the regress, and is nevertheless grounded
by a further necessary entity. The accepted positive model gives the opposite reading. So the
core determines the modal status of any source that explains the totality fact and determines
nothing about that source's position in the grounding order.

`AbsoluteGround`, which builds in `Ungrounded`, is therefore reachable only on the foundation
side. Whether the totality route's middle disjunct deserves the same name is a human question
the formal layer leaves open.

### 12. a4-fact-independence-1 (PR #24, amendment #25, closure #26)

`a4-fact-independence-1` - two countermodels under one hypothesis schema showing that A4 at the entity level and local sufficient explanation for the totality fact are two commitments, neither entailing the other.

Contract: `contracts/grounding/A4-FACT-INDEPENDENCE-CONTRACT.md`.

Record from `STATUS.md`:

`a4-fact-independence-1` is on protected `main`.

Two countermodels under one hypothesis schema, fixed before the models were built:

```text
RegressTotality M F
TotalityExplanationCore M F G E R
not NecessaryFact F R.totality
```

What is proved is exactly two non-entailments under that schema:

```text
A4 and A4' do not entail local EF4       witnessed by FactBruteEntityRegular
local EF4 does not entail A4 or A4'      witnessed by EntityBruteFactRegular
```

Both forms of the entity-level principle appear in both directions, the original A4 as well
as `NonNecessaryIsDerived`. The second model exhibits non-vacuity of local EF4 as two
separate facts, so the direction cannot be met by a principle that holds only because its
antecedent fails, and it satisfies the fact-level bridge `ExplanationImpliesGrounding`
rather than dispensing with it.

The gap the second direction does rely on is at the entity level:

```text
root_explains_stray_without_grounding
    AdequateExplainsEntity M E root stray and not ActualGrounds M root stray
```

The current language has no bridge from adequate explanation to ontological grounding for
entities. If one were added, that direction would have to be re-examined.

Negative boundary:

```text
NO claim that either principle is true
NO claim that the two principles exhaust the brute positions
NO claim about what any argument against one position reaches
NO claim about carrier extension in either direction
NO independence claim under a future entity-level explanation-to-grounding bridge
NO new axiom record, structure, class or axiom; enforced by a static CI guard
```

### 13. totality-constitution-1 (PR #33, closure #35)

`totality-constitution-1` - a constitution law saying what the totality fact is, under which the first disjunct of the trichotomy is necessitarianism about the actual world, and the presupposition `W` that removes it.

Contract: `contracts/grounding/TOTALITY-CONSTITUTION-CONTRACT.md`.

Record from `STATUS.md`:

`totality-constitution-1` is on protected `main`.

`route-seam-1` showed the designated totality fact is free data. This cut says what the
fact is, and both of its premises come first because neither is established:

```text
ConstitutedTotality F R    forall w, holdsAt w totality <-> forall x, inside x -> existsAt w x
ContingencyWitness M       exists x, Actual M x and not Necessary M x                  (W)
```

The law is a commitment about what the fact carrier records: membership is rigid, and the
totality is read as the joint existence of its members. It fixes `holdsAt` only and is
confined to the cut. `W` is the presupposition of the programme's question. A reader who
rejects the law is untouched by the totality-side results below.

Totality side:

```text
necessaryFact_iff_members_necessary                         no axioms
    law -> (NecessaryFact totality <-> forall x, inside x -> Necessary M x)

necessaryFact_iff_not_contingencyWitness                    classical in one direction
    law -> (forall x, Actual M x -> not Necessary M x -> inside x)
        -> (NecessaryFact totality <-> not W)

necessary_explainer_or_contingent_absolute                  classical, through the trichotomy
    TotalityExplanationCore -> TotalityRequiresMembers -> W
        -> a necessary explanatory source explains the totality fact
           or the totality fact is a contingent explanatory absolute

necessary_explainer_of_localEF4
    ... -> LocalFactSufficientExplanation G totality
        -> a necessary explanatory source explains the totality fact
```

`NecessaryFact totality -> not W` needs only the forward half of the law and no axioms. The
converse passes from `not not Necessary` to `Necessary` and is classical.

So under the law the first disjunct of the trichotomy is necessitarianism about the actual
world, and `W` removes it. This is a reduction of the trichotomy to a dichotomy under two
explicit premises. The remaining fork is exactly where `fact-sufficient-explanation-1` left
it, and local sufficient explanation is still what decides it.

Foundation side, all without axioms. `SingleSuccessor M` says the actual world accesses only
itself; the statements that need `A5` take it as a separate hypothesis:

```text
necessary_iff_actual_of_singleSuccessor                     Necessary M x <-> Actual M x
not_contingent_of_singleSuccessor                           not Contingent M x
necessaryExistenceAxioms_of_foundation_of_singleSuccessor   A0-A2 give the package; A4 is vacuous
exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor
not_singleSuccessor_of_contingencyWitness                   W -> not SingleSuccessor M
twoRoot_singleSuccessor                                     the accepted A3 witness is such a frame
```

No accepted premise package excludes that frame, so the modal content of
`exists_necessary_ungrounded` is supplied by the frame and by nothing in the premises. The
premises do not force the frame either: the accepted `freeCreationModel` satisfies A0-A7 and
`free_creation_refutes_actual_implies_necessary` holds there. The theorem is not weakened.
What is recorded is what its conclusion means on a frame the premises admit, and that the
two necessary roots of `twoRootModel` are necessary in that degenerate sense. The model
remains a valid witness for the independence of A3, which is what it was accepted for.

Independence set, all four under `TotalityExplanationCore`:

```text
Necessitarian        law and core and not W    first disjunct holds; frame is not single-successor
BareWitness          W and core and not law    first disjunct still holds; the law is load-bearing
NecessaryExplainer   law and core and W        middle disjunct inhabited; local EF4 holds
ContingentAbsolute   law and core and W        third disjunct inhabited; local EF4 fails
```

Three departures from the frozen contract are recorded in
`TOTALITY-CONSTITUTION-CONTRACT.md` section 10: the definitions are split across the ontology
and systems layers because the import firewall overrode a sentence of the contract; the
existential form of "W supplies another accessible world" is classical where the contract
predicted no axioms, the axiom-free content being `not_singleSuccessor_of_contingencyWitness`;
and the constraint that members are actual is visible as a named hypothesis of
`constitutedRegress`.

Negative boundary:

```text
NO claim that W is true
NO claim that the constitution law is forced, or that rigid membership is the only reading
NO claim that necessitarianism is refuted; it is placed on the map, consistent
NO closure of the fork, and nothing new about it
NO law on groundsFact, constitutesFact or explainsFact
NO world-relative membership
NO A2 / A3 / A6-A8 on the totality side
NO weakening of exists_necessary_ungrounded
NO result outside the cut depends on the law
NO new structure, class or axiom; enforced by a static CI guard
NO import of the cut outside its own modules, its audit and the Scott seam leaf;
   enforced by a static CI guard
NO use of the constitution law by that seam; enforced by a second static CI guard
```

The seam exemption was added by `scott-collapse-1`, which states its result through
`ContingencyWitness` and `SingleSuccessor`. `TOTALITY-CONSTITUTION-CONTRACT.md` section 8
restricts importers "in this cut", so the contract was not broken, but this boundary was
stricter than the contract until then and is recorded here as amended rather than silently
relaxed.

Narrative from `README.md`, "What the totality fact is":

`route-seam-1` left the designated totality fact as free data. `totality-constitution-1` makes
the repair and records what it costs. It states a constitution law, confined to the cut:

```text
ConstitutedTotality F R
    forall w, holdsAt w totality <-> forall x, inside x -> existsAt w x
```

Membership is rigid, so this is the de re reading: the fact that *these* members exist. The
law fixes when the totality obtains and nothing else; what grounds or explains it stays free.
It is a commitment about what the fact carrier records, not a discovery, and anyone who
rejects that reading is untouched by the results.

Under the law the first disjunct of the trichotomy stops being a free option. It is
member-necessity, and under completeness it is exactly the denial of

```text
W   something actual is not necessary
```

`W` is in no accepted premise package. It is the presupposition of the programme's question
rather than a commitment among the others. Denying it is necessitarianism about the actual
world, which is a consistent position, is not refuted here, and grants the totality
conclusion trivially while emptying the question. With the law and `W` the trichotomy reduces
to the fork between a necessary explanatory source and a contingent explanatory absolute.
That fork is exactly where `fact-sufficient-explanation-1` left it, and local sufficient
explanation is still the commitment that decides it. The cut is a reduction under two
explicit premises, not a new route and not a closure.

The same cut records a fact about the foundation route. Nothing in
`NecessaryExistenceAxioms` constrains the frame beyond `A5`. On a frame where the actual
world accesses only itself, `Necessary` coincides with `Actual`, `A4` is vacuous, and
`exists_necessary_ungrounded` says what `exists_ungrounded` already said from `A0` to `A2`.
The accepted `twoRootModel` lives on such a frame. The premises do not force that frame,
as the accepted `free_creation_refutes_actual_implies_necessary` shows, but they do not
exclude it either: the modal content of the central theorem is supplied by the frame, and
`W` is what rules the degenerate reading out. This does not weaken the theorem. It records
what its conclusion means on a frame the premises admit.

### 14. necessitation-1 (PR #39, closure #40)

`necessitation-1` - both routes with the link from source to target required to necessitate. On
the foundation route necessitating grounding is equivalent to necessitarianism about the actual
world; on the totality route necessitating explanation is equivalent to the necessity of the
totality fact, and the step from there to the denial of `W` needs the constitution law.

Contract: `contracts/grounding/NECESSITATION-CONTRACT.md`.

Two premises, as hypotheses only:

```text
GroundingNecessitates M       for every derived entity, at every accessible world where all
                              of its actual immediate grounds exist, the entity exists
ExplanationNecessitates G p   if p is explained, then at every accessible world where all of
                              its actual explanatory sources exist, p obtains
```

Foundation side, with A1, A2, A4 and A5 stated as the accepted record fields and A0 unused:

```text
actual_necessary_of_necessary_links          classical
    necessitation at links whose actual grounds are all necessary
        -> forall x, Actual M x -> Necessary M x
groundingNecessitates_iff_actual_necessary    classical
    GroundingNecessitates M  <->  forall x, Actual M x -> Necessary M x
groundingNecessitates_of_actual_necessary     axiom-free, A1 only
```

Totality side, with no constitution law, no `W` and no A2:

```text
explanationNecessitates_iff_explained_imp_necessaryFact    classical, the core only
explanationNecessitates_iff_necessaryFact                   classical, the core and local
                                                            sufficient explanation
explanationNecessitates_of_necessaryFact                    axiom-free, no premise
```

Independence. Foundation side: `UnactualGround` (A1), `NecessitatingRegress` (A2), `bruteModel`
(A4), `NoSelfAccess` (A5) and `freeCreationModel` (necessitation), with `NecessaryCreation` on
the necessitating side. Totality side: `NonNecessitatingExplainer` (necessitation),
`BruteTotality` (local sufficient explanation) and `SelfCitingExplainer` (the core, failing at
adequacy only), with `NecessaryTotality` on the necessitating side. `LawlessNecessitation`
satisfies the core, local sufficient explanation and necessitating explanation together with
`W`, so the reading against `W` on the totality route needs the law
(`law_needed_for_W_reading`).

Section 10 of the contract records seven findings of an independent review done before any Lean
was pushed. The first corrects the contract. Its sections 1, 6 and 7 said that, given `W`, a
necessitating link is excluded on both routes; on the totality route that holds only under the
constitution law. The second: on the totality route the equivalence is close to a renaming,
since under the core every explainer is already necessary.

Negative boundary:

```text
NO constitution law and NO ContingencyWitness; W appears only written out
NO A0 in the foundation theorems; NO A3 or A6-A8 anywhere in the cut
NO global assertion of either necessitation premise
NO claim that grounding or explanation necessitates, or that it does not
NO claim that a non-necessitating link is coherent, adequate or itself brute
NO new structure, class or axiom; no import of the cut outside it; static CI guards
```

## Semantic self-reference side line

### internal-truth-1 (PR #27, closure #29)

`internal-truth-1` - seven separately droppable conditions on a language and its truth-value carrier, shown jointly unsatisfiable, with an independence witness and a non-redundancy theorem for each. Truth-value gaps and truth-value gluts are separated over one and the same value carrier and negation, so they are distinct exits rather than one condition. It is not Tarski's undefinability theorem: there is no arithmetic, no coding, no representability and no theory, and the coding and diagonalisation assumptions are primitive and visible. It says nothing about meaning, experience, physicalism, necessary reality, grounding or the totality fact, and it does not show that there is no absolute standpoint.

Contract: `contracts/semantic/INTERNAL-TRUTH-CONTRACT.md`.

Record from `STATUS.md`:

`internal-truth-1` is on protected `main`. It belongs to a separate line and shares no
carrier or vocabulary with the grounding and totality cuts above.

Seven conditions on a language and its truth-value carrier, each a standalone proposition,
never bundled:

```text
Diag      diagonalisation over internally expressible predicates
ExprNegT  the negated internal truth predicate is internally expressible
Scope     internal truth applies to every sentence of the language
Disq      where it applies it returns the external value
NegSwapT  negation swaps the two designations
NoGap     every value is designated true or designated false
NoGlut    no value is designated both
```

What is proved is that the seven are jointly unsatisfiable, plus seven independence
witnesses and seven non-redundancy theorems of the form

```text
not (forall TV L, <the other six> -> False)
```

Those are statements about all proofs, not about one proof term. A compile-failure
experiment on the existing proof was rejected during review as an independence argument and
is explicitly forbidden by the contract.

The gap witness and the glut witness share the same value type and the same negation and
differ only in the designation predicates, so gap and glut are two exits and not one.

`no_internal_truth` depends on no axioms at all.

`Logos/SemanticLineAudit.lean` pins the axiom claims of this line and of the two cuts
below, and CI enforces that no grounding carrier appears in the line, that no module of
the grounding line imports it, and that the seam module is a leaf. Before that file the
same claims were documentation statements only.

What the cut does not establish is listed in `INTERNAL-TRUTH-CONTRACT.md` section 7. In
particular it is not Tarski's undefinability theorem, it says nothing about meaning,
experience or physicalism, and it does not show that no absolute standpoint exists: an
external valuation is granted by assumption in the signature.

### self-closure-1 (PR #28, closure #30)

`self-closure-1` - the bound implied by the previous cut, shown tight. A language is semantically self-closed when its internal truth predicate applies to every one of its own sentences and returns exactly the external value there. Self-closure is satisfiable classically, survives an infinite sentence type, and is compatible with a predicate carrier realising every function on codes except exactly one, that one being the negated internal truth predicate. So the cost of self-closure is a single nameable function rather than a knife edge. The cut introduces no carrier and no premise; two of its five results are typed as a restatement and a re-presentation and carry no new content.

Contract: `contracts/semantic/SELF-CLOSURE-CONTRACT.md`.

Record from `STATUS.md`:

`self-closure-1` is on protected `main`, on the same separate line as `internal-truth-1`.

It introduces no carrier and no premise. `SelfClosed L` is `Scope L` and `Disq L`;
`Bivalent TV` is `NoGap TV` and `NoGlut TV`. Both are named conjunctions of premises frozen
in `INTERNAL-TRUTH-CONTRACT.md`.

Two of the five results carry no new mathematical content and are typed that way in the
contract. `selfClosed_excludes_exprNegT` is the contrapositive of `no_internal_truth`.
`self_closure_possible` re-presents a witness already in the independence set of the previous
cut, stated by what holds in it rather than by what fails.

The new content is that the bound is tight:

```text
MaxLang    self-closed, bivalent, diagonalisation holds, and its predicate carrier
           realises every function Code -> V except exactly one
           that one is the negated internal truth predicate, stated as three
           separate lemmas rather than one
SimpleLang the other failure mode: the predicate carrier is empty, so expressibility
           fails because there are no internal predicates rather than because one
           returns the wrong value
OmegaLang  infinitely many sentences
OmegaMaxLang  infinite and maximal at once
```

So the cost of self-closure in this setting is a single nameable function.

`omegaMax_diag` is the only result on this line that uses `Classical.choice`. The step from
"no sentence diagonalises the predicate" to "the predicate is the negated truth predicate
everywhere" needs a classical existence step at infinite size and does not at finite size.
That asymmetry is recorded rather than absorbed.

Nothing here concerns an absolute, a God, simplicity, or any theological notion, and no name
may be read that way. The direction of the cost is recorded in the contract section 9:
self-closure is bought with expressive poverty rather than plenitude, so anything wanting to
be both maximally articulate about itself and semantically self-closed is asking for the
combination `no_internal_truth` rules out.

### truth-fact-seam-1 (PR #31, closure #32)

`truth-fact-seam-1` - the first module in the repository to mention both lines, joined by one explicit bridge saying that a sentence's fact obtains exactly when the sentence is designated true. The truth carrier turns out to be **conditionally** new. Under a two-valued carrier and a self-closed language it collapses into the fact carrier on the image of the naming map, which is the renaming worry confirmed for that case. Under a carrier with two distinct values both designated true it does not collapse. The fact carrier is in turn not a function of the language side, with the naming map proved surjective, so the residual freedom there is modal rather than extensional. The bridge is a commitment, not a discovery, and anyone who rejects that reading is untouched by the result.

Contract: `contracts/semantic/TRUTH-FACT-SEAM-CONTRACT.md`.

Record from `STATUS.md`:

`truth-fact-seam-1` is on protected `main`. It is the only module in the repository that
mentions both the grounding line and the semantic self-reference line, and it is a leaf:
nothing imports it.

One new structure and one new premise, both confined to the cut:

```text
LinkedModel   a language named into a fact carrier, no laws
Bridge K   :=  forall s, ActualFact F (K.sentenceFact s) <-> isT (K.L.val s)
```

The bridge relates `holdsAt` to `val`, the external valuation, and never to `T`. Relating it
to `T` would presuppose the identification under test. It is at the actual world only, and it
uses `isT` rather than equality of values, which is what the results turn on.

`Bridge` is a substantive commitment, not a discovery. Someone who rejects that reading of the
relation between a sentence's fact and its designation is untouched by any of this.

Three results, all holding:

```text
S1a  two-valued carrier, self-closed languages: two sentences naming the same fact
     carry the same value and the same internal verdict. The truth side IS a
     function of the fact side there.
S1b  carrier with two distinct values both designated true: two models sharing
     the fact side, both bridged and both self-closed, differ in val and in T.
S2   naming map surjective, two fact carriers agreeing at the actual world and
     differing at a non-actual one, both bridged.
```

The verdict fixed in advance by the contract for that combination is that **the axis is
conditionally new**. It collapses into the fact carrier exactly when the carrier is bivalent
and the language is self-closed, and not otherwise. The collapse half is the renaming worry
confirmed rather than refuted, and it is recorded that way.

Two departures from what the contract's targets sketched are recorded in its section 10
rather than absorbed. The realised S1a needs only that two sentences name the same fact, so
it is more general than the target. And S1a is partial in a second sense the contract did not
anticipate: it concludes only about codes in the image of the coding map, and off that image
`T` stays free even under bivalence, witnessed by `s1a_scope_differ_off_image`.

Every result of this cut depends on no axioms at all.

From `README.md`:

This line uses no `Entity`, `Fact` or `World` carrier outside the seam module, and no module of the grounding line imports any of it. The seam module is a leaf: nothing imports it either. CI enforces all three, and `Logos/SemanticLineAudit.lean` pins the axiom claims.

Nothing on this line concerns an absolute, a God, simplicity, or any theological notion, and no name in it may be read that way. Self-closure where it holds is bought with expressive poverty rather than plenitude: the language is self-closed because it cannot express one specific thing about itself.

## Goedel-Scott line

### scott-collapse-1 (PR #36, closure #37)

`scott-collapse-1` - Scott's version of the ontological argument stated over a LOGOS frame, with a leaf seam to the grounding line. Under full comprehension, Scott's definition D3 is a frame condition: it holds of an individual at a world exactly when that world accesses nothing but itself. With possible exemplification from A1 and A2, with A5, and with back-access at the actual world, that forces the single-successor frame recorded by `totality-constitution-1`. So Scott's package sits on the position that denies `W`. It is not a rival argument for necessary reality beside the LOGOS question; it sits on the position that empties the question. A3, A4 and the all-positive predicate play no part in putting it there. The package is consistent, each of A1, A2, A5 and back-access is shown load-bearing by a model satisfying everything else, and over one grounding model any entity whatever, including a derived one, can be made the all-positive individual, so the package says nothing about grounding position.

Contract: `contracts/goedel-scott/SCOTT-COLLAPSE-CONTRACT.md`.

Record from `STATUS.md`:

`scott-collapse-1` is on protected `main`. It is the first cut on the Goedel-Scott line, and
its seam module is the only one that mentions that line together with the grounding line.

The premises come first because none is established. Over a frame `F` and a type of
individuals, a carrier has a quantification domain `dom` and an uninterpreted predicate
`positive` on properties. Scott's five axioms are asserted valid:

```text
A1  PositiveNeg               positive (pNot phi) w  <->  not (positive phi w)
A2  PositiveMono              positive phi w -> phi necessarily entails psi at w -> positive psi w
A3  PositiveAllPositive       positive (AllPositive C) w                       D1
A4  PositiveRigid             positive phi w -> forall v, access w v -> positive phi v
A5  PositiveNecInstantiated   positive (NecInstantiated C) w                   D3

ScottCoreAxioms   A1, A2, A5
BackAccess F a    forall v, access a v -> access v a
```

Two further commitments are not axioms of the package. **Full comprehension**: property
variables range over every function from individuals and worlds to propositions. It is listed
among the live commitments above and the whole placement turns on it. **Back-access** at the
actual world, which is symmetry at one world and strictly weaker than a symmetric frame.

```text
necInstantiated_iff                                  no axioms, no axiom record in the hypotheses
    NecInstantiated C x w  <->  forall v, access w v -> (v = w and dom w x)

possibly_exemplified   (T1)                          classical
    A1 -> A2 -> positive phi w -> exists v, access w v and exists x, dom v x and phi x v

seesOnlyItself_of_scottCore                          classical through T1
    ScottCoreAxioms C -> BackAccess F a -> a accesses only a, and a accesses a

collapse                                             corollary, not a separate argument
    ScottCoreAxioms C -> BackAccess F a -> forall p : Formula F, p a -> box F p a

necessarily_allPositive   (T3)
    ScottCoreAxioms C -> A3 -> BackAccess F a -> box F (exists an all-positive individual) a

necessarily_allPositive_iff_actually                 no A3
    on the forced frame that box says what the plain existential says
```

No theorem about the collapse uses A4, and A3 is used only by T3. Outside T3, `PositiveRigid`
and `PositiveAllPositive` occur only in the models, which prove them for their carriers, and in
the non-redundancy statements, where they are premises shown not to suffice. That A3, A4 and the
all-positive predicate are idle in the placement was a prediction of the contract that could
have failed.

Seam, for a grounding model `M` and any carrier over its frame and entities, for every `dom`:

```text
singleSuccessor_of_scottCore              SingleSuccessor M
actual_reflexive_of_scottCore             A5 of the grounding line, as a conclusion
not_contingencyWitness_of_scottCore       not W
necessary_iff_actual_of_scottCore         Necessary M x <-> Actual M x
necessaryExistenceAxioms_of_foundation_of_scottCore     A4 of the grounding line is vacuous
exists_necessary_ungrounded_iff_exists_ungrounded_of_scottCore
```

So Scott's package sits on the position that denies `W`. It is not a rival argument for
necessary reality beside the programme's question; it is on the position that empties the
question. Because the results hold for every `dom`, that does not depend on whether Scott's
individual quantifiers are read as possibilist or actualist.

**The conclusion sits close to A5.** By `necInstantiated_iff`, A5 under full comprehension says
that being at a world which accesses nothing but itself is positive. T1 puts such a world
within reach and back-access brings it home. The independence set shows A5 is neither redundant
nor a renaming of the other axioms. It does not show that A5 is far from what it is used to
prove, and no independence set can.

Independence set. Each model satisfies all five axioms but the one dropped, the idle A3 and A4
included, and each has a non-redundancy theorem quantifying over all frames, carriers and
designated worlds:

```text
OneWorld       full package and BackAccess on one reflexive world          the package is consistent
NoBackAccess   A1-A5, frame reflexive and transitive, not BackAccess        no collapse
DropA5         A1-A4, equivalence frame                                     no collapse
DropA1         A2-A5, equivalence frame                                     no collapse
DropA2         A1, A3, A4, A5, equivalence frame                            no collapse
```

`NoBackAccess` also shows that reflexivity at the actual world, which is all the grounding line
assumes about the frame, does not suffice.

Over one grounding model, root grounding leaf, satisfying `NecessaryExistenceAxioms`, the
carrier `carrierAt chosen` satisfies the full package for every entity `chosen`. With `leaf`
chosen the all-positive individual is derived and the root is not all-positive. So the union of
the two premise packages is consistent and degenerate, and the package does not determine where
its distinguished individual sits in the grounding order.

Three departures from the frozen contract are recorded in `SCOTT-COLLAPSE-CONTRACT.md` section
10: 5.7 came out as one family of carriers rather than two, the definition inventory of section
2 was incomplete by six non-structural definitions, and one sentence of section 3 had no target
behind it and now has two theorems.

Negative boundary:

```text
NO claim that Scott's argument is unsound, or that his premises are false or inconsistent
NO claim about Goedel's original axioms, or about the variants that avoid modal collapse
NO claim under restricted comprehension
NO claim that W is true or false
NO interpretation of positive, and no reading of AllPositive used by any theorem
NO identification of the all-positive individual with any root, ground or explanatory source
NO A0-A8 as a premise of any GoedelScott module
NO new premise on the grounding line or the semantic line
NO use of the constitution law; enforced by a static CI guard
NO import of the GoedelScott line by another line, and the seam is a leaf; static CI guards
NO global axiom; the only new structures are Carrier, ScottCoreAxioms, ScottAxioms; static CI guard
NO theological token in the line's Lean files; static CI guard
```

From `README.md`:

The placement depends on **full comprehension**: property variables range over every function from individuals and worlds to propositions, including ones that mention a particular world. That is a commitment, not a discovery, and a reader who restricts property variables to what the object language can express is untouched by the result. The conclusion also sits close to A5, which under full comprehension says that being at a world that accesses only itself is positive; the independence set does not and cannot address that proximity.

The modules of this line import the logic layer and nothing else. No module of the other two lines imports them, the seam module is a leaf, and it does not use the constitution law. CI enforces all of that and rejects theological tokens in the line's Lean files. Scott's D1 is named `AllPositive`; the source's name for it appears only in the contract's source mapping, and no theorem uses any reading of it.

This cut does not show that Scott's argument is unsound or that his premises are false, says nothing about Goedel's original axioms or about the variants that avoid modal collapse, and does not show `W` true or false.

## Route summary as stated in README.md at c94d6cb

The summary of the two routes and of the externality audit that opened the old `README.md`:

The load-bearing grounding theorem remains:

```text
A0 + A1 + A2 + A4 + A5
        ->
there exists some actual ungrounded entity that exists necessarily
```

Formally, `exists_necessary_ungrounded` requires `NecessaryExistenceAxioms`. That record contains A0-A2 and A4-A5. It contains neither A3 nor the later transcendence/creation assumptions A6-A8.

A3 is separate and is used for uniqueness and universal grounding ancestry. A6-A8 are explicit extensions concerning created-order transcendence and essential aseity; they are not premises of the minimal existence theorem.

The accepted totality route has a different conclusion and premise package:

```text
fact F4 + externality E + completeness C
        ->
NecessaryFact(totality)
OR
an actual necessary entity grounds the totality fact from outside the regress
```

It does not prove that the necessary witness is ungrounded, and it does not eliminate A2 from the stronger foundation theorem. `route-seam-1` pins both points; see below.

`totality-externality-1` then audits the externality route more finely. It introduces a primitive `explainsFact` relation alongside constitutive support and distinguishes:

```text
F4     generic fact grounding of actual non-necessary facts
EF4    explanatory grounding of actual non-necessary facts
E      every generic ground of the totality fact is outside
E_expl every explanatory source of the totality fact is outside
```

The accepted premise-order result is:

```text
without G = ExplanationImpliesGrounding:
  F4 and EF4 are independent
  E and E_expl are independent

with G:
  EF4 is strictly stronger than F4
  E_expl is strictly weaker than E
```

Therefore the cut is not a proof that the total metaphysical premise package became weaker. It is a factorization and premise-accounting result: externality can be weakened and then derived from lower explanatory conditions, but the sufficient-ground commitment moves from generic F4 to stronger EF4 when explanation is required to imply grounding.

The deepest accepted theorem is conditional on:

```text
EF4 + S + I + C
```

where `S` is explanatory scope coverage and `I` is explanatory irreflexivity. From this package Lean proves either a necessary totality fact or an actual necessary explanatory source outside the represented regress. The deep theorem uses no A2, no A3, no old E, and no primitive E_expl premise.

Dedicated comparison, scope, type-boundary, and static CI audits pin these boundaries.

## Promotion notes

Newest first. The first five notes were written when their pull requests were merged; the rest
are from the "Open stack" section of `STATUS.md` as it stood at `c94d6cb`.

`#42` made the documents more precise after an independent audit of `main` at `5f3a569`.
- The note on `#41` below and the documents overstated the gate's reach. It walks the library,
  every module `Logos.lean` imports, and not the audit files. An axiom declared in an audit file
  passed CI until this change. Two textual guards now cover every Lean file: the
  unfinished-proof guard also rejects `admit` and `native_decide`, and a new guard rejects axiom
  declarations whatever their modifiers or attributes. Both were checked to fail on a seeded
  violation.
- Three sentences in `MAP.md` stated the necessitation constraint without the constitution law
  on the totality route. Two others in `README.md` and `STATUS.md` said "outright" where the
  foundation premises are needed. All five are qualified now.
- The composition in `README.md` point 5 is typed *reading*.
- Smaller corrections: a "below" that meant "above", a pointer to the Scott contract's source
  mapping that does not exist there, a claimed open item in `TRUTH-FACT-SEAM-CONTRACT.md`
  section 10 that is a finding, and the `FOCUS` line of `STATUS.md`.

`#41` added the axiom gate on 2026-09-22. Before it, the audit files printed `#print axioms`
output for review, and a theorem that started to use a new axiom would have passed CI.
`Logos/AxiomGateAudit.lean` walks every theorem and definition declared in a `Logos` module and
fails if one uses an axiom beyond `propext`, `Classical.choice` and `Quot.sound`, or if any axiom
is declared there. That covers what the textual guards cannot see: an unfinished proof closed
with `admit`, which the `sorry` grep misses; the auxiliary axiom `native_decide` creates, which no
guard checked; and a `private axiom`, which the per-cut regex `^\s*axiom\b` misses. At the time
it checked 3061 declarations. It was verified to fail on a seeded `private axiom`, an unfinished
proof and a use of `native_decide`, and to pass on the clean tree. It imports the `Lean` meta
library from the toolchain; `lake-manifest.json` still lists no packages.

`#40` was the closure for `necessitation-1`.

`#39 necessitation-1` was promoted on 2026-09-22 with its three commits unchanged: contract
first, with its own green run before any Lean for the cut was pushed; Lean second; outcome
addendum third. Section 0 of the contract records that a scratch proof of a stronger
totality-side variant existed before the contract. An independent review of the implementation,
done before the Lean was pushed, produced seven findings. They are in section 10 of the contract,
and `LawlessNecessitation` and three theorems were added in response. After `#38` was merged the
branch was brought up to date with `main` by a merge commit that left its tree unchanged. Before
promotion, on the exact trees of the three commits, the build ran 76 jobs, all 35 run steps of the
workflow passed, and each of the three new guards failed on a seeded violation and passed on the
clean tree.

`#38` restructured the documentation on 2026-09-22. `README.md` states the question and the
answer, `MAP.md` holds the logical map, `STATUS.md` the current state only, and this file the
history. It changed no Lean source and no contract body. An independent check of the new
documents against the Lean sources corrected several statements that the old documents had also
made too strongly; the records above keep the old wording.

`#36 scott-collapse-1` was promoted on 2026-09-21 with its three commits unchanged: contract
first, Lean second, outcome addendum third. The contract commit was pushed and had its own green
run before any Lean for the cut was pushed, and sections 0 to 9 are unchanged since. One change
predates freezing and is in section 0 of the contract: the route to the collapse first proposed
in conversation went through D1, T2 and T3, and the shorter route through D3 alone was found on
paper while drafting. Two review items were put to the owner in the pull request and the cut was
promoted with both standing: one added exemption in the totality constitution import guard, for
the seam module only, and the structural naming of Scott's D1. Before promotion the branch was
rebuilt from the pinned toolchain on a fresh clone (73 jobs, no unfinished proof), all 31 run
steps of the workflow were executed locally, and each of the six new guards was checked to fail
on a seeded violation and to pass on the clean tree.

`#33 totality-constitution-1` was promoted on 2026-09-21 with its three commits unchanged:
contract first, Lean second, outcome addendum third. Its contract was written with no
implementation of the cut in existence and stated in advance what each outcome would mean.
Three departures from the frozen text are recorded in section 10 of the contract rather than
absorbed. Before promotion the branch was rebuilt from the pinned toolchain on a fresh clone
(68 jobs, no unfinished proof), the axiom audit was compared line by line with section 10,
and the required `build` check was green on both the push and the pull request run.

`#27 internal-truth-1` was promoted on 2026-08-24, followed by its closure `#29`, then
`#28 self-closure-1` after rebasing onto the promoted state, then `#31 truth-fact-seam-1`.
The seam cut is the first in the programme whose contract was written with no prior
implementation of the cut in existence, and whose contract stated in advance what each
possible outcome would mean. While `#28` was stacked it
showed no checks at all, because `.github/workflows/lean.yml` triggers only on `main` and
`cut/**`; the workflow was dispatched manually and the gap recorded in the PR. Whether the
trigger list should cover stacked branches is an open repository question, not a result.

`#27` Review of it required the cut contract to
be committed before the implementation, with an explicit provenance note recording that an
experimental implementation existed first, so the run is not a blind preregistration. Review
also rejected a compile-failure experiment that had been reported as an independence
argument and required it to be replaced by theorems quantifying over all proofs.

The `#7` to `#10` chain and `#14` were promoted on 2026-08-20, followed by `#16 route-seam-1`
after review required it to be rebased on the promoted state, to drop two interpretive
overreaches and to be restated against `TotalityExplanationCore` rather than the superseded
`CompleteScopedExplanationAxioms`.

`#24 a4-fact-independence-1` followed on the same day, after `#25` had corrected four
documents that still stated the carrier result and the modal-licensing result more strongly
than the types support. Review of `#24` also required adequacy to be put into the type of
`root_explains_stray_without_grounding`, and required the contract to claim two
non-entailments rather than anything about the reach of arguments.

## Frontier as stated at c94d6cb

From `README.md`, "Current research frontier":

No cut is open on the grounding line. That programme has reached a stable state and the
remaining work on it is philosophical rather than formal.

No cut is open on the semantic self-reference line either. Its main open question, whether the
truth carrier is a new axis or the fact carrier renamed, was settled conditionally by
`truth-fact-seam-1`: it collapses under bivalence and self-closure and not otherwise. What
remains open there is smaller and stated in `SELF-CLOSURE-CONTRACT.md` section 9 and
`TRUTH-FACT-SEAM-CONTRACT.md` section 10.

The judgments the machine has isolated and cannot settle are whether an identity citation can
count as an adequate explanation of contingent existence, whether exempting a carrier from
completeness, scope or adequacy can ever be principled, and whether a necessary explanatory
source that is itself grounded deserves the name the foundation route earns.

`a4-fact-independence-1` divides the brute-contingency question rather than answering it.
A4 at the entity level and local sufficient explanation for the totality fact are two
commitments, so a defence of one is not a defence of the other. Both are listed in `STATUS`.

`totality-constitution-1` adds a presupposition and a confined commitment rather than a
result about the fork. `W` and the constitution law are listed in `STATUS` next to the
commitments, each under its own kind.

No cut is open on the Goedel-Scott line. It is a separate line of the LOGOS program, not a step in the grounding/totality sequence, and nothing on the other lines depends on it. `scott-collapse-1` leaves two questions it names and does not attempt: whether a variant of the argument that avoids modal collapse can stand beside `W`, and whether any of the placement survives when property variables are restricted to what the object language can express.

TWIST-J is likewise not a dependency of the general ontology core.
