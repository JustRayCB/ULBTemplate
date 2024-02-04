#import "ulb/template.typ": Template
#import "ulb/extra.typ": *
#import "ulb/boxes.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.

#let fil = 20pt

#let template = Template.with(
    Title: "Rayan's Template",
    UE: "UE",
    Subject: "Sujet",
    Authors: (
      "Rayan Contuliano Bravo",
      "Hugo Callens",
    ),
    Teachers: (
        "M. Name",
    ),
    TOC: false,
    First_line_indent: fil
)

#let noindent(body) = {
    set par(first-line-indent: 0pt)
    body
}

