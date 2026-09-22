import Lean
import Logos

/-! # Axiom gate

Whole-project check, run by CI. It fails the build when

* any constant declared in a `Logos` module is an axiom, whatever its
  modifiers or attributes; or
* any theorem or definition declared in a `Logos` module depends on an axiom
  other than `propext`, `Classical.choice` and `Quot.sound`. That also catches
  unfinished proofs and the auxiliary axioms native evaluation creates.

It walks the library: every module that `Logos.lean` imports. The audit files
are not library modules; CI covers them with textual guards.

The per-cut audit files print the axioms of named results for review; this
file is what makes an unexpected axiom fail CI. It imports the `Lean` meta
library from the toolchain for the environment walk; that is not a package and
no module of `Logos` imports this file. -/

open Lean Elab Command

run_cmd do
  let env ← getEnv
  let allowed : List Name := [``propext, ``Classical.choice, ``Quot.sound]
  let mut declared : Array Name := #[]
  let mut offenders : Array (Name × Array Name) := #[]
  let mut checked : Nat := 0
  for (n, ci) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let mod := env.header.moduleNames[idx.toNat]!
    unless (`Logos).isPrefixOf mod do continue
    match ci with
    | .axiomInfo _ => declared := declared.push n
    | .thmInfo _ | .defnInfo _ | .opaqueInfo _ =>
      checked := checked + 1
      let axioms ← liftCoreM <| collectAxioms n
      let bad := axioms.filter (fun a => !allowed.contains a)
      unless bad.isEmpty do
        offenders := offenders.push (n, bad)
    | _ => pure ()
  unless declared.isEmpty do
    throwError m!"axiom gate: axioms declared in Logos modules: {declared.toList}"
  unless offenders.isEmpty do
    throwError m!"axiom gate: declarations using axioms beyond propext, Classical.choice, Quot.sound: {offenders.toList}"
  logInfo m!"axiom gate: {checked} theorems and definitions in Logos modules use at most propext, Classical.choice and Quot.sound; no axiom is declared"
