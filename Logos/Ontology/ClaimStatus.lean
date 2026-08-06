namespace Logos

/-- Metadata for the role a claim plays in the wider LOGOS program. -/
inductive ClaimStatus where
  | formalDefinition
  | formalAssumption
  | provedTheorem
  | openConjecture
  | bridge
  | interpretation
  | confession
  | metaphor
  deriving Repr, DecidableEq

/-- A labelled proposition with an explicit program role.

This structure is bookkeeping only. A status does not provide a proof of the
stored proposition and must not be used to smuggle interpretive claims into
formal premises.
-/
structure ClassifiedClaim where
  label : String
  status : ClaimStatus
  statement : Prop

end Logos
