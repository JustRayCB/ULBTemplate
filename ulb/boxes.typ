#import "environments.typ": proofSection, popup

// ColorFull boxes based on Environments
#let proof = proofSection.with(
  supplement: "Preuve "
)
#let definition = popup.with(
  type: "Définition ",
  color: purple,
  kind: "definition",
)
#let proposal = popup.with(
  type: "Suggestion ",
  color: purple,
  kind: "definition",
)
#let convention = popup.with(
  type: "Convention ",
  color: purple,
  kind: "definition",
)
#let theorem = popup.with(
  type: "Théorème ",
  color: green,
  kind: "result",
)
#let corollary = popup.with(
  type: "Corrolaire ",
  color: olive,
  kind: "result",
)
#let proposition = popup.with(
  type: "Proposition ",
  color: blue,
  kind: "result",
)
#let lemma = popup.with(
  type: "Lemme ",
  color: aqua,
  kind: "result",
)
#let claim = popup.with(
  type: "Affirmation ",
  color: aqua,
  kind: "result",
)
#let example = popup.with(
  type: "Exemple ",
  color: yellow,
  kind: "showcase",
)
#let problem = popup.with(
  type: "Problème ",
  color: red,
  kind: "showcase",
)
#let solution = popup.with(
  type: "Solution ",
  color: green,
  kind: "showcase",
)
#let note = popup.with(
  type: "Note ",
  color: orange,
  kind: "note",
)
#let remark = popup.with(
  type: "Remarque ",
  color: orange,
  kind: "note",
)
#let warning = popup.with(
  // type: "Attention",
  type: [Attention #text(size: 0.7em)[#emoji.warning]],
  color: red,
  kind: "note",
)
#let exceptions = popup.with(
  type: "Exception ",
  color: red,
  kind: "note",
)
