// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "ulb/template.typ": Template

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

// https://typst.app/universe/package/showybox
// #figure(
//   showybox(
//     [Hello world!]
//   ),
//   supplement: "Définition", numbering: "1.1",
//   outlined: true
// )<salut>
#import "@preview/showybox:2.0.1": showybox

// https://typst.app/universe/package/i-figured
#import "@preview/i-figured:0.2.4"

// https://typst.app/universe/package/linguify
#import "@preview/linguify:0.3.1"

// https://typst.app/universe/package/octique
// #octique-inline("accessibility-inset", color: green)
#import "@preview/octique:0.1.0"

// https://typst.app/universe/package/codly
#import "@preview/codly:0.2.0"

#let fil = 20pt
#let margins = 2.5cm




#let template = Template.with(
    Title: "Rayan's Template",
    UE: "UE",
    Subject: "Sujet",
    Authors: (
      "Rayan Contuliano Bravo",
    ),
    Teachers: (
        "M. Name",
    ),
    TOC: false,
    First_line_indent: fil
)

// NoIndent function
#let noi() =  {
    h(-fil)

}

// Indent function
#let i() = {
    h(fil) // Different behaviour while indenting at start position of a line
}
