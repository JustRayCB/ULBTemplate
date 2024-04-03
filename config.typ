// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "ulb/template.typ": Template


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
