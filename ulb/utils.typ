#let normalize-items(value) = {
  if value == none {
    ()
  } else if type(value) == array {
    value
  } else {
    (value,)
  }
}

#let has-content(value) = {
  if value == none {
    false
  } else if type(value) == str {
    value != ""
  } else if type(value) == array {
    value.len() > 0
  } else {
    true
  }
}

#let placeCurrentSection(level: 1) = {
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

    if next-eligible and next-on-current-page {
      return numbering(next.numbering, ..counter(heading).at(next.location())) + [. ] + next.body
    }

    if last-eligible and not next-on-current-page {
      return numbering(last.numbering, ..counter(heading).at(last.location())) + [. ] + last.body
    }

    if next != none and next.has("body") and type(next.body) == content {
      return next.body
    }

    " "
  }
}

#let getSectionNumber(level: 1, location: none) = {
  if location == none {
    counter(heading.where(level: level)).get()
  } else {
    counter(heading.where(level: level)).at(location)
  }
}
