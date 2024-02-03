#import "@preview/showybox:2.0.1"

  
#let popup(
  body, 
  ..arguments, 
  kind: "note", 
  type: "Note", 
  color: orange, 
  named: false,
  outline: true,
  breakable: false,
) = {
  // Unload arguments & config
  let title = ""
  let footer = ""
  assert(arguments.pos().len() <= 2, message: "Too many `content` passed.")
  if arguments.pos().len() == 1 {
    title = body
    body = arguments.pos().at(0)
  } else if arguments.pos().len() == 2 {
    title = body
    body = arguments.pos().at(0)
    footer = arguments.pos().at(1, default: "")
  }
  
  if footer != "" {
    footer = [#set text(black); #text(size: 10pt, weight: 600, footer)]
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
  
  // Frame
  let frame = (
      title-color: color.darken(55%),
      body-color: color.lighten(90%),
      footer-color: color.lighten(70%),
      border-color: color.darken(70%),
      radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)
  )

  // Modifications
  let caption = [#title]
  if named == true {
    title = [#title<meta:NamedTitle>]
  }
  if title != "" and title != [] {
    title = [#show text: text.with(weight: 100);(#title)]
  }
  
  // Display
  if named {
    return [#[#show figure: set block(breakable: breakable);#figure(
      kind: kind,
      caption: [#caption],
      supplement: type,
      outlined: outline,
    )[#showybox.showybox(
      title-style: titleStyle,
      frame: frame,
      title: [#v(0pt)#type <meta:NumberHere>]+[ #title],
      footer: footer,
      breakable: breakable,
      body,
    )]<meta:Attachment><meta:Named>]]
  } else {
    return [#[#show figure: set block(breakable: breakable);#figure(
      kind: kind,
      caption: [#caption],
      supplement: type,
      outlined: outline,
    )[#showybox.showybox(
      title-style: titleStyle,
      frame: frame,
      title: [#v(0pt)#type <meta:NumberHere>]+[ #title],
      footer: footer,
      breakable: breakable,
      body,
    )]<meta:Attachment>]]
  }
}

#let proofSection(
  body,
  ..arguments,
  supplement: "Proof ", 
  kind: "proof",
  outline: false,
) = {
  // Arguments & Config
  let title 
  assert(arguments.pos().len() < 2, message: "Too many passed arguments.")
  if arguments.pos().len() == 1 {
    title = body
    body = arguments.pos().first()
  }
  let stroke = (left: 2.5pt + black)


  // Prefixing
  let prefix = [#supplement]
  let caption
  if title != [] {
    prefix += [ #strong[de #title] ]
  } 
  prefix += [(<meta:NumberHere>): ]
  prefix = strong(prefix)
  body = prefix + body + [#v(1em)]

  // Postfixing
  let QED = place(right, move([$qed$], dx: -1pt, dy: -6pt))
  body += QED

  // Some weird fix because figure center aligns.
  body = [
    #set align(left)
    #set par(justify: true)
    #body
    // hello world!!!
  ]
  return [#show figure: set block(breakable: true)
    #figure(block(
    body,
    breakable: true,
    stroke: stroke,
    inset: 2%,
    width: 100%,
  ),
    caption: [#title],
    kind: kind,
    supplement: supplement,
    numbering: none,
    outlined: outline,
  )<meta:Attachment>]
}

#let recall() = {
  // TODO: Recalls an attachment previously posted; make sure it doesn't count up
}
