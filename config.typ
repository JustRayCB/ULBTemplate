#import "ulb/template.typ": Template

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
    ),
    Teachers: (
        "M. Name",
    ),
    TOC: false,
    First_line_indent: fil
)

#let hl(color: white, body) = box(
    // More prettier way to highlight text
    fill: color, inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    body
    // text(
    //   font: "Cascadia Code",
    //   size: 10.5pt,
    //   body
    // )
)

#let noi() =  {
    // No indent only when on the indent position
    // Doesn't WORK do not know why FIXME
    // locate(loc => {
    //     let x = loc.position().x.pt()
    //     let indent_pos = (margins+fil)
    //     if x == indent_pos{
    //         return h(-fil)
    //     }
    // })
    h(-fil)

}

#let i() = {
    // Indent only when on the start of the line (margins start)
    // WARNING: Different behaviour with locate function and juste using h(fil) function don't know why bug ??
    // Doesn't WORK do not know why FIXME
    // locate(loc => {
    //     let x = loc.position().x.pt()
    //     if x == margins.pt(){
    //         return h(fil)
    //     }
    // })
    h(fil) // Different behaviour while indenting at start position of a line
}
