#import "@preview/chic-hdr:0.5.0" // Library for headers and footers
#import "@preview/outrageous:0.4.0" // Library for TOC formatting
#import "@preview/linguify:0.4.2" // Library for language support
#import "@preview/i-figured:0.2.4"
#import "@preview/equate:0.1.0": equate
#import "utils.typ"

#let Template(
  language: "en",
  title: "Titre",
  ue: "Unité d'enseignement",
  subject: "Sujet",
  authors: (),
  teachers: (),
  date: datetime.today().display("[day] [month repr:long] [year]"),
  toc: true,
  fig_toc: true,
  depth: 5,
  first_line_indent: 20pt,
  kinds: (),
  extra-pref: (),
  body,
) = {
  // Set the document's basic properties.
  // ===========Cover page=============
  kinds = kinds + (figure, table, image)
  set document(author: authors, title: title)
  let banner = "logos/banner.png"
  let logo = "logos/logo_text.png"
  let sceau = "logos/sceau.png"
  // Save heading and body font families in variables.
  let body-font = "Libertinus Serif"
  let sans-font = "Inria Sans"

  set page(background: image(sceau, width: 100%, height: 100%))
  align(left, image(logo, width: 70%))

  // Set body font family.
  set text(font: body-font, lang: language, 12pt)

  v(9fr)

  // ===========Date and Title=============
  let lang_data = toml("lang.toml")
  linguify.set-database(lang_data)
  let (day, month, year) = date.split(" ")
  let month = linguify.linguify(month) // Translate the month to French
  text(1.1em)[#day #month #year]

  v(1.2em, weak: true)
  text(font: sans-font, 2em, weight: 700, title)
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
        text(font: sans-font, style: "oblique", size: 1.2em, weight: 1000, linguify.linguify("Students")+":"),
        ..authors.map(author => align(start, smallcaps(author))),
      ),
    ),
    pad(
      top: 0.7em,
      // right: 20%,
      grid(
        columns: 1, //(1fr,),  // * calc.min(3, authors.len()),
        gutter: 1.5em,
        text(font: sans-font, style: "oblique", size: 1.2em, weight: 1000, linguify.linguify("Teachers") + ":"),
        ..teachers.map(teacher => align(start, smallcaps(teacher))),
      ),
    ),
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

  if toc {
    set page(numbering: "I")
    counter(page).update(1)
    outline(indent: auto, depth: depth)
    pagebreak(weak: true)
    if fig_toc {
      /*
      * TOC of figures
      */
      {
        // reset entry style to default
        show outline.entry: outrageous.show-entry.with(
          ..outrageous.presets.typst,
          vspace: (12pt, none),
          fill: (repeat[~~.], none),
          fill-right-pad: 0.4cm,
          fill-align: true,
        )
        show heading: set heading(outlined: true) // add the heading of the TOC of figures to the TOC
        context {
          for kind in kinds {
            let all_figs = query(selector(figure.where(kind: kind, outlined:true))) // get all the figures of a kind
            if all_figs.len() > 0 {
              let supplement = all_figs.first().supplement
              supplement = supplement + [s]
              i-figured.outline(target-kind: kind, title: [Liste des #lower(supplement)])
            }
          }
        }
      }
    }
    pagebreak(weak: true)

  }
  // =========== End TOC ==============

  let headerDepth = 1 // The depth of the numbering. 1 for 1.1, 2 for 1.1.1, etc. It will check Section, Subsection, Subsubsection, etc.

  // Start page numbering for real after TOC

  // =========== Start Header/Footer ==============
  set page(numbering: "1")

  let configChic = utils.configChicHdr(
    headerLeft: banner,
    headerRight: smallcaps(text(font: sans-font)[*#utils.placeCurrentSection(level: 1)*]),
    footerLeft: ue,
    footerCenter: subject,
  )
  show: chic-hdr.chic.with(
    width: 100%,
    ..configChic.values(),
  )
  counter(page).update(1) // It has to be after. Don't ask me why

  // =========== End Header/Footer ==============
  // =========== Heading Formatting ==============
  set heading(numbering: "1.1")
  // TODO: REMOVE I-FIGURED DEPENDENCY for figures and headings
  show heading: i-figured.reset-counters.with(level: 1, extra-kinds: kinds)
  show figure: i-figured.show-figure.with(extra-prefixes: extra-pref)
  show: equate.with(sub-numbering: false, number-mode: "label")
  set math.equation(numbering: (..nums) => {
    numbering("(1.1)", counter(heading).get().first(), ..nums)
  })


  show heading: it => {
    let base = 22pt
    set block(breakable: false)
    let below // The space below the heading
    if it.level == 1 {
      pagebreak(weak: true) // BUG: with for loop to reset kinds counters and i-figured reset
      set text(font: sans-font, size: base, weight: 700)
      for kind in kinds + (figure, table, image) {
        counter(figure.where(kind: kind, outlined: true)).update(0)
      }
      below = 0.8em
      // The heading of chic is not displayed correctly
      block(it, below: below)
    } else {
      below = 1em
      block(it, below: below, above: 1.5em)
    }

  }
  // =========== End Heading Formatting ==============


  // Main body.
  // The first line indent can create weird behaviour with the heading as the heading is treated as a paragraph
  // The default behaviour does not have this problem. But if you use another show method, you have to set the first-line-indent to 0pt in the heading
  set par(justify: true, first-line-indent: (amount: first_line_indent,all: true))

  show link: it => {
    if it.has("dest") and type(it.at("dest")) == label {
      // If the link is a reference to a figure, we want to display it bold
      return strong()[#it]
    } else if it.has("dest") and type(it.at("dest")) == location {
      return strong()[#it] // To link math equations
    }
    underline(text(rgb(0, 76, 146), it))
  }

  // =========== Bibliography ==============
  // =========== End Bibliography ==============

  set highlight(radius: 2pt)

  show ref: it => {
    if it.element != none and it.element.has("child") and it.element.child.func() == block {
      let my_block = it.element.child
      let fig
      if my_block.has("body") and my_block.body.func() == figure {
        fig = my_block.body
      }
      if fig != none {
        let kind = fig.kind
        let supplement = fig.supplement
        if fig.outlined {
          let figNb = context counter(figure.where(kind: kind, outlined: true))
            .at(it.element.location())
            .first() + 1
          let sectionNb = context (utils.getSectionNumber(location: it.element.location())).first()
          return link(it.target)[#strong()[#supplement #sectionNb.#figNb]]
        } else {
          return link(it.target)[#strong()[#supplement]]
        }
      }
    } else if it.element != none and it.element.func() == block {
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
        // +1 because we want the counter for this figure not the one before
        if fig.outlined {
          let figNb = context counter(figure.where(kind: kind, outlined: true))
            .at(ele.location())
            .first() + 1
          let sectionNb = context (utils.getSectionNumber(location: ele.location())).first()
          return link(ele.label)[#strong()[#supplement #sectionNb.#figNb]]
        } else {
          return link(ele.label)[#strong()[#supplement]]
        }
      }
    } else if it.element != none and it.element.func() == figure {
      let fig = it.element
      let kind = fig.kind
      if kind in kinds {
        // If the figure is in the list of kinds
        let supplement = fig.supplement
        if fig.outlined {
          let figNb = context counter(figure.where(kind: kind, outlined: true))
            .at(it.location())
            .first()
          let sectionNb = context (utils.getSectionNumber(location: fig.location())).at(0)
          return link(it.target)[#strong()[#supplement #sectionNb.#figNb]]
        } else {
          return link(it.target)[#strong()[#supplement]]
        }
      }
    }
    strong()[#it]

  }

  show figure: it => {
    return [#set block(breakable: true); #it]
  }

  set list(indent: 10pt)
  set enum(indent: 10pt)

  // Don't know if it is realy useful
  /* show terms.item: it => pad(left: First_line_indent, {
  let term = strong(it.term)
  h(-First_line_indent)
  term
  h(0.6em, weak: true)
  it.description
  }) */


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



  body
}

