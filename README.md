# LOGOS

A formal laboratory in Lean 4 for one question:

> If anything exists at all, must there be, at the deepest level, some necessary reality, or
> could everything in the end be contingent?

Lean checks what follows from what. It does not check whether the premises are true, or whether
a formal predicate captures the philosophical notion it is named after. That responsibility stays
with the human reader, and the repository is built to keep it visible.

## The answer so far

Every statement below is relative to the definitions and premises stated in this repository.

1. **Logic alone does not force a necessary reality.** Pure contingency is consistent. There are
   models with an actual, ungrounded entity that need not exist (`bruteModel`), and models in
   which nothing actual is necessary and the totality of contingent things is an actual fact
   that is neither necessary nor explained (`BruteTotality`).

2. **What forces it is a principle of sufficient reason, in one of two forms, and neither form
   implies the other** (`a4-fact-independence-1`, under a shared hypothesis schema).
   - *For entities* (A4): what exists but need not exist is not ultimate. Together with
     well-founded grounding (A2) and three technical premises (A0, A1, A5), some ungrounded
     entity exists necessarily (`exists_necessary_ungrounded`).
   - *For the totality* (local sufficient explanation): if the totality of contingent things is
     not necessary, something explains it. Together with completeness, scope and adequacy,
     whatever explains it is necessary (`closure_explainer_is_necessary`).

3. **The only other exit is necessitarianism:** everything actual is necessary. It is consistent
   and not refuted here, but it grants the conclusion trivially and empties the question. The
   question presupposes `W`: something actual is not necessary. Scott's version of the
   ontological argument lands on this exit, under full comprehension and back-access at the
   actual world (`scott-collapse-1`).

4. **Attempts to get necessity without paying for one of the two principles failed, and the
   failures are kept as results.** Deriving necessity from explanatory ultimacy is equivalent to
   the local principle (`contingent-absolute-1`). Grounding modality in conditions leaves a brute
   totality possible (`grounded-modality-1`). Offering an actual contingent explainer from a
   fresh carrier works only by exempting that carrier from completeness, scope or adequacy
   (`carrier-schema-1`).

5. **A necessary reality beside contingent things needs a link that does not necessitate**,
   outright on the foundation route and under the constitution law on the totality route. With
   A1, A2, A4 and A5, grounding that necessitates what it grounds is equivalent to everything
   actual being necessary (`groundingNecessitates_iff_actual_necessary`). With the core and local
   sufficient explanation, explanation that necessitates the totality fact is equivalent to that
   fact being necessary (`explanationNecessitates_iff_necessaryFact`); the constitution law turns
   this into the denial of `W`, and without the law `W` survives (`necessitation-1`). This is the
   modal collapse objection to sufficient reason, placed on both routes.

The formal arguments are short; the central theorems take a few lines each. The weight is in the
premises, and the job of the repository is to show exactly which premise carries it.

## What is not claimed

Nothing here shows that a necessary reality exists: every such conclusion is conditional on one
of the two principles above. Nothing shows that it is one: uniqueness needs A3, and
`twoRootModel` has two distinct ungrounded roots satisfying every other foundation premise (on a
frame where necessity is degenerate; see `MAP.md` section 2). Nothing shows that it is personal,
intelligent or good, that it has a will, or that it has any traditional divine attribute.
Nothing shows that a brute fact or a brute modality is a contradiction, or that a link which
does not necessitate is coherent or explains anything. "Absolute" is a structural term here, not
a theological one.

## Where to read

- `MAP.md`: the logical map. The positions, the two routes, the premises that decide between
  them, the theorems that use each premise and the countermodels that separate them. Start here.
- `STATUS.md`: what is on `main`, what is open, and the register of live premises.
- `PROJECT-RULES.md`: claim typing, import firewall, the cut cycle, audits and closure.
- `contracts/`: the frozen contract of every accepted cut, one folder per line.
- `history/`: how the programme got here. `CHANGELOG.md` is the cut-by-cut record, including
  the premise vocabulary that has since been retired.
- `Logos/`: the Lean sources. The `Logos/*Audit.lean` files print the axioms of the main
  theorems for review, and some pin theorem boundaries with wrapper theorems that stop
  elaborating if a signature is strengthened.

The repository has one main line and two side lines. The grounding line carries the answer
above. The Goedel-Scott line places Scott's argument on that map. The semantic self-reference
line is a separate study that does not bear on the question; `MAP.md` section 8 says why it is
kept apart.

## Building

Lean 4.30.0, pinned in `lean-toolchain`. There are no dependencies: `lake-manifest.json` lists
no packages, so `#print axioms` reports only what the proofs themselves use.

```text
lake build
```

CI (`.github/workflows/lean.yml`) also rejects `sorry`, runs every audit file, and enforces
line-specific import and token guards. The general layer direction of `PROJECT-RULES.md`
section 3 is kept by review, not by CI.

License: MIT, copyright 2026 A. M. Thorn.
