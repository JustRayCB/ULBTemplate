#import "config.typ": *

#show: template

= Introduction <intro>
// Here in @intro,
// #lorem(50)

// Salut comment ça va ?
// // Salut comment ça va ?
//

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
// #proposal[Title][Content][Footer]
// #theorem[Title][Content][Footer]
// #example[Title][Content][Footer]
#problem[Title][Content][Footer]
#h(fil)#lorem(50)\

#lorem(50)

// #noindent()[Oui Comment ça va ?]

// Hallo hoe gaat het met je? 



// #pagebreak()
//
// #include "test.typ"

#bibliography("./bibliography.bib")
