// ============================================================
// STYLING.TYP - Gedeelde styling functies en configuraties
// ============================================================

// Basis document configuratie
#let setup-document(title, author) = {
  set document(title: title, author: author)
}

// Heading configuratie met Nederlandse "Hoofdstuk" nummering
#let setup-headings() = {
  set heading(numbering: none)
  
  show heading: it => {
    let sizes = (25pt, 18pt, 15pt, 12pt, 12pt, 12pt)
    let spacings = (2em, 1.6em, 1.3em, 1.1em, 1em, 1em)
    let level = it.level - 1
    let size = if level < sizes.len() { sizes.at(level) } else { 12pt }
    let spacing = if level < spacings.len() { spacings.at(level) } else { 1em }
    
    // Check if this is a content level 1 heading (Chapter X)
    let is-chapter = false
    let chapter-number = 0
    
    if it.level == 1 and it.numbering != none {
      let numbering-result = numbering(it.numbering, ..counter(heading).get())
      if type(numbering-result) == str and numbering-result.starts-with("Hoofdstuk") {
        is-chapter = true
        let chapter-str = numbering-result.slice(10)
        chapter-number = int(chapter-str)
      }
    }
    
    // Add pagebreak before Chapter 2 and onwards
    if is-chapter and chapter-number >= 2 {
      pagebreak()
    }
    
    v(spacing, weak: true)
    
    // Center alignment for chapter headings
    if it.level == 1 and is-chapter {
      align(center)[
        #text(size: size, weight: "bold")[#it]
      ]
    } else {
      text(size: size, weight: "bold")[#it]
    }
    
    v(spacing, weak: true)
  }
}

// Chapter numbering functie
#let chapter-numbering = (..nums) => {
  let level = nums.pos().len()
  if level == 1 {
    "Hoofdstuk " + str(nums.pos().at(0))
  } else if level == 2 {
    str(nums.pos().at(0)) + "." + str(nums.pos().at(1))
  } else if level == 3 {
    str(nums.pos().at(0)) + "." + str(nums.pos().at(1)) + "." + str(nums.pos().at(2))
  } else if level == 4 {
    "•"
  } else {
    nums.pos().map(str).join(".")
  }
}

// Figure en caption styling
#let setup-figures() = {
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => {
    text(size: 10pt, weight: "bold")[#it]
  }
  show figure.caption.where(kind: image): it => {
    text(size: 10pt, weight: "bold")[#it]
  }
}

// Paragraph styling voor academische documenten
#let setup-paragraphs(justify: true) = {
  set par(justify: justify, leading: 1em, spacing: 2.5em)
}

// Bibliography styling
#let setup-bibliography(style) = {
  if style == none {
    style = "ieee"
  }
  show std.bibliography: set text(12pt)
  show std.bibliography: set par(spacing: 1em, leading: 0.5em)
  set std.bibliography(title: [Referenties], style: style)
}

// Outline (TOC) styling
#let setup-outline() = {
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  show outline.entry.where(level: 2): it => {
    pad(left: 0em, it)
  }
  show outline.entry.where(level: 3): it => {
    pad(left: 1em, it)
  }
}
