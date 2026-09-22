# MAP

The logical map of LOGOS: the positions on the question, the two routes to a necessary reality,
the premises that decide between them, and the countermodels that keep those premises apart.

Every claim is relative to the definitions and premises stated in the repository. Names in
backticks are Lean identifiers or model namespaces on `main`, cut names, or file names; `W`
abbreviates `ContingencyWitness`. A result marked *propositional* follows from the definitions by
propositional logic alone, uses no axiom and no premise of its route, and carries no information
beyond the definitions; it is listed because it fixes what a premise means, not because it
discovers anything. A statement marked *reading* is an interpretation of several results
together, not a theorem.

## 1. The question and the positions

> If anything exists at all, must there be, at the deepest level, some necessary reality, or
> could everything in the end be contingent?

Four positions answer it. All four are consistent in the formal language.

```text
position            claim                                            model on main
------------------  -----------------------------------------------  ------------------------------
necessary reality   something actual exists necessarily and is the   freeCreationModel,
                    ground or the explanation of the rest            Witnessed.NecessaryExplainer
brute entity        an actual, ungrounded entity that need not       bruteModel
                    exist
brute totality      the totality of contingent things is actual,     BruteTotality,
                    not necessary and unexplained                    Witnessed.ContingentAbsolute
necessitarianism    every actual entity is necessary (the denial     Necessitarian
                    of W)
```

The programme's question presupposes `W` (`ContingencyWitness`): something actual is not
necessary. Necessitarianism denies `W`. It is not refuted here. It grants every conclusion of
the form "something is necessary" for free, and so empties the question rather than answering it.

Nothing in the formal layer rules out a brute entity or a brute totality. Each is excluded by one
principle of sufficient reason, and by nothing weaker that has been found.

## 2. Foundation route: entities

Premises (`Logos/Systems/AbsoluteGround/Axioms.lean`):

```text
A0  something is actual
A1  grounding relates entities that exist at the world in question
A2  actual grounding is well founded
A4  an actual contingent entity is derived (has a ground)
A5  the actual world accesses itself
```

`NecessaryExistenceAxioms` is exactly A0, A1, A2, A4, A5.

```text
exists_necessary_ungrounded
    NecessaryExistenceAxioms M -> exists a, Ungrounded M a and Necessary M a
```

How it works: A0 to A2 give an actual ungrounded entity (`exists_ungrounded`). A4 says an
ungrounded actual entity is not contingent, and A5 turns "not contingent" into "necessary"
(`ungrounded_is_necessary`). The conclusion is A4 applied to the witness A2 supplies. Under A5,
A4 is equivalent to A4' (`NonNecessaryIsDerived`): what actually exists but need not exist is
derived (`nonNecessary_is_derived`, `contingent_is_derived_of_nonNecessary`).

Extensions, not premises of the theorem above:

```text
A3      any two actual entities have a common actual ground ancestor; gives uniqueness
        and universal ancestry (exists_unique_ungrounded, ungrounded_ancestor_all)
A6-A8   created order and essential aseity; used only by the theorems about
        AbsoluteGround (exists_unique_absoluteGround needs A0 to A6), never by a
        theorem the answer rests on
```

Countermodels (`Logos/Models/Grounding/`):

```text
cycleModel          A2 fails through a grounding cycle
regressModel        A2 fails through an acyclic bottomless order; A0, A1, A3, A4, A5 hold
  (InfiniteRegress) and nothing is ungrounded (regress_no_ungrounded)
bruteModel          A4 fails: an actual, ungrounded, non-necessary entity
twoRootModel        A3 fails: two distinct necessary roots, on a degenerate frame (below)
createdRootModel    A6 fails
accidentalModel     A8 fails
freeCreationModel   A0 to A7 hold and a created entity is contingent, so the premises do
                    not make everything actual necessary
```

A caveat about frames. On a frame where the actual world accesses only itself, `Necessary`
coincides with `Actual`, A4 is vacuous, and the theorem says only what `exists_ungrounded` says
(`necessary_iff_actual_of_singleSuccessor`,
`exists_necessary_ungrounded_iff_exists_ungrounded_of_singleSuccessor`). `twoRootModel` lives on
such a frame (`twoRoot_singleSuccessor`). The premises do not force that frame
(`freeCreationModel`), and `W` excludes it (`not_singleSuccessor_of_contingencyWitness`).

## 3. Totality route: the fact that all contingent things exist

This route does not assume A2. Its language adds a separate fact carrier, a designated totality
fact over a represented regress (`RegressTotality`), and a primitive explanation relation
between entities and facts (`explainsFact`).

The core (`TotalityExplanationCore`, in `Logos/Systems/FactSufficientExplanation/Axioms.lean`):

```text
ES  a source that explains the totality fact is actual
LA  an explanation of the totality fact adequately explains every actual member;
    adequacy (AdequateExplainsEntity) forbids a non-necessary entity from counting
    as its own explanation
C   every actual non-necessary entity is a member of the represented totality
```

