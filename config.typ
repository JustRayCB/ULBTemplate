#import "ulb/template.typ": Template
#import "ulb/boxes.typ": popup, borderBox

// https://typst.app/universe/package/linguify
#import "@preview/linguify:0.4.2"

// https://typst.app/universe/package/octique
#import "@preview/octique:0.1.0": octique

// https://typst.app/universe/package/codly
#import "@preview/codly:1.2.0"

#let language-data = toml("ulb/lang.toml")
#linguify.set-database(language-data)

// -----------------------------
// Document
// -----------------------------
#let document-type = "summary" // "summary", "report", "project"
#let language = "en"
#let title = "Ray's Template"
#let subtitle = "Course summary"
#let authors = ("Ray",)
#let date = datetime.today()

// -----------------------------
// Course information
// -----------------------------
#let course-code = "INFO-F530"
#let course-name = "Advanced topics in machine learning"
#let teachers = ("M. Name",)

// -----------------------------
// Structure
// -----------------------------
#let show-outline = false
#let show-figure-outline = false
#let pagebreak-before-level-1-headings = document-type == "summary"
#let first-line-indent = 20pt

// -----------------------------
// Project-only fields
// -----------------------------
#let department = none
#let organization = none
#let organization-logo = none
#let supervisors = ()
#let summary-left = none
#let summary-right = none
#let show-back-cover = auto

// -----------------------------
// Advanced layout
// -----------------------------
#let cover-design = auto // auto, standard, highlighted, project, classic
#let custom-header = auto
#let custom-footer = auto

// -----------------------------
// Boxes
// -----------------------------
#let box-kinds = (
  "definition",
  "theorem",
  "proof",
  "example",
  "proposition",
  "corollary",
  "lemma",
  "remark",
  "notation",
  "warning",
)

#let box-colors = (
  definition: teal,
  theorem: blue,
  proof: color.eastern,
  example: orange,
  proposition: maroon,
  corollary: yellow,
  lemma: aqua,
  remark: lime,
  notation: purple,
  warning: red,
)

#let template = Template.with(
  document-type: document-type,
  language: language,
  title: title,
  subtitle: subtitle,
  authors: authors,
  date: date,
  course-code: course-code,
  course-name: course-name,
  teachers: teachers,
  show-outline: show-outline,
  show-figure-outline: show-figure-outline,
  pagebreak-before-level-1-headings: pagebreak-before-level-1-headings,
  first-line-indent: first-line-indent,
  department: department,
  organization: organization,
  organization-logo: organization-logo,
  supervisors: supervisors,
  summary-left: summary-left,
  summary-right: summary-right,
  show-back-cover: show-back-cover,
  cover-design: cover-design,
  custom-header: custom-header,
  custom-footer: custom-footer,
  kinds: box-kinds,
)

#let definition = popup.with(
  kind: "definition",
  supplement: linguify.linguify("Definition"),
  color: box-colors.definition,
)

#let theorem = popup.with(
  kind: "theorem",
  supplement: linguify.linguify("Theorem"),
  color: box-colors.theorem,
)

#let proof = borderBox.with(
  kind: "proof",
  supplement: linguify.linguify("Proof"),
  color: box-colors.proof,
  icon: octique("bookmark", color: box-colors.proof),
)

#let example = borderBox.with(
  kind: "example",
  supplement: linguify.linguify("Example"),
  color: box-colors.example,
  icon: octique("flame", color: box-colors.example),
)

#let proposition = popup.with(
  kind: "proposition",
  supplement: linguify.linguify("Proposition"),
  color: box-colors.proposition,
)

#let corollary = popup.with(
  kind: "corollary",
  supplement: linguify.linguify("Corollary"),
  color: box-colors.corollary,
)

#let lemma = popup.with(
  kind: "lemma",
  supplement: linguify.linguify("Lemma"),
  color: box-colors.lemma,
)

#let remark = borderBox.with(
  kind: "remark",
  supplement: linguify.linguify("Remark"),
  color: box-colors.remark,
  icon: octique("light-bulb", color: box-colors.remark),
)

#let notation = popup.with(
  kind: "notation",
  supplement: linguify.linguify("Notation"),
  color: box-colors.notation,
)

#let warning = borderBox.with(
  kind: "warning",
  supplement: linguify.linguify("Warning"),
  color: box-colors.warning,
  icon: octique("alert", color: box-colors.warning),
)

#let noindent() = {
  h(-first-line-indent)
}

#let indent() = {
  h(first-line-indent)
}

#let unnumbered(body) = {
  set heading(numbering: none)
  body
}
