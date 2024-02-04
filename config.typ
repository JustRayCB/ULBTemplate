#import "ulb/template.typ": Template
#import "ulb/extra.typ": *
#import "ulb/boxes.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.

#let fil = 20pt
#let margins = 2.5cm

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


#let noi() =  {
    // No indent only when on the indent position
    locate(loc => {
        let x = loc.position().x.pt()
        let indent_pos = (margins+fil)
        if x == indent_pos{
            return h(-fil)
        }
    })

}

#let i() = {
    // Indent only when on the start of the line (margins start)
    // WARNING: Different behaviour with locate function and juste using h(fil) function don't know why bug ??
    locate(loc => {
        let x = loc.position().x.pt()
        if x == margins.pt(){
            return h(fil)
        }
    })
    // h(fil) Different behaviour while indenting at start position of a line
}
