#import "@preview/showybox:2.0.3": showybox
#import "utils.typ": getSectionNumber

#let prepared-box(
  body,
  arguments,
  kind,
  supplement,
  allow-footer: false,
) = {
  let title = none
  let caption = none
  let footer = none

  let max-args = if allow-footer { 2 } else { 1 }
  assert(arguments.pos().len() <= max-args, message: "Too many content blocks passed.")

  if arguments.pos().len() == 1 {
    title = body
    body = arguments.pos().at(0)
  } else if arguments.pos().len() == 2 {
    title = body
    body = arguments.pos().at(0)
    footer = arguments.pos().at(1)
  }

  let figure-number = context counter(figure.where(kind: kind)).get().at(0)
  let section-number = context getSectionNumber().at(0)
  let numbered-prefix = strong()[#supplement #section-number.#figure-number]

  let rendered-title
  if title != none {
    caption = title
    rendered-title = text()[#numbered-prefix: ] + title
  } else {
    rendered-title = strong()[#supplement]
  }

  (
    body: body,
    caption: caption,
    footer: footer,
    outlined: caption != none,
    title: rendered-title,
  )
}

#let popup(
  body,
  ..arguments,
  kind: "definition",
  supplement: "Definition",
  color: blue,
  breakable: false,
) = {
  let box = prepared-box(
    body,
    arguments,
    kind,
    supplement,
    allow-footer: true,
  )

  let footer = if box.footer != none {
    [#set text(black); #text(size: 10pt, weight: 600, box.footer)]
  } else {
    none
  }

  let title-style = (
    boxed-style: (
      anchor: (x: left, y: horizon),
      radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
    ),
  )

  let frame = (
    title-color: color.darken(55%),
    body-color: color.lighten(90%),
    footer-color: color.lighten(70%),
    border-color: color.darken(70%),
    radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
  )

  figure(
    caption: box.caption,
    kind: kind,
    supplement: supplement,
    outlined: box.outlined,
  )[
    #set par(justify: true, first-line-indent: 0pt)
    #showybox(
      title-style: title-style,
      frame: frame,
      title: box.title,
      footer: footer,
      breakable: breakable,
      box.body,
    )
  ]
}

#let borderBox(
  body,
  ..arguments,
  kind: "remark",
  supplement: "Remark",
  icon: emoji.pin,
  color: green,
  breakable: true,
) = {
  let box = prepared-box(body, arguments, kind, supplement)

  let icon-node = if icon == none {
    none
  } else if type(icon) == str {
    text(size: 2em)[#image(icon, fit: "contain")]
  } else {
    text(size: 2em)[#icon]
  }

  let header-block(header, icon-node) = {
    let current-grid = if icon-node == none {
      grid(
        columns: 1,
        align: (left),
        inset: 0.4em,
        header,
      )
    } else {
      grid(
        columns: (2em, 2fr),
        align: (horizon, left + horizon),
        gutter: 0.5em,
        icon-node,
        header,
      )
    }

    block(width: 100%, inset: 5pt)[#current-grid]
  }

  let content-block(content) = {
    content += [#v(4pt)]
    let qed = place(right, move([#emoji.face.cool], dx: 2%, dy: -1%))
    let content = if kind == "proof" { content + qed } else { content }

    block(
      inset: 10pt,
      width: 100%,
      fill: white,
    )[#content]
  }

  let rendered = block(width: auto)[
    #set par(justify: true, first-line-indent: 0pt)
    #set align(start)
    #stack(
      dir: ttb,
      header-block(box.title, icon-node),
      content-block(box.body),
    )
  ]

  figure(
    block(
      rendered,
      breakable: breakable,
      radius: (top-left: 1pt, bottom-left: 1pt),
      stroke: (x: 3pt + color, right: none),
      outset: 0.4%,
    ),
    caption: box.caption,
    kind: kind,
    supplement: supplement,
    outlined: box.outlined,
  )
}
