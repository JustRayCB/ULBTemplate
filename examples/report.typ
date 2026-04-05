#import "../ulb/template.typ": Template

#show: Template.with(
  document-type: "report",
  language: "en",
  title: "Lab Report",
  subtitle: "Optics experiment",
  authors: ("Jane Doe", "John Doe"),
  date: datetime.today(),
  course-code: "PHYS-F-101",
  course-name: "Experimental Physics",
  teachers: ("Prof. Example",),
  show-outline: true,
)

= Introduction

#lorem(80)

= Method

#lorem(120)

= Results

#figure(
  rect(width: 70%, height: 3cm, fill: luma(235)),
  caption: [Illustrative result placeholder],
)

#lorem(60)
