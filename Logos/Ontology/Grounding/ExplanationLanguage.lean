import Logos.Ontology.Grounding.FactLanguage

universe u v w

namespace Logos
namespace Grounding

/-- Separate registered roles for fact support.

`constitutesFact` is intended for internal/constitutive support.
`explainsFact` is intended for a source registered as answering why a fact obtains.

The two relations are deliberately primitive and independent. In particular,
`explainsFact` does not definitionally include adequacy, completeness,
non-circularity, or sufficient reason. -/
structure FactGroundingRoles
    (M : Model.{u, v}) (F : FactModel.{u, v, w} M) where
  constitutesFact : M.frame.World → M.Entity → F.Fact → Prop
  explainsFact : M.frame.World → M.Entity → F.Fact → Prop

/-- Actual constitutive support. -/
def ActualConstitutesFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (a : M.Entity) (p : F.Fact) : Prop :=
  G.constitutesFact M.actual a p

/-- Actual explanatory support. -/
def ActualExplainsFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (a : M.Entity) (p : F.Fact) : Prop :=
  G.explainsFact M.actual a p

/-- A fact has some actual registered explanatory source. -/
def ExplainedFact
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) (p : F.Fact) : Prop :=
  ∃ a, ActualExplainsFact G a p

/-- The accepted generic fact-level F4 principle, stated as a reusable predicate. -/
def GenericFactSufficientGround
    {M : Model.{u, v}} (F : FactModel.{u, v, w} M) : Prop :=
  ∀ p, ActualFact F p → ¬ NecessaryFact F p → DerivedFact F p

/-- The proposed explanation-specific EF4 principle.

This is not defined as a weakening or strengthening of generic F4. Their formal
relation is determined by explicit comparison models. -/
def ExplanatoryFactSufficientGround
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) : Prop :=
  ∀ p, ActualFact F p → ¬ NecessaryFact F p → ExplainedFact G p

/-- Optional bridge saying that every registered explanation is also a generic
fact ground. This bridge is not assumed by the role language or by the main cut. -/
def ExplanationImpliesGrounding
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    (G : FactGroundingRoles M F) : Prop :=
  ∀ {a p}, ActualExplainsFact G a p → ActualGroundsFact F a p

/-- Under the optional bridge, EF4 implies generic F4. The bridge is explicit. -/
theorem explanatoryF4_implies_genericF4_of_bridge
    {M : Model.{u, v}} {F : FactModel.{u, v, w} M}
    {G : FactGroundingRoles M F}
    (hBridge : ExplanationImpliesGrounding G)
    (hEF4 : ExplanatoryFactSufficientGround G) :
    GenericFactSufficientGround F := by
  intro p hp hNotNecessary
  rcases hEF4 p hp hNotNecessary with ⟨a, hExplain⟩
  exact ⟨a, hBridge hExplain⟩

end Grounding
end Logos
