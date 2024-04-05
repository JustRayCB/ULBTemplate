#import "@preview/chic-hdr:0.4.0" // Library for headers and footers
#import "@preview/outrageous:0.1.0" // Library for TOC formatting
#import "@preview/linguify:0.3.1" // Library for language support
#import "@preview/i-figured:0.2.4"
#import "utils.typ"

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
  kinds: (),
  extra-pref: (),
  body,
) = {
  // Set the document's basic properties.
  // ===========Cover page=============
  set document(author: Authors, title: Title)
  let banner= "logos/banner.png"
  let logo = "logos/logo.jpg"
  let sceau = "logos/sceau.png"
  // Save heading and body font families in variables.
  let body-font = "Linux Libertine"
  let sans-font = "Inria Sans"

  set page(background: image(sceau, width: 100%, height: 100%))
  align(right, image(logo, width: 26%))

  // Set body font family.
  set text(font: body-font, lang: "fr", 12pt)

  v(9fr)

  // ===========Date and Title=============
  let lang_data = toml("lang.toml")
  linguify.linguify_set_database(lang_data)
  let (day, month, year) = Date.split(" ")
  let month = linguify.linguify(month) // Translate the month to French
  text(1.1em)[#day #month #year] 

  v(1.2em, weak: true)
  text(font: sans-font, 2em, weight: 700, Title)
  // ===========End Date and Title=============


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

  let configChic = utils.configChicHdr(
    headerLeft: banner,
    headerRight: smallcaps([*#utils.placeCurrentSection(level: 1)*]), 
    footerLeft: UE,
    footerCenter: Subject
  )
  show: chic-hdr.chic.with(
    width: 100%,
    ..configChic.values()
  )
  counter(page).update(1) // It has to be after. Don't ask me why

  // =========== End Header/Footer ==============
  // =========== Heading Formatting ==============
  set heading(numbering: "1.1")
  show heading: it =>{
    let base = 22pt 
    set block(breakable: false)
    let below // The space below the heading
    if it.level == 1 {
      set text(font: sans-font, size: base, weight: 700)
      for kind in kinds {
        counter(figure.where(kind: kind)).update(0)
      }
      below = 0.8em
      block(it, below: below)
    }
    else{
      below = 0.5em
      block(it, below: below, above: 1.5em)
    }
    // FIX: Temporary fix for the first line indent problem
    text()[#v(below, weak: true)];text()[#h(0em)];parbreak()

  }
  // =========== End Heading Formatting ==============


  // Main body.
  // The first line indent can create weird behaviour with the heading as the heading is treated as a paragraph
  // The default behaviour does not have this problem. But if you use another show method, you have to set the first-line-indent to 0pt in the heading
  set par(justify: true, first-line-indent: First_line_indent)

  show link: it => {
    if it.has("dest") and type(it.at("dest")) == label {
      // If the link is a reference to a figure, we want to display it bold
      return strong()[#it]
    }
    underline(text(rgb(0, 76, 146), it))
  }

  // =========== Bibliography ==============
  configChic = utils.configChicHdr(
    headerLeft: banner,
    headerRight: smallcaps([*Bibliographie*]),
    footerLeft: UE,
    footerCenter: Subject
  )

  show bibliography: it => {
    pagebreak(weak: true)
    show: chic-hdr.chic.with(
      width:100%,
      ..configChic.values()
  )
  [#it]
  };
  // =========== End Bibliography ==============

  show highlight: it =>{
    box(
        // More prettier way to highlight text
        fill: it.fill, inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
        it.body
    )
  }

  show ref: it => {
    if it.element != none and it.element.func() == block{
      // Here we want to refercence a block (which normally isn't possible)
      let fig
      let ele = it.element
      if ele.has("body") and ele.body.func() == figure {
        // We juste want to ref the blocks that contains a figure
        fig = ele.body
      }
      if fig != none {
        let kind = fig.kind
        let supplement = fig.supplement
        let figNb = context (counter(ele.location()).get()).at(0)
        let sectionNb = context (utils.getSectionNumber()).at(0)
        return link(ele.label)[#strong()[#supplement #sectionNb.#figNb]]
      }
    }
    strong()[#it]

  }

  show heading: i-figured.reset-counters.with(level: 1, extra-kinds: kinds)
  show figure: i-figured.show-figure.with(extra-prefixes: extra-pref)
  show math.equation: i-figured.show-equation

  body
}

