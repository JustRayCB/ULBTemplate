// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "ulb/template.typ": Template
#import "ulb/boxs.typ": popup, borderBox

// https://typst.app/universe/package/gentle-clues
/*
* abstract, info, question, memo, task, idea, tip, quote, success, warning, error, example.
*/
// #box([#info(title: "Bonjour")[Salut]<salut>]) to fix the non indent text after
#import "@preview/gentle-clues:0.7.1"

// https://typst.app/universe/package/note-me
/*
* node, tip, important, warning, caution, todo
*/
#import "@preview/note-me:0.2.1"


// https://typst.app/universe/package/i-figured
#import "@preview/i-figured:0.2.4"

// https://typst.app/universe/package/linguify
#import "@preview/linguify:0.4.2"

// https://typst.app/universe/package/octique
// #octique-inline("accessibility-inset", color: green)
#import "@preview/octique:0.1.0": octique-inline, octique

// https://typst.app/universe/package/codly
#import "@preview/codly:0.2.0"



#let fil = 20pt
#let margins = 2.5cm
// TODO: remove extra-pref and use states instead of arrays only
#let kinds = (
  "definition", 
  "theorem",
  "proof", 
  "example",
  "proposition",
  "corollary",
  "lemma",
  "remark",
  "notation",
)

#let extra-pref = (
  definition: "def:", 
  theorem: "thm:", 
  proof: "prf:", 
  example: "ex:",
  proposition: "prop:", 
  corollary: "cor:",
  lemma: "lem:", 
  remark: "rem:", 
  notation: "not:",
  warning: "warn:",
)

#let colorKind = (
  definition: teal,
  theorem: blue,
  proof: color.eastern,
  example: orange,
  proposition: maroon,
  corollary: yellow,
  lemma: aqua,
  remark: lime,
  notation: purple,
  warning: red,
)




#let template = Template.with(
    language: "fr", // If you want to change the language, (Only "fr" and "en" are supported)
    title: "Rayan's Template",
    ue: "UE", // Coruse Mnemonic
    subject: "Sujet", // Name of the subject/course
    authors: (
      "Rayan Contuliano Bravo",
    ),
    teachers: (
        "M. Name",
    ),
    toc: false,
    fig_toc: false, // If you want to display the list of figures (doesn't work right now
    first_line_indent: fil, // Indentation of the first line of a paragraph
    kinds: kinds,
    extra-pref: extra-pref,
)

#let definition = popup.with(
  kind: "definition",
  supplement: linguify.linguify("Definition"),
  color: colorKind.definition,
)

#let theorem = popup.with(
  kind: "theorem",
  supplement: linguify.linguify("Theorem"),
  color: colorKind.theorem,
)

#let proof = borderBox.with(
  kind: "proof",
  supplement: linguify.linguify("Proof"),
  color: colorKind.proof,
  icon: octique("bookmark", color: colorKind.proof)
)

#let example = borderBox.with(
  kind: "example",
  supplement: linguify.linguify("Example"),
  color: colorKind.example,
  icon: octique("flame", color: colorKind.example)
)

#let proposition = popup.with(
  kind: "proposition",
  supplement: linguify.linguify("Proposition"),
  color: colorKind.proposition,
) 

#let corollary = popup.with(
  kind: "corollary",
  supplement: linguify.linguify("Corollary"),
  color: colorKind.corollary,
) 

#let lemma = popup.with(
  kind: "lemma",
  supplement: linguify.linguify("Lemma"),
  color: colorKind.lemma,
) 

#let remark = borderBox.with(
  kind: "remark",
  supplement: linguify.linguify("Remark"),
  color: colorKind.remark,
  icon: octique("light-bulb", color: colorKind.remark)

)

#let notation = popup.with(
  kind: "notation",
  supplement: linguify.linguify("Notation"),
  color: colorKind.notation,
)

#let warning = borderBox.with(
  kind: "warning",
  supplement: linguify.linguify("Warning"),
  color: colorKind.warning,
  icon: octique("alert", color: colorKind.warning),
)

// NoIndent function
#let noindent() =  {
    h(-fil)

}

// Indent function
#let indent() = {
    h(fil) // Different behaviour while indenting at start position of a line
}

#let unnumbered(body) = {
  set heading(numbering: none)
  body
}
