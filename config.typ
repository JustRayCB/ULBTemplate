// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "ulb/template.typ": Template

// Notebookinator config
// #import "@local/notebookinator:1.0.0": themes
//
// // #import themes.radial: components, colors
// #import themes.linear.components: pro-con,
// // #import colors: *

#let fil = 20pt
#let margins = 2.5cm



// #let pros_cons(pros: [], cons: [], breakable: false) = {
//     block(
//         pro-con(pros: pros, cons: cons),
//         above: 2em, below: 2em, breakable: breakable
//     )
// }


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

#let noi() =  {
    h(-fil)

}

#let i() = {
    h(fil) // Different behaviour while indenting at start position of a line
}
