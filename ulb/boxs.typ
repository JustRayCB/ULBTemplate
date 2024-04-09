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
  ..arguments,
  kind: "definition",
  supplement: "Définition",
  icon: emoji.hi,
  color: blue,
  breakable: false,
) = {
  let title 
  let caption
  let footer = ""
  let figNb = context (counter(figure.where(kind: kind, outlined:true)).get()).at(0)
  let sectionNb = context (getSectionNumber()).at(0)
  let prefix = strong()[#supplement #sectionNb.#figNb]
  assert(arguments.pos().len() <= 2, message: "Too many `content` passed.")
  if arguments.pos().len() == 1 {
    title = body
    body = arguments.pos().at(0)
  } else if arguments.pos().len() == 2 {
    title = body
    body = arguments.pos().at(0)
    footer = arguments.pos().at(1, default: "")
  }
  if title != none {
    caption = title
    title = text()[#prefix: ] + title
  } else {
    prefix = strong()[#supplement]
    title = prefix
    // INFO:If the caption is none, the fig will not appear in the FTOC
  }
  if footer != "" {
    footer = [#set text(black); #text(size: 10pt, weight: 600, footer)]
  }

  let outlined = if caption != none {true} else {false}
  let pic
  let size = 2em
  if icon == none {
    pic = none
  } else if type(icon) == str{
    pic = text(size: size)[#image(icon, fit: "contain")] 
  }else{
    pic = text(size: size)[#icon] 
  }
  // Title Style
  let titleStyle = (
    boxed-style: (
      anchor: (
        x: left,
        y: horizon
      ),
      radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
    )
  )
  let frame = (
      title-color: color.darken(55%),
      body-color: color.lighten(90%),
      footer-color: color.lighten(70%),
      border-color: color.darken(70%),
      radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)
  )

  let header-block(header, pic) = {
    let current_grid = if pic == none {
      grid(
        columns: 1,
        align: (left),
        inset: 0.4em,
        // stroke: 1pt,
        header
      )
    } else {
      grid(
        columns: (2em, 2fr),
        align: (horizon, left + horizon),
        gutter: 0.5em,
        pic,
        header
      )
    }
    return [#box(
      width: 100%,
      inset: 5pt,
    )[
      #current_grid
    ]]
  }
  show figure.caption: none
  block(
    figure(
      kind: kind,
      caption: [#caption],
      supplement: supplement,
      outlined: outlined,
    )[#showybox(
      title-style: titleStyle,
      frame: frame,
      // title: header-block(title, pic),
      title: title,
      footer: footer,
      breakable: breakable,
      body,
    )],
    above: 2em,
    below: 2em,
  )

}

#let borderBox(
  body,
  ..arguments,
  kind: "remark", 
  supplement: "Remarque",
  icon: emoji.pin,
  color: green,
  outlined: true,
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
    if icon == none {
      pic = none
    } else if type(icon) == str{
      pic = text(size: size)[#image(icon, fit: "contain")] 
    }else{
      pic = text(size: size)[#icon] 
    }

    let header-block(header, pic) = {
      let current_grid = if pic == none {
        grid(
          columns: 1,
          align: (left),
          inset: 0.4em,
          // stroke: 1pt,
          header
        )
      } else {
        grid(
          columns: (2em, 2fr),
          align: (horizon, left + horizon),
          gutter: 0.5em,
          pic,
          header
        )
      }
      block(
        width: 100%,
        inset: 5pt,
      )[
        #current_grid
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
    show figure.caption: none
    block(
      figure(
        res,
        kind: kind,
        supplement: supplement,
        outlined: outlined,
        caption: caption,
      ),
      breakable: breakable,
      radius: (top-left: 1pt,  bottom-left: 1pt),
      stroke: (x: 3pt + color, right: none),
      outset: 0.4%,
      above:2em,
      below: 2em,
    )
  }

