#import "@preview/outrageous:0.4.0"
#import "layout.typ"

#let Template(
  document-type: "summary",
  language: "en",
  title: "Titre",
  subtitle: none,
  authors: (),
  date: datetime.today(),
  course-code: none,
  course-name: none,
  teachers: (),
  show-outline: true,
  show-figure-outline: false,
  pagebreak-before-level-1-headings: false,
  department: none,
  organization: none,
  organization-logo: none,
  supervisors: (),
  summary-left: none,
  summary-right: none,
  show-back-cover: auto,
  cover-design: auto,
  custom-header: auto,
  custom-footer: auto,
  depth: 5,
  first-line-indent: 20pt,
  kinds: (),
  body,
) = {
  let box-kinds = kinds
  let figure-kinds = box-kinds + (figure, table, image)

  let resolved-cover = if cover-design == auto {
    if document-type == "project" { "project" } else { "standard" }
  } else {
    cover-design
  }

  let include-back-cover = if show-back-cover == auto {
    document-type == "project"
  } else {
    show-back-cover
  }

  layout.configure-language(language)
  set document(
    author: authors,
    title: title,
    date: if type(date) == datetime { date } else { auto },
  )
  set text(font: layout.ulb-body-fonts, lang: language, 12pt)

  layout.render-front-cover(
    document-type,
    resolved-cover,
    title,
    subtitle: subtitle,
    authors: authors,
    teachers: teachers,
    course-code: course-code,
    course-name: course-name,
    department: department,
    organization: organization,
    organization-logo: organization-logo,
    supervisors: supervisors,
    date: date,
  )

  set page("a4", margin: (x: 1.75cm, y: 2.5cm))

  let main-content = {
    set page(
      footer: layout.page-footer(
        document-type,
        title,
        course-code: course-code,
        course-name: course-name,
        custom-footer: custom-footer,
      ),
    )

    let rendered-outline = show-outline or show-figure-outline
    if rendered-outline {
      layout.show-page-counter(numbering: "I", current-page: 1)

      if show-outline {
        set heading(outlined: true)
        show outline.entry: outrageous.show-entry.with(
          ..outrageous.presets.outrageous-toc,
          font: (layout.ulb-heading-fonts, layout.ulb-body-fonts),
          state-key: "ulb-outline-toc",
        )
        outline(indent: auto, depth: depth)
        if show-figure-outline {
          pagebreak(weak: true)
        }
      }

      if show-figure-outline {
        context {
          for (index, kind) in figure-kinds.enumerate() {
            let target = selector(figure.where(kind: kind, outlined: true))
            let figures = query(target)
            if figures.len() > 0 {
              let supplement = figures.first().supplement
              let title = if language == "fr" {
                [Liste des #lower(supplement + [s])]
              } else {
                [List of #lower(supplement + [s])]
              }
              show outline.entry: outrageous.show-entry.with(
                ..outrageous.presets.outrageous-figures,
                font: (layout.ulb-body-fonts,),
                state-key: "ulb-outline-figures-" + str(index),
              )
              outline(title: title, target: target)
              pagebreak(weak: true)
            }
          }
        }
      }
    }

    layout.show-page-counter(numbering: "1", current-page: 1)

    show heading: set text(font: layout.ulb-heading-fonts, weight: "bold")
    set text(font: layout.ulb-body-fonts, weight: "regular")
    set heading(numbering: "1.1")
    set figure(numbering: (..nums) => {
      let section-number = counter(heading.where(level: 1)).get().first()
      numbering("1.1", section-number, ..nums)
    })

    set math.equation(numbering: (..nums) => {
      let section-number = counter(heading.where(level: 1)).get().first()
      numbering("(1.1)", section-number, ..nums)
    })

    show heading: it => {
      let base = if document-type == "project" { 20pt } else { 22pt }
      set block(breakable: false)

      if it.level == 1 {
        if pagebreak-before-level-1-headings {
          pagebreak(weak: true)
        }
        set text(font: layout.ulb-heading-fonts, size: base, weight: 700)
        for kind in figure-kinds {
          counter(figure.where(kind: kind)).update(0)
        }
        block(it, below: 1em)
      } else {
        block(it, below: 1em, above: 1.5em)
      }
    }

    set par(justify: true, first-line-indent: (amount: first-line-indent, all: true))

    show link: it => {
      if it.has("dest") and type(it.at("dest")) == label {
        return strong()[#it]
      } else if it.has("dest") and type(it.at("dest")) == location {
        return strong()[#it]
      }
      underline(text(layout.ulb-colors.primary, it))
    }

    show ref: it => {
      if it.has("target") and type(it.at("target")) == label {
        return strong()[#it]
      } else if it.has("target") and type(it.at("target")) == location {
        return strong()[#it]
      }
      underline(text(layout.ulb-colors.primary, it))
    }

    set highlight(radius: 2pt)

    show figure.caption: it => {
      [
        #strong[#it.supplement #context it.counter.display(it.numbering):]
        #h(0.35em)
        #it.body
      ]
    }

    show figure: it => {
      if it.kind in box-kinds {
        return [
          #v(0.8em)
          #set block(breakable: true)
          #it.body
          #v(0.8em)
        ]
      }
      [#set block(breakable: true); #it]
    }

    set list(indent: 10pt)
    set enum(indent: 10pt)

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

    if include-back-cover {
      layout.render-back-cover(
        resolved-cover,
        summary-left: summary-left,
        summary-right: summary-right,
      )
    }
  }

  layout.page-shell(
    document-type,
    title,
    course-code: course-code,
    course-name: course-name,
    custom-header: custom-header,
    main-content,
  )
}
