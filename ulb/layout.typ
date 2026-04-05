#import "@preview/chic-hdr:0.5.0": chic, chic-header, chic-height, chic-offset, chic-separator
#import "@preview/linguify:0.4.2"
#import "utils.typ"

#let ulb-colors = (
  primary: rgb("#04579B"),
  secondary: rgb("#9EB7DE"),
  tertiary: white,
)

#let ulb-heading-fonts = ("Inria Sans", "Liberation Sans")
#let ulb-body-fonts = ("Libertinus Serif", "Liberation Serif")

#let ulb-page-counter-visible = state("ulb-page-counter-visible", false)
#let ulb-page-counter-format = state("ulb-page-counter-format", "1")

#let hide-page-counter() = {
  ulb-page-counter-visible.update(false)
}

#let show-page-counter(numbering: "1", current-page: none) = {
  ulb-page-counter-visible.update(true)
  ulb-page-counter-format.update(numbering)
  if current-page != none {
    counter(page).update(current-page)
  }
}

#let configure-language(language) = {
  let lang-data = toml("lang.toml")
  linguify.set-database(lang-data)
  set text(lang: language)
}

#let display-date(date, compact: false) = {
  if date == none or date == auto {
    return none
  }

  if type(date) == datetime {
    if compact {
      return date.display("[day]/[month]/[year]")
    }

    let (day, month, year) = date.display("[day] [month repr:long] [year]").split(" ")
    let month = linguify.linguify(month)
    return [#day #month #year]
  }

  date
}

#let short-document-name(title, course-code: none, course-name: none) = {
  if utils.has-content(course-code) {
    return [#course-code #sym.hyph #title]
  }
  if utils.has-content(course-name) and course-name != title {
    return [#course-name #sym.hyph #title]
  }
  title
}

#let leading-cover-line(subtitle: none, course-code: none, course-name: none, department: none) = {
  if utils.has-content(subtitle) {
    return subtitle
  }
  if utils.has-content(course-code) and utils.has-content(course-name) {
    return [#course-code #sym.hyph #course-name]
  }
  if utils.has-content(course-name) {
    return course-name
  }
  if utils.has-content(department) {
    return department
  }
  none
}

#let labeled-people(label, people) = {
  let entries = utils.normalize-items(people)
  if entries.len() == 0 {
    return []
  }

  stack(
    dir: ttb,
    spacing: 0.35em,
    text(font: ulb-heading-fonts, size: 0.95em, weight: "bold", linguify.linguify(label) + ":"),
    ..entries.map(entry => entry),
  )
}

#let standard-cover-middle(document-type, authors: (), teachers: (), organization: none, supervisors: ()) = {
  if document-type == "project" {
    stack(
      dir: ttb,
      spacing: 1em,
      labeled-people("Authors", authors),
      if utils.has-content(organization) {
        stack(
          dir: ttb,
          spacing: 0.35em,
          text(font: ulb-heading-fonts, size: 0.95em, weight: "bold", linguify.linguify("Organization") + ":"),
          organization,
        )
      },
      labeled-people("Supervisors", supervisors),
    )
  } else {
    stack(
      dir: ttb,
      spacing: 1em,
      labeled-people("Authors", authors),
      labeled-people("Teachers", teachers),
    )
  }
}

