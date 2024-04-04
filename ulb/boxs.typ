// https://typst.app/universe/package/showybox
// #figure(
//   showybox(
//     [Hello world!]
//   ),
//   supplement: "Définition", numbering: "1.1",
//   outlined: true
// )<salut>
#import "@preview/showybox:2.0.1": showybox


#let popup(
  body,
  kind: "info", 
  supplement: "Information",
  color: blue,
  breakable: false,
) = figure(
    // [#body],
      showybox(
        [#body],
        color: color,
        breakable: breakable,
      ),
      kind: kind,
      supplement: supplement,
      outlined: true,
      caption: "This is a " + supplement + " box"
    )
