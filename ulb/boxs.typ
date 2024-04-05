// https://typst.app/universe/package/showybox
// #figure(
//   showybox(
//     [Hello world!]
//   ),
//   supplement: "Définition", numbering: "1.1",
//   outlined: true
// )<salut>
#import "@preview/showybox:2.0.1": showybox
#import "utils.typ": getSectionNumber


// He create a box
/*
* Create a box for the header that contains a grid -> symbol | Title
* Create another box(block?) for the body
*/

#let popup(
  body,
  kind: "definition",
  supplement: "Définition",
  color: blue,
  breakable: false,
) = {
  // +1 because the current figure in not created yet
  let figNb = context (counter(figure.where(kind: kind)).get()).at(0)
  let sectionNb = context (getSectionNumber()).at(0)
  let title = strong()[#supplement #sectionNb.#figNb:]
  block(
    figure(
      showybox(
        [
          #title
          #body
        ],
        color: color,
        breakable: breakable,
      ),
      kind: kind,
      supplement: supplement,
      outlined: true,
      caption: "This is a " + supplement + " box"
    ),
    above: 3em,
    below: 3em,
  )

}

#let borderBox(
  body,
  kind: "remark", 
  supplement: "Remarque", 
  color: blue, 
  breakable: false, 
) = {
  let figNb = context (counter(figure.where(kind: kind)).get()).at(0)
  let sectionNb = context (getSectionNumber()).at(0)
  let title = strong()[#supplement #sectionNb.#figNb:]


}

