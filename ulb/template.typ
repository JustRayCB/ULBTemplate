#import "@preview/chic-hdr:0.4.0" // Library for headers and footers
#import "@preview/outrageous:0.1.0" // Library for TOC formatting
#import "helper.typ"

#let Template(
  Title: "Titre",
  UE: "Unité d'enseignement",
  Subject: "Sujet",
  Authors: (),
  Teachers: (),
  Date: datetime.today().display("[day] [month repr:long] [year]"),
  TOC: true,
  Depth: 5,
  First_line_indent: 20pt,
  body,
) = {
  // Set the document's basic properties.
  // ===========Cover page=============
  set document(author: Authors, title: Title)
  let banner= "logos/banner.png"
  let logo = "logos/logo.jpg"
  let sceau = "logos/sceau.png"
  set page(
      background: 
          {
            place(dx: 0%, dy: 0%, image(sceau, width: 100%, height: 100%))
          }
  )

  // Save heading and body font families in variables.
  let body-font = "Linux Libertine"
  let sans-font = "Inria Sans"

  // Set body font family.
  set text(font: body-font, lang: "fr", 12pt)
  // show heading: set text(font: sans-font, size: 24pt)

  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9fr)

  // Date + Title
  text(1.1em,Date)
  v(1.2em, weak: true)
  text(font: sans-font, 2em, weight: 700, Title)


  // Authors
  stack(
    dir: ltr,
    spacing: 40%,
    pad(
      top: 0.7em,
      // right: 20%,
      grid(
        columns: 1,// (1fr,),  // * calc.min(3, authors.len()),
        gutter: 1.5em,
        text(font: sans-font, style: "oblique", size: 1.2em, weight: 1000, "Étudiants:"),
        ..Authors.map(author => align(start, smallcaps(author))),
      ),
    ), 
    pad(
      top: 0.7em,
      // right: 20%,
      grid(
        columns: 1, //(1fr,),  // * calc.min(3, authors.len()),
        gutter: 1.5em,
        text(font: sans-font, style: "oblique", size: 1.2em, weight: 1000, "Professeurs:"),
        ..Teachers.map(teacher => align(start, smallcaps(teacher))),
      ),
    )
    )


  v(2.4fr)
  pagebreak()
  set page(background: none)
  // ===========End Cover page=============
  // =========== Start TOC ==============


  show outline.entry: outrageous.show-entry.with(
    font-weight: ("bold", auto),
    font-style: (auto,),
    vspace: (12pt, none),
    font: ("Noto Sans", auto),
    fill: (none, repeat[~~.]),
    fill-right-pad: .4cm,
    fill-align: true,
    body-transform: none,
    page-transform: none,
  )

  if TOC{
    set page(numbering: "I")
    counter(page).update(1)
    outline(indent: auto, depth: Depth)
    pagebreak(weak: true)
  }
  // =========== End TOC ==============

  let headerDepth = 1 // The depth of the numbering. 1 for 1.1, 2 for 1.1.1, etc. It will check Section, Subsection, Subsubsection, etc.

  // Start page numbering for real after TOC

  // =========== Start Header/Footer ============== 
  set page(numbering: "1")
  show: chic-hdr.chic.with(
    width:100%,
    // BUG: Chic-hdr bug: if nothing follows the heading the header will go up
    chic-hdr.chic-header(
      /*
        Choose place because the banner was too high in contrast with the heading-name
        You can just use image(banner, width: 70%) if you want the default position
        WARNING: If the name of the section is too long, it will overlap the banner and it will no be visible
        The default behaviour doesn't have this problem
      */
      // -14pt or 170% same ??
      left-side: place(dy: -145%, image(banner, width: 70%)), 
      // left-side: image(banner, width: 70%),
      // side-width: 1fr,
      v-center: true,
      right-side: smallcaps([*#helper.placeCurrentSection(level:1)*]),
    ),
    chic-hdr.chic-footer(
      left-side: UE,
      center-side: Subject, 
      right-side: counter(page).display("1"),
    ),
    // gutter: 0.25em to reduce the space between the header and the separator
    // outset: 5pt to add space arout separator beyond the page margins
    chic-hdr.chic-separator(on: "header", 1pt),
    chic-hdr.chic-offset(30%),
    chic-hdr.chic-height(2.5cm),
  )
  counter(page).update(1) // It has to be after. Don't ask me why
  // =========== End Header/Footer ==============

  let kinds = (image, raw, table)

  set figure(numbering: (..nums) => locate((loc) => numbering("1.1",
    ..counter(heading.where(level: 1)).at(loc),
    ..nums
  )))

  // =========== Heading Formatting ==============
  set heading(numbering: "1.1")
  show heading: it =>{
    let base = 22pt 
    set block(breakable: false)
    if it.level == 1 {
      for kind in kinds {
        counter(figure.where(kind: kind)).update(0)
      }
      set text(font: sans-font, size: base, weight: 700)
      block(it, below: 1em)
    }
    else{
      block(it, below: 1.0em, above: 1.5em)
    }
    // FIX: Temporary fix for the first line indent problem
    let a = par(box())
    a
    v(-0.8 * measure(2 * a).width)

  }
  // =========== End Heading Formatting ==============


  // Main body.
  // The first line indent can create weird behaviour with the heading as the heading is treated as a paragraph
  // The default behaviour does not have this problem. But if you use another show method, you have to set the first-line-indent to 0pt in the heading
  set par(justify: true, first-line-indent: First_line_indent)

  show link: it => {
    underline(text(rgb(0, 76, 146), it))
  }

  show bibliography: it => {
    pagebreak(weak: true)
    show: chic-hdr.chic.with(
      width:100%,
      // BUG: Chic-hdr bug: if nothing follows the heading the header will go up
      chic-hdr.chic-header(
        /*
          Choose place because the banner was too high in contrast with the heading-name
          You can just use image(banner, width: 70%) if you want the default position
          WARNING: If the name of the section is too long, it will overlap the banner and it will no be visible
          The default behaviour doesn't have this problem
        */
        // -14pt or 170% same ??
        left-side: place(dy: -145%, image(banner, width: 70%)), 
        // left-side: image(banner, width: 70%),
        // side-width: 1fr,
        v-center: true,
        right-side: smallcaps([*Bibliographie*]),
      ),
      chic-hdr.chic-footer(
        left-side: UE,
        center-side: Subject, 
        right-side: counter(page).display("1"),
      ),
      // gutter: 0.25em to reduce the space between the header and the separator
      // outset: 5pt to add space arout separator beyond the page margins
      chic-hdr.chic-separator(on: "header", 1pt),
      chic-hdr.chic-offset(30%),
      chic-hdr.chic-height(2.5cm),
  )
  [#it]
  };

  show highlight: it =>{
    box(
        // More prettier way to highlight text
        fill: it.fill, inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
        it.body
    )
  }

  body
}

