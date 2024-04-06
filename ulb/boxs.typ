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
  ..arguments,
  kind: "remark", 
  supplement: "Remarque",
  icon: emoji.pin,
  color: green,
  breakable: true, 
) = {

    let title 
    let caption
    let figNb = context (counter(figure.where(kind: kind, outlined:true)).get()).at(0)
    let sectionNb = context (getSectionNumber()).at(0)
    let prefix = strong()[#supplement #sectionNb.#figNb]
    assert(arguments.pos().len() < 2, message: "Too many passed arguments.")
    let origin
    if arguments.pos().len() == 1 {
      title = body
      body = arguments.pos().first()
    }
    if title != none {
      caption = title
      title = text()[#prefix: ] + title
    } else {
      prefix = strong()[#supplement]
      title = prefix
      // INFO:If the caption is none, the fig will not appear in the FTOC
    }
    let outlined = if caption != none {true} else {false}
    let pic
    let size = 2em
    if type(icon) == str{
      pic = text(size: size)[#image(icon, fit: "contain")] 
    }else{
      pic = text(size: size)[#icon] 
    }

    let header-block(header, pic) = {
      block(
        width: 100%,
        inset: 6pt,
      )[
          #grid(
            columns: (2em, 2fr),
            align: (horizon, left + horizon),
            gutter: 0.5em,
            pic,
            header
          )
      ]
    }



    let content-block(content) = {
      // Postfixing
      content += [#v(4pt)]
      let QED = place(right, move([#emoji.face.cool], dx: 2%, dy: -1%))
      content = if kind == "proof" {
        content + QED
      } else {
        content
      }
      block(
        inset: 10pt,
        width: 100%,
        fill: white, 
      )[#content]
    }


    let res = block(
        width: auto,
      )[
        #set align(start)
        #stack(dir: ttb,
          header-block(title, pic),
          content-block(body)
        )
      ] // block end

    block(
      figure(
        res,
        kind: kind,
        supplement: supplement,
        outlined: outlined,
        caption: caption,
      ),
      breakable: breakable,
      radius: (top-left: 0pt,  bottom-left: 0pt),
      stroke: (x: 3pt + color, right: none),
      outset: 0.4%,
      above:2em,
      below: 2em,
    )
  }

