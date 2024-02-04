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
  Heading_prefix: "# ",
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
  // ===========End Cover page=============
  // =========== Start TOC ==============

  set page(background: none)

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
  let kinds = ("result", "note", "showcase", "definition", "proof")
  // Styling
  // URLs

  // TODO: References the boxes
  show ref: it => {
    if it.element != none {
      let fig
      let ele = it.element
      let secNumber = counter(heading).at(ele.location())
      let currentSec = counter(heading).at(it.location())
      let sameSec = false
      if secNumber == currentSec { sameSec = true }
      while secNumber.len() < headerDepth { secNumber.push(0) }
      if secNumber.len() > headerDepth { 
        secNumber = secNumber.slice(0, headerDepth)
      }
      secNumber = numbering("1.", ..secNumber)
      
      if ele.has("child") and ele.child.func() == figure {
        fig = ele.child
      } 
      if ele.func() == figure { fig = ele }
      if fig != none {
        let kind = fig.kind  
        if kind in kinds {
          let figNumber = counter("meta:Attachments").at(ele.location())
          figNumber = figNumber.first() + 1
          figNumber = numbering("1", figNumber)
          // Detect if it's named

          if fig.has("label") and fig.label == <meta:Named> {
            // FIX: This is not working even if there is a title
            let previousNamed = query(selector(<meta:NamedTitle>).after(ele.location()), ele.location())
            let title = previousNamed.first()
            let ref = link(ele.location())[#show text: strong; #title (#fig.supplement#secNumber#figNumber)]
            return ref
          }
          let ref = link(ele.location())[#show text: strong; #fig.supplement#secNumber#figNumber]
          return ref // TODO: Split up finding stuff into helper functions
    }}}
    it
  }


  // Attachment Resetting when (sub)sections change
  show heading.where(): it => {
    if it.level > headerDepth {
      it
    } else {
      [#it#counter("meta:Attachments").update(0)]
  }}


  // Attachment Counting
  show figure: it => {
    if it.kind in kinds {
      let increment = counter("meta:Attachments").step()
      [#increment]
    }
    [#it]
  }
  show <meta:NumberHere>: it => {
    // Get section numbers
    let numbers = counter(heading).at(it.location())
    while numbers.len() < headerDepth { numbers.push(0) }
    if numbers.len() > headerDepth { 
      numbers = numbers.slice(0, headerDepth)
    }
    // Format and append figure number.
    numbers = numbering("1.", ..numbers) + str(counter("meta:Attachments").at(it.location()).first())
    // Increment the attachments.
    return [#it#numbers]
  }
  // set math.equation(numbering: "(1)")

   // Remove captions
  show figure.caption: it => {
    if it.kind in kinds { return }
    it
  }




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
    chic-hdr.chic-offset(30%),
    chic-hdr.chic-height(2.5cm),
  )
  counter(page).update(1) // It has to be after. Don't ask me why
  // =========== End Header/Footer ==============

  // =========== Heading Formatting ==============
  set heading(numbering: "1.1")
  show heading: it =>{
    set par(first-line-indent: 0pt) // Typst treats heading as paragraph, while there exists some weird behaviour,
    let number = counter(heading).display()
    if it.level != 1{
      [
        #number #it.body // For some reason the prefix fix the first line indent problem
        // #it // While the default behaviour doesn't
        #v(2mm)
      ]
    }
    else{
      pagebreak(weak: true)
      // I have to set the first-line-indent to 0pt for the heading
      set text(size: 22pt)
      v(1%) 
      if ("Bibliographie", "Références").contains(it.body.text){
        [#it]
      }
      else{
        let prefix = Heading_prefix.split("#")
        prefix = prefix.join(number) // The prefix allow to have a different prefix than usual
        [
          #prefix #it.body // For some reason the prefix fix the first line indent problem
          // #it // While the default behaviour doesn't
        ]
      }
      v(2%) // I prefer to have a space between the heading and the text. If you use this, you don't have to put '/' after
    }
  }
  // =========== End Heading Formatting ==============


  // Main body.
  // The first line indent can create weird behaviour with the heading as the heading is treated as a paragraph
  // The default behaviour does not have this problem. But if you use another show method, you have to set the first-line-indent to 0pt in the heading
  set par(justify: true, first-line-indent: First_line_indent)
  show link: it => {
    underline(text(blue, it))
  }


  body
}