#let standard-cover-bottom(document-type, date, course-code: none, course-name: none, organization-logo: none) = {
  if document-type == "project" and organization-logo != none {
    return organization-logo
  }

  stack(
    dir: ttb,
    spacing: 1em,
    if utils.has-content(course-code) and document-type == "summary" {
      if utils.has-content(course-name) {
        text(font: ulb-heading-fonts, size: 0.9em, weight: "bold")[#course-code #sym.hyph #course-name]
      } else {
        text(font: ulb-heading-fonts, size: 0.9em, weight: "bold")[#course-code]
      }
    },
    if display-date(date, compact: false) != none {
      text(font: ulb-heading-fonts, size: 0.95em, weight: "medium", display-date(date, compact: false))
    },
  )
}

#let render-classic-cover(title, subtitle: none, authors: (), teachers: (), date: none) = {
  set page(background: image("logos/sceau.png", width: 100%, height: 100%))
  align(left, image("logos/logo_text.png", width: 70%))

  set text(font: ulb-body-fonts, 12pt)

  v(9fr)

  if display-date(date) != none {
    text(1.1em)[#display-date(date)]
  }

  v(1.2em, weak: true)
  text(font: ulb-heading-fonts, 2em, weight: 700, title)
  if utils.has-content(subtitle) {
    v(0.6em, weak: true)
    text(font: ulb-heading-fonts, 1.1em, weight: 500, subtitle)
  }

  stack(
    dir: ltr,
    spacing: 40%,
    pad(
      top: 0.7em,
      grid(
        columns: 1,
        gutter: 1.5em,
        labeled-people("Authors", authors),
      ),
    ),
    pad(
      top: 0.7em,
      grid(
        columns: 1,
        gutter: 1.5em,
        labeled-people("Teachers", teachers),
      ),
    ),
  )

  v(2.4fr)
  pagebreak()
  set page(background: none)
}

#let render-front-cover(
  document-type,
  cover-design,
  title,
  subtitle: none,
  authors: (),
  teachers: (),
  course-code: none,
  course-name: none,
  department: none,
  organization: none,
  organization-logo: none,
  supervisors: (),
  date: none,
) = {
  if cover-design == "classic" {
    render-classic-cover(
      title,
      subtitle: subtitle,
      authors: authors,
      teachers: teachers,
      date: date,
    )
    return
  }

  set page("a4", margin: 0cm)
  set par(justify: false)

  let front-image = if cover-design == "highlighted" {
    "assets/covers/highlighted-front.png"
  } else if cover-design == "project" {
    "assets/covers/project-front.png"
  } else {
    "assets/covers/standard-front.png"
  }

  let lead = leading-cover-line(
    subtitle: subtitle,
    course-code: course-code,
    course-name: course-name,
    department: department,
  )

  place(image(front-image, width: 100%))

  if cover-design == "highlighted" {
    place(
      dx: 2.5cm,
      dy: 7.5cm,
      block(
        width: 9.5cm,
        text(fill: white)[
          #if lead != none [
            #text(font: ulb-heading-fonts, size: 18pt, weight: "medium", lead)\
          ]
          #text(font: ulb-heading-fonts, size: 26pt, weight: "bold", title)
          #if display-date(date, compact: false) != none [
            \
            #text(font: ulb-body-fonts, size: 13pt, display-date(date, compact: false))
          ]
        ],
      ),
    )
  } else if cover-design == "project" {
    place(
      dx: 2.5cm,
      dy: 6.5cm,
      block(
        width: 9.5cm,
        text(size: 18pt)[
          #if lead != none [
            #text(font: ulb-body-fonts, size: 16pt, lead)\
          ]
          #text(font: ulb-heading-fonts, size: 22pt, weight: "bold", title)
        ],
      ),
    )

    place(
      dx: 2.5cm,
      dy: 13.7cm,
      block(
        width: 9.5cm,
        height: 14cm,
        align(horizon, text(size: 16pt)[
          #standard-cover-middle(
            document-type,
            authors: authors,
            organization: organization,
            supervisors: supervisors,
          )
        ]),
      ),
    )

    place(
      dx: 12.3cm,
      dy: 25.5cm,
      box(
        width: 7.5cm,
        standard-cover-bottom(
          document-type,
          date,
          organization-logo: organization-logo,
        ),
      ),
    )
  } else {
    place(
      dx: 2.5cm,
      dy: 6.5cm,
      block(
        width: 9.5cm,
        text(size: 18pt)[
          #if lead != none [
            #text(font: ulb-heading-fonts, size: 18pt, weight: "medium", lead)\
          ]
          #text(font: ulb-heading-fonts, size: 28pt, weight: "bold", title)
        ],
      ),
    )

    place(
      dx: 2.5cm,
      dy: 13.7cm,
      block(
        width: 6.5cm,
        height: 7cm,
        align(horizon, text(size: 16pt)[
          #standard-cover-middle(
            document-type,
            authors: authors,
            teachers: teachers,
            organization: organization,
            supervisors: supervisors,
          )
        ]),
      ),
    )

    place(
      dx: 9.5cm,
      dy: 25.5cm,
      box(
        width: 8.5cm,
        standard-cover-bottom(
          document-type,
          date,
          course-code: course-code,
          course-name: course-name,
          organization-logo: organization-logo,
        ),
      ),
    )
  }

  pagebreak()
}

#let back-cover-panel(content) = [
  #set text(font: ulb-body-fonts, size: 14pt)
  #set par(first-line-indent: 0pt)
  #set heading(numbering: none, outlined: false)
  #show heading: it => block(
    text(font: ulb-heading-fonts, size: 16pt, weight: "bold", it.body),
    below: 0.6em,
  )
  #content
]