The engine, stated for any carrier (`ScopeClosureAxioms`) and instantiated by the core
(`TotalityExplanationCore.toScopeClosureAxioms`):

```text
closure_explainer_is_necessary
    a contingent explainer would be a member (C), would then have to explain itself
    adequately (LA), and adequacy forbids exactly that
```

The fork, from excluded middle plus the engine:

```text
totality_necessary_or_necessary_explainer_or_contingent_absolute
    NecessaryFact(totality)
    or  an actual necessary source explains the totality fact
    or  the totality fact is a contingent explanatory absolute:
        actual, not necessary, unexplained
```

The principle that decides the fork is local sufficient explanation
(`LocalFactSufficientExplanation`): if the totality fact is not necessary, something explains it.
Rejecting it at an actual fact is the same as accepting that fact as a contingent explanatory
absolute (`not_localFactSufficientExplanation_iff_contingentAbsolute`, *propositional*). So the
principle cannot be defended by pointing at the third disjunct; the two are one commitment.
With it, the third disjunct goes
(`local_totality_sufficient_explanation_forces_necessary_reality`).

The constitution law (`ConstitutedTotality`, a commitment confined to `totality-constitution-1`)
says what the totality fact is: it obtains at a world exactly when every member exists there,
with membership fixed across worlds. Under the law and C, the first disjunct is exactly the
denial of `W` (`necessaryFact_iff_not_contingencyWitness`). With `W` the fork has two branches,
a necessary explanatory source or a contingent explanatory absolute
(`necessary_explainer_or_contingent_absolute`), and local sufficient explanation picks the first
(`necessary_explainer_of_localEF4`).

Countermodels:

```text
Necessitarian                  law, core, not W       first disjunct
BareWitness                    W, core, no law        first disjunct still holds: the law is
                                                      load-bearing
Witnessed.NecessaryExplainer   law, core, W           middle disjunct; local principle holds
Witnessed.ContingentAbsolute   law, core, W           third disjunct; local principle fails
BruteTotality                  core                   third disjunct, and no entity is necessary
CompletenessExempt,            one-item carriers      C, scope and adequacy are each
ScopeExempt, AdequacyExempt                           separately load-bearing for the engine
SelfExplanation.               adequacy dropped       a wholly contingent world closed by
  ContingentSelfCitation                              circular self-citation
```

What the route does not give: the necessary explanatory source need not be ungrounded.
`GroundedExplainer` satisfies the core with a necessary source that is itself grounded
(`core_fixes_necessity_not_grounding`), while `UngroundedExplainer` has an ungrounded one.
The core fixes the modal status of the explainer, not its position in the grounding order. So
the totality route alone never concludes that anything is ungrounded; that conclusion comes only
from the foundation route.

## 4. How the two routes relate

- **Their presuppositions split the ground structurally.** Actual grounding is either well
  founded or carries a bare regress record (`wellFounded_or_regressTotality`), and a regress
  record refutes A2 (`regressTotality_refutes_wellFoundedness`,
  `regressTotality_refutes_necessaryExistenceAxioms`), so a theorem stated over both packages is
  vacuous (`seam_bridge_is_vacuous`). The full premise packages are not exhaustive: both can
  fail together. In `bruteModel` grounding is well founded, so no regress record exists, and A4
  fails, so the foundation package fails too. "One route applies whenever the other does not"
  is neither proved nor true in general.
- **Their principles are independent** (`a4-fact-independence-1`, under a shared hypothesis
  schema). `FactBruteEntityRegular` satisfies A4 and A4' while local sufficient explanation fails;
  `EntityBruteFactRegular` satisfies local sufficient explanation while A4 and A4' fail. These
  are two non-entailments and nothing more. What follows for arguments is a *reading*: an
  argument whose conclusion is A4 does not thereby reach local sufficient explanation, and
  conversely, so a result that only rules out brute entities leaves the brute-totality position
  standing.
- **The bare regress record is weak.** It is an infinite descending chain plus a label; its fact
  layer and membership predicate are largely free data (`bare_totality_necessary`). Every
  substantive claim of the totality route comes from the premises stated over the record, not
  from the record.

## 5. The premises that decide

```text
premise                        kind                    where it acts            it excludes
-----------------------------  ----------------------  -----------------------  ------------------
A4 / A4'                       commitment              foundation route         brute entity
local sufficient explanation   commitment              totality route           brute totality
adequacy of self-citation      commitment, normative   totality route (LA)      contingent world
                                                                                closed by
                                                                                self-citation
W                              presupposition          the question itself      necessitarianism
constitution law               commitment, confined    reduction of the fork    (none; it fixes
                               to one cut                                       what the fact is)
no brute modality              commitment of a side    grounded-modality-1      (does not close
                               axis                                             the fork)
full comprehension             commitment, confined    Scott placement          (none)
                               to one cut
```

Each brute position of section 1 is reached by denying one line of this table and keeping the
rest of its route: `bruteModel` satisfies A0 to A3 and A5 and fails only A4 among A0 to A5;
`BruteTotality` satisfies the whole core and fails local sufficient explanation. (Every model
of the totality route carries a regress record and so fails A2 by construction.) Denying A2 is
not a position by itself: it only makes the foundation route unavailable and moves the question
to the totality route.

