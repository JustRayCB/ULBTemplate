#import "template.typ": *


// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: Template.with(
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
    // TOC: false,
)
= Introduction
#lorem(50)
// == SubSection
// #lorem(50)
// Salut comment ça va ?


// #pagebreak()
//
// #include "test.typ"

// #pagebreak()
// #bibliography("./bibliography.bib",)
