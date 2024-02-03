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
    First_line_indent: 20pt
)
= Introduction <intro>
Here in @intro,
#lorem(50)

#parbreak()
#lorem(10) Salut je me demande pourquoi est-ce que c'es comme ça ?
#link("https://example.com")[
  See example.com
]

#parbreak()

$ 1 + 1 = 2  $ 

#parbreak()

#lorem(10) Salut je me demande pourquoi est-ce que c'es comme ça ?


== Sub Section 
#lorem(10)
=== Sub Sub Section 
#lorem(50)
// #pagebreak()
//
// #include "test.typ"

// #pagebreak()
// #bibliography("./bibliography.bib",)