The current wording of each commitment, and what is known about it, is in the register in
`STATUS.md`.

## 6. Recorded dead ends

Attempts to reach necessity without paying for one of the two principles. Each is kept as a
result.

```text
contingent-absolute-1   explanatory ultimacy -> necessity is equivalent to the local
                        principle (totality_ultimateModalStability_iff_localEF4); not an
                        independent route
grounded-modality-1     under no brute modality, modal unconditionedness is equivalent to
                        being actual and necessary
                        (modallyUnconditioned_iff_modallyAbsolute_of_noBrute), so it
                        partitions necessity rather than deriving it; ConditionedBrute has
                        no brute modality and a brute totality
                        (no_brute_modality_permits_contingent_explanatory_absolute)
carrier-schema-1        a contingent explainer refutes the closure conditions
                        (escape_requires_exemption); an actual one can explain the target
                        only at a carrier exempt from C, scope or adequacy
totality-externality-1  separating constitution from explanation made externality weaker and
                        the sufficient-reason commitment strictly stronger under the natural
                        bridge G (bridged_F4_not_EF4); *reading*: the total premise package
                        did not get weaker
```

## 7. Side lines

**Goedel-Scott line** (`contracts/goedel-scott/`). `scott-collapse-1` states Scott's axioms over
a LOGOS frame. Under full comprehension, A1, A2 and A5 of Scott's package with back-access at
the actual world force the actual world to access only itself (`seesOnlyItself_of_scottCore`),
which is necessitarianism (`not_contingencyWitness_of_scottCore`). The ontological argument in
this form does not compete with the programme's question; it sits on the position that empties
it. The placement turns on full comprehension, which in Lean is a type choice (a property is
any function from individuals and worlds to propositions), and nothing is claimed under
restricted comprehension.

**Semantic self-reference line** (`contracts/semantic/`): `internal-truth-1`, `self-closure-1`,
`truth-fact-seam-1`. A separate study. It isolates when a language can carry a total, correct
truth predicate for its own sentences, and exhibits languages that reach the bound
(`MaxLang`, `OmegaMaxLang`). It does not bear on the programme's question, and no module of the
grounding line imports it.

It is kept apart for a stated reason. It was motivated by an informal argument: if reality is
exhaustively a formal structure, the truth of its complete description cannot be one more item
inside it, so something escapes the structure. That argument needs a transfer premise from
definability to ontology, named SemanticClosure in `INTERNAL-TRUTH-CONTRACT.md`, which the line
deliberately does not formalize. Without it the line says nothing about what exists. Joining it
to the question would take a cut that states that premise and tests it; until then it stays a
side line.

## 8. Open questions

Philosophical, and not settled by any theorem here:

- whether A4 is true, and whether local sufficient explanation is true;
- whether an identity citation "P because P" can count as an adequate complete explanation of a
  contingent P;
- whether exempting a carrier from completeness, scope or adequacy can be principled;
- whether a necessary explanatory source that is itself grounded deserves the name the
  foundation route earns;
- whether reality can have two or more independent necessary foundations (A3).

Formal, and not yet attempted:

- the modal behaviour of explanation and grounding. `explainsFact` and `directGrounds` carry no
  law relating the source's existence to the target's obtaining across worlds. Which of the
  positions in section 1 survive when explanation or grounding is required to necessitate its
  target is open.
- on the semantic side line: `SELF-CLOSURE-CONTRACT.md` section 9 and
  `TRUTH-FACT-SEAM-CONTRACT.md` section 10;
- on the Goedel-Scott line: a variant of the argument that avoids the collapse beside `W`, and
  the placement under restricted comprehension.

## 9. Retired vocabulary

Older contracts and `history/CHANGELOG.md` use premise names that are no longer part of the
current argument. The theorems stated with them remain on `main` and remain valid; they are
superseded as formulations, not refuted.

```text
F4        every actual non-necessary fact has an entity ground        totality-regress-1
E         every ground of the totality fact lies outside the regress  totality-regress-1
EF4       every actual non-necessary fact has an explanatory source   totality-externality-1
E_expl    every explanatory source of the totality lies outside       totality-externality-1
G         explanation implies grounding                               totality-externality-1
S         an explanation of the totality covers every member          totality-externality-1
I         no actual entity explains itself                            totality-externality-1
```

What became of them: E was replaced by its explanatory form E_expl, which S and I derive
(`totality_explainer_is_outside`; old E itself fails in a model where G and E_expl hold,
`old_externality_fails`); I was reduced to local adequacy, now LA (`self-explanation-1`); global
EF4 was removed from the core, leaving only the local principle at the one totality fact
(`fact-sufficient-explanation-1`). The records `ExternalRegressTotalityAxioms`,
`CompleteContingentTotalityAxioms`, `CompleteScopedExplanationAxioms` and
`AdequateTotalityScopeAxioms` belong to those stages; `TotalityExplanationCore` replaces them as
the current core.
