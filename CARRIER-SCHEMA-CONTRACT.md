# CARRIER-SCHEMA-1 DESIGN CONTRACT

Status: **ACCEPTED CUT CONTRACT - ON MAIN**.

Base: `fact-sufficient-explanation-1`.

This contract is a local record for one cut. Project-wide governance is in `PROJECT-RULES.md`.

## 1. Motivation

`FACT-SUFFICIENT-EXPLANATION-1` left one opponent position standing: the contingent totality fact may be accepted as a contingent explanatory absolute. `GROUNDED-MODALITY-1` then showed, in its own `ConditionedBrute` model, that licensing every modal contrast does not dislodge that position; it relocates the unexplained item onto a modal condition that nothing yet constrains.

That suggests a general worry rather than a local one. If the unexplained item can always be moved onto a fresh carrier, the accepted route proves nothing durable and each cut is a rearrangement.

This cut asks whether the move helps, once and for all carriers, instead of building another floor by hand.

## 2. Claim type

```text
formal definition   ScopeCarrier, ScopeClosureAxioms
proved theorem      closure_explainer_is_necessary, closure_dichotomy,
                    escape_requires_exemption,
                    pure_contingency_leaves_target_absolute_at_carrier
proved theorem      TotalityExplanationCore.toScopeClosureAxioms,
                    totality_explainer_is_necessary_via_schema
countermodel        CompletenessExempt, ScopeExempt, AdequacyExempt
```

No bridge, interpretation or confession is introduced.

## 3. Language

`ScopeCarrier S` is a type `S` with five predicates:

```text
Actual     : S → Prop
Necessary  : S → Prop
Inside     : S → Prop
Explains   : S → Prop      one designated target
Adequate   : S → S → Prop
```

`S` is not a domain of entities. It is whatever is offered as a terminus of explanation: entities, modal conditions, grounds of conditions, or anything a later escape introduces. The carrier layer mentions no `Model`, no `FactModel`, no `RegressTotality`, and no world. A static CI guard enforces that.

## 4. Assumptions

`ScopeClosureAxioms K` collects four conditions:

```text
explains_source_actual              whatever explains the target is actual
covers_nonNecessary                 C, at this carrier
adequate_members                    S, at this carrier
adequacy_excludes_contingent_self   a non-necessary item is not its own adequate explanation
```

The first three transcribe `TotalityExplanationCore` with entities removed. The fourth is definitional in the entity case, because `AdequateExplainsEntity` builds contingent propriety into its meaning, and therefore has to be made explicit once the carrier is arbitrary.

## 5. Results

```text
closure_explainer_is_necessary
    ScopeClosureAxioms K → K.Explains a → K.Necessary a
```

```text
closure_dichotomy
    ScopeClosureAxioms K →
      (∃ a, Actual a ∧ Necessary a ∧ Explains a) ∨ (∀ a, ¬ Explains a)
```

```text
escape_requires_exemption
    K.Explains a → ¬ K.Necessary a → ¬ ScopeClosureAxioms K
```

The last is the point of the cut. A contingent item cannot explain the target at a carrier held to these conditions. Introducing a new kind of item therefore does not dissolve the fork; the move is available exactly when the new carrier is exempted from completeness, scope or adequacy.

## 6. The accepted route is an instance

```text
TotalityExplanationCore.toScopeClosureAxioms
totality_explainer_is_necessary_via_schema
```

`totality_explainer_is_necessary_from_core` is not merely analogous to the carrier-neutral engine. It is that engine instantiated at `entityScopeCarrier`. Whatever the schema says therefore already applies to the accepted route, and the schema is not a separate parallel construction.

## 7. Countermodels

Each of the three substantive conditions is separately load-bearing. For each there is a one-item carrier that drops it, keeps the other two, and lets a contingent item explain the target:

```text
CompletenessExempt   item is actual and contingent but declared outside the totality
ScopeExempt          everything is inside, but the explanation need not reach members
AdequacyExempt       the item counts as its own adequate explanation
```

`each_condition_is_separately_load_bearing` states the suite as one theorem.

`CompletenessExempt` is the abstract shape of the `ConditionedBrute` escape of `GROUNDED-MODALITY-1`. `AdequacyExempt` is contingent self-citation one level up, that is, the question `SELF-EXPLANATION-1` isolated for entities, now visible at an arbitrary carrier.

## 8. What this does not establish

It does not close the fork. A contingent explanatory absolute remains available; the cut says only that reaching one always takes the same shape.

It does not show that any particular exemption is illegitimate. Whether a modal condition may stand outside the represented totality is a philosophical question this cut deliberately leaves open, and `CompletenessExempt` shows the question is not empty.

It does not prove that the three conditions are the only possible closure conditions. It proves they suffice for the engine and that each is needed for it.

It introduces no new premise into the accepted main line. Nothing under `Systems/` outside `CarrierSchema` imports it.

## 9. Remaining philosophical boundary

The fork is stable under carrier extension. That converts an open-ended worry, namely that the unexplained item can always be relocated, into a fixed question:

> For a proposed new carrier, which of completeness, scope or adequacy is it exempt from, and why is that exemption principled rather than stipulated?

`CONDITION-SCOPE-1` was proposed as a cut asking that question of the modal condition in `ConditionedBrute`. Under this schema that cut is no longer open-ended: by `CompletenessExempt` its answer is already known to be completeness, so the remaining work is the philosophical defence of that exemption, not further formalization.

## 10. Acceptance tests

1. whole project builds under the pinned Lean toolchain;
2. no `sorry` or `sorryAx` occurs;
3. the carrier layer mentions no entity, fact or regress structure, enforced by static CI guard;
4. `closure_explainer_is_necessary` uses only the four closure conditions;
5. `escape_requires_exemption` is proved and audited;
6. `TotalityExplanationCore` is shown to instantiate `ScopeClosureAxioms`;
7. the accepted entity theorem is rederived through the schema;
8. all three exemption countermodels elaborate;
9. each countermodel establishes that the other two conditions still hold;
10. dedicated axiom audit is green;
11. no new premise enters any accepted axiom record;
12. no theological interpretation enters the proof core.
