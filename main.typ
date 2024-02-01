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
#fi()#lorem(50)

// #pagebreak()
//
// #include "test.typ"

// #pagebreak()
// #bibliography("./bibliography.bib",)
