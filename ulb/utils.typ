#import "@preview/chic-hdr:0.4.0" // Library for headers and footers
/*
* Get the current section of the page.
* It takes the level of the section as an argument and returns the current section.
* If the current section is not found, it returns an empty string.
*/
#let placeCurrentSection(level: 1) = {
  // function taken from discord https://discord.com/channels/1054443721975922748/1160978608538533968/1161372706965557258

  context {
    let prev = query(selector(heading.where(level: level)).before(here()))
    let next = query(selector(heading.where(level: level)).after(here()))
    let last = if prev != () { prev.last() }
    let next = if next != () { next.first() }

    let last-eligible = last != none and last.numbering != none
    let next-eligible = next != none and next.numbering != none 
    let next-on-current-page = if next != none {
      next.location().page() == here().page()
    } else {
      false
    }

    let heading = if next-eligible  and next-on-current-page {
      numbering(next.numbering, ..counter(heading).at(next.location())) + [. ] + next.body
    } else if last-eligible  and  not next-on-current-page {
      numbering(last.numbering, ..counter(heading).at(last.location())) + [. ] + last.body
    }else {
      // If there is a next section on the current page but without numbering and has a body then return the body
      if next != none and next.has("body") and type(next.body) == content{
        next.body
      }
      else{
        " "
      }

    }
    return heading
  }
}

#let getSectionNumber(level: 1, location: "") = {
  if location == ""{
    return counter(heading.where(level: level)).get()
  }else{
    return counter(heading.where(level: level)).at(location)
  }
}


/*
* Config chic-hdr header and footer
*/
#let configChicHdr(headerLeft: "logs/banner.png", headerRight: "", footerLeft: "UE", footerCenter: "Subject") = {
  if type(headerLeft) == str {
    headerLeft = place(dy: -145%, image(headerLeft, width: 70%))
  }
  if type(headerRight) == str {
    headerRight = place(dx: 30%, dy: -145%, image(headerRight, width: 70%))
  }
  let config = (
      // BUG: Chic-hdr bug: if nothing follows the heading the header will go up
      header: chic-hdr.chic-header(
        /*
          Choose place because the banner was too high in contrast with the heading-name
          You can just use image(banner, width: 70%) if you want the default position
          WARNING: If the name of the section is too long, it will overlap the banner and it will no be visible
          The default behaviour doesn't have this problem
        */
        // -14pt or 170% same ??
        left-side: headerLeft,
        // left-side: image(banner, width: 70%),
        v-center: true,
        right-side: headerRight,
      ),
      footer: chic-hdr.chic-footer(
        left-side: footerLeft,
        center-side: footerCenter, 
        right-side: context {counter(page).display("1")},
      ),
      // gutter: 0.25em to reduce the space between the header and the separator
      // outset: 5pt to add space arout separator beyond the page margins
      sep : chic-hdr.chic-separator(on: "header", 1pt),
      offset: chic-hdr.chic-offset(30%),
      height: chic-hdr.chic-height(2.5cm),
  )
  return config
}
