#let Template(
  Title: "Titre",
  UE: "Unité d'enseignement",
  Subject: "Sujet",
  Authors: (),
  Teachers: (),
  Date: datetime.today().display("[day] [month repr:long] [year]"),
  TOC: true,
  Depth: 5,
  body,
) = {
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
  set page(numbering: "1")
  counter(page).update(1)

  // =========== Start Header ============== 






  set heading(numbering: "1.")
  set math.equation(numbering: (sym.dots.h.c + " (1)"))
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )
  show link: it => {
    underline(offset: 3pt, text(blue, it.body))
  }

  // Main body.
  set par(justify: true, first-line-indent: 20pt)


  body
}

