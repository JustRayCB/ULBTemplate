#import "@preview/chic-hdr:0.4.0" // Library for headers and footers
#import "helper.typ"
#import "config.typ"
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
  let headingPrefix = "# "
  let headingOffset = 1
  // Set the document's basic properties.
  // ===========Cover page=============
  set document(author: Authors, title: Title)
  let banner= "./logos/banner.png"
  let logo = "./logos/logo.jpg"
  let sceau = "./logos/sceau.png"
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
  // ===========End Cover page=============
  // =========== Start TOC ==============

  set page(background: none)

  if TOC{
    set page(numbering: "I")
    counter(page).update(1)
    outline(indent: auto, depth: Depth)
    pagebreak(weak: true)
  }
  // =========== End TOC ==============

  // Start page numbering for real after TOC

  // =========== Start Header/Footer ============== 
  set page(numbering: "1")
  show: chic-hdr.chic.with(
    width:100%,
    chic-hdr.chic-header(
      /*
        Choose place because the banner was too high in contrast with the heading-name
        You can just use image(banner, width: 70%) if you want the default position
        WARNING: If the name of the section is too long, it will overlap the banner and it will no be visible
        The default behaviour doesn't have this problem
      */
      // -14pt or 170% same ??
      left-side: place(dy: -170%, image(banner, width: 70%)), 
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
    chic-hdr.chic-separator(1pt),
    chic-hdr.chic-offset(7pt),
    chic-hdr.chic-height(2cm),
  )
  counter(page).update(1) // It has to be after. Don't ask me why
  // =========== End Header/Footer ==============

  set heading(numbering: "1.1")
  // show heading: it => {
  //   [ #counter(heading).display() #it.body \ ]
  // }
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    [
      #set heading(numbering: "1")
      #set text(size: 22pt)
      #set align(left)
      #set text(hyphenate: false)
      #set par(justify: false, linebreaks: "optimized")
      #v(3%) 
      #it
      #v(3%)
      // #line(length: 100%, stroke: 1pt)
  ]}






  // Main body.
  set par(justify: true, first-line-indent: First_line_indent)


  body
}

#let fi(..arguments) = {
  // Function to set the first line indent
    let fi = 20pt
    if arguments.pos().len() != 0{
        fi = arguments.pos().first()
    }
    h(fi)
}
