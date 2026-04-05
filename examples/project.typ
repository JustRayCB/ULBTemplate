#import "../ulb/template.typ": Template

#show: Template.with(
  document-type: "project",
  language: "en",
  title: "ULB Capstone Project",
  subtitle: "Applied machine learning",
  authors: ("Jane Doe",),
  date: datetime.today(),
  department: "Computer science engineering",
  organization: "Universite Libre de Bruxelles",
  organization-logo: image("../ulb/assets/logos/logo-square.png", width: 2.4cm),
  supervisors: ("Prof. Example", "Dr. Sample"),
  show-outline: true,
  summary-left: [
    = Executive Summary
    #lorem(90)
  ],
  summary-right: [
    = Abstract
    #lorem(90)
  ],
)

= Context

#lorem(120)

= Architecture

#lorem(140)

= Conclusion

#lorem(70)
