/-
Logos / Systems / SelfClosure / Axioms.lean

Vocabulary for the SELF-CLOSURE cut. No new premises: these are named
conjunctions of premises already defined in `Systems.InternalTruth.Axioms`,
introduced so that the results of this cut can be stated positively.
-/

import Logos.Systems.InternalTruth.Axioms

namespace Logos.Systems.SelfClosure

open Logos.Ontology.Semantics Logos.Systems.InternalTruth

variable {TV : TruthValues}

/-- A language is semantically self-closed when its internal truth predicate
applies to every one of its own sentences and returns exactly the external
value there. -/
def SelfClosed (L : SemLanguage TV) : Prop := Scope L ∧ Disq L

/-- A truth-value carrier is bivalent when it has neither gaps nor gluts. -/
def Bivalent (TV : TruthValues) : Prop := NoGap TV ∧ NoGlut TV

end Logos.Systems.SelfClosure