#let render-back-cover(cover-design, summary-left: none, summary-right: none) = {
  if cover-design == "project" {
    page(footer: none, header: none, margin: 0cm)[
      #place(image("assets/covers/project-back.png", width: 100%))
      #if utils.has-content(summary-left) or utils.has-content(summary-right) [
        #place(
          dx: 1cm,
          dy: 1.2cm,
          block(width: 18.5cm, height: 19.6cm)[
            #if utils.has-content(summary-left) [
              #place(
                dx: -0.2cm,
                dy: 3.5cm,
                block(width: 8.9cm, height: 16cm, back-cover-panel(summary-left)),
              )
            ]
            #if utils.has-content(summary-right) [
              #place(
                dx: 9.2cm,
                block(width: 9.3cm, height: 16cm, inset: 0.2cm, back-cover-panel(summary-right)),
              )
            ]
          ],
        )
      ]
    ]
  } else if cover-design == "classic" {
    page(footer: none, header: none, margin: 0cm)
  } else {
    page(
      footer: none,
      header: none,
      margin: 0cm,
      image("assets/covers/standard-back.png", width: 101%),
    )
  }
}

#let running-section() = {
  let section = utils.placeCurrentSection(level: 1)
  if section == " " { [] } else { section }
}

#let ulb-header-text-size = 13pt
#let ulb-header-logo-size = 5cm
#let ulb-header-separator-gap = 0.2cm
#let ulb-header-height = 2.5cm
#let ulb-header-offset = 20pt

#let default-header(document-type, title, course-code: none, course-name: none) = {
  if document-type == "summary" {
    return (
      left: image("assets/banner.png", width: ulb-header-logo-size),
      right: text(weight: "bold")[#running-section()],
    )
  }

  (
    left: smallcaps(short-document-name(title, course-code: course-code, course-name: course-name)),
    right: text(weight: "bold")[#running-section()],
  )
}

#let default-footer-label(document-type, title, course-code: none, course-name: none) = {
  if document-type == "summary" and utils.has-content(course-code) and utils.has-content(course-name) {
    return [#course-code #sym.hyph #course-name]
  }
  if utils.has-content(title) {
    return title
  }
  none
}

#let page-shell(
  document-type,
  title,
  course-code: none,
  course-name: none,
  custom-header: auto,
  body,
) = {
  let tone(content) = [
    #set text(font: ulb-heading-fonts, size: ulb-header-text-size, fill: luma(70))
    #content
  ]

  if custom-header == none {
    return body
  }

  if custom-header != auto {
    return chic(
      chic-header(
        v-center: true,
        center-side: tone(custom-header),
        side-width: (0fr, 1fr, 0fr),
      ),
      chic-separator(on: "header", gutter: ulb-header-separator-gap, 0.6pt + luma(155)),
      chic-height(on: "header", ulb-header-height),
      chic-offset(on: "header", ulb-header-offset),
      body,
    )
  }

  let header = default-header(
    document-type,
    title,
    course-code: course-code,
    course-name: course-name,
  )

  chic(
    chic-header(
      v-center: true,
      side-width: if document-type == "summary" { (ulb-header-logo-size, 0fr, 1fr) } else { none },
      left-side: tone(header.left),
      right-side: tone(header.right),
    ),
    chic-separator(on: "header", gutter: ulb-header-separator-gap, 0.6pt + luma(155)),
    chic-height(on: "header", ulb-header-height),
    chic-offset(on: "header", ulb-header-offset),
    body,
  )
}

#let page-footer(
  document-type,
  title,
  course-code: none,
  course-name: none,
  custom-footer: auto,
) = context {
  let footer-label = default-footer-label(
    document-type,
    title,
    course-code: course-code,
    course-name: course-name,
  )

  place(
    right + bottom,
    dx: page.margin.at("right") - 0.6cm,
    dy: -0.6cm,
    box(width: 2.34cm, height: 2.34cm, image("assets/footer-badge.png")),
  )

  if ulb-page-counter-visible.get() {
    place(
      right + bottom,
      dx: page.margin.at("right") - 0.6cm,
      dy: -0.6cm,
      box(
        width: 1.15cm,
        height: 1.15cm,
        align(
          center + horizon,
          text(
            fill: white,
            size: 14pt,
            font: ulb-heading-fonts,
            weight: "bold",
            counter(page).display(ulb-page-counter-format.get()),
          ),
        ),
      ),
    )
  }

  if custom-footer == auto and footer-label != none {
    [

      #set par(justify: false, first-line-indent: 0pt)
      #set text(font: ulb-heading-fonts, size: 9pt, fill: luma(120), weight: "semibold")
      #footer-label
    ]
  } else if custom-footer != auto and custom-footer != none and custom-footer != [] {
    custom-footer
  }
}
