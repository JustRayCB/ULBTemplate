#import "config.typ"

// Rebindings
#let _typst-numbering = numbering

// General
#let multiIndex(table, ..keys) = {
  keys = keys.pos()
  assert(keys.len() > 0, message: "No keys provided.")
  let value = table
  // If an index error is thrown here, you probably passed too many arguments.
  while keys.len() > 0 { value = value.at(keys.pop()) }
  return value
} 
#let contentToString(content, recursion: 0) = {
  // return content.fields()
  if content.has("body") {
    return contentToString(content.body)
  }
  if content.has("text") {
    return str(content.text)
  } 
  if content.has("children") {
    let substring = ""
    for child in content.children {
      substring += contentToString(child)
    }
    return substring
  } 
  if content == [ ] {
    return " "
  }
  panic("Unaccounted for content option.")
}
// Coloring
#let getColor(name) = {
  config.colors
}

// Figure Management
#let getFigureSignature(loc, headerDepth: 2, current: none) = {
    let secNumber = counter(heading).at(loc)
    // let currentSec = counter(heading).at(current)
    // let sameSec = false
    // if secNumber == currentSec { sameSec = true }
    while secNumber.len() < headerDepth { secNumber.push(0) }
    if secNumber.len() > headerDepth { 
      secNumber = secNumber.slice(0, headerDepth)
    }
    secNumber = numbering("1.", ..secNumber)
    let figNumber = counter("meta:attachments").at(loc)
    figNumber = figNumber.first() + 1
    figNumber = numbering("1", figNumber)
    return str(secNumber) + str(figNumber)
}

// Retrieval
#let getCurrentNumbering(location, level: 1) =  {
  let numbers = counter(heading).at(location)
  while numbers.len() < level {
    numbers.push(0)
  }
  if numbers.len() > level {
    numbers = numbers.slice(0, level)
  }
  return numbers
}
#let placeCurrentSection(level: 1) = {
  // TODO: Optional level same with the next function
  return locate(loc => {
    let headings = query(heading.where(level: level), loc)
    let current = headings.pop()
    // While the current page is behind the currently indexed section...
    while current.location().page() > loc.page() {
      current = headings.pop()
    }
    return contentToString(current.body)
})}
#let placeCurrentSectionNumber(level: 1, numbering: "1") = {
  return locate(location => {
    let number = counter(heading.where(level: level)).display(numbering)
    return number 
    // return getCurrentNumbering(location, level: level)
})}
#let placeSectionPages() = {
  return locate(loc => {
    return counter("sectionPage").at(loc).first()
})}
#let placeTotalSectionPages() = {
  return locate(loc => {
    let headings = query(heading.where(level: 1), loc)
    let previous
    let current = headings.pop()
    // While the current page is behind the currently indexed section...
    while current.location().page() > loc.page() {
      previous = current
      current = headings.pop()
    }
    // Handle the final section.
    if previous == none {
      let previous = query(<meta:MainEnd>, loc).last()
      return (previous.location().page() - current.location().page() + 1)
    }
    // Get the distance between this section and the next.
    return (previous.location().page() - current.location().page())
})}