// IEEE-like heading styling for Typst
// Usage:
//   #import "ieee-headings.typ": *
//   // or paste into your main .typ file
//   #show heading: ieee_heading

// ------------------------------------------------------------
// IEEE heading styling for Typst
// Usage:  #show heading: ieee_heading
// ------------------------------------------------------------


// IEEE headings for Typst (supports heading level 0,1,2 -> IEEE 1,2,3)
// Usage:  #show heading: ieee_heading

// Zet eventuele template-numbering uit, anders krijg je "0." e.d.
#set heading(numbering: none)

// Counters (counter values are arrays, e.g. (n,))
#let ieee_sec    = counter("ieee-sec")
#let ieee_sub    = counter("ieee-sub")
#let ieee_subsub = counter("ieee-subsub")

#let inc(c)   = c.update(v => (v.at(0) + 1,))
#let reset(c) = c.update(_ => (0,))
#let get1(c)  = c.get().at(0)

// Map jullie heading-levels naar IEEE-levels
// Bij jullie is het "hoofdstuk" blijkbaar level 0 (vandaar "0.")
#let ieee_level(l) = if l == 0 { 1 } else { l + 1 }
// - Typst level 0 -> IEEE 1
// - Typst level 1 -> IEEE 2
// - Typst level 2 -> IEEE 3

#let ieee_heading(it) = {
  let lvl = ieee_level(it.level)

  if lvl == 1 {
    inc(ieee_sec)
    reset(ieee_sub)
    reset(ieee_subsub)

    let num = numbering("I", get1(ieee_sec))

    block(above: 1.2em, below: 0.6em)[
      align(center)[
        text(weight: "bold", smallcaps: true)[
          #num. #it.body
        ]
      ]
    ]

  } else if lvl == 2 {
    inc(ieee_sub)
    reset(ieee_subsub)

    let num = numbering("A", get1(ieee_sub))

    block(above: 0.9em, below: 0.35em)[
      #text(style: "italic", weight: "bold")[
        #num. #it.body
      ]
    ]

  } else if lvl == 3 {
    inc(ieee_subsub)
    let num = get1(ieee_subsub)

    // IEEE level-3: indented, italic, and text starts on same line
    block(above: 0.7em, below: 0.2em, inset: (left: 1.2em))[
      text(style: "italic", weight: "bold")[
        #num) #it.body
      ]
    ]

  } else {
    it
  }
}


/*
#let ieee_heading(it) = {
  // it is the heading element
  // Common fields: it.level, it.body, it.numbering, it.supplement, etc.

  
  // IEEE-ish sizing by level (journal-like)
  let size
  
  if it.level == 1 { 
    size = 11pt 
  } else if it.level == 2 {
    
  }

  // Spacing: tight, like IEEE
  
  // Numbering style: 1, A, etc. (default is usually fine, but we force typical 1., 1.1., 1.1.1.)
  // If you already set a global heading numbering, this respects it.
  

  // Render
  block(
    above: above,
    below: below,
  )[
    // IEEE headings are typically bold; level-1 often all caps in some venues, but not always.
    // We keep normal case (safer) and bold.
    #strong[
      // Number + a small gap + title
      #if it.numbering != none { [#num\u{00A0}] } else { [] }
      #text(size: size, it.body)
    ]
  ]
}