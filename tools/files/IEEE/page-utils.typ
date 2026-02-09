#import "@preview/transl:0.1.1": transl, fluent, std
#import "@preview/acrostiche:0.7.0": *

#let place-content(
  alignment: none,
  content: [],
) = {
  place(
    alignment,
    scope: "parent",
    float: true,
    content
  )
}

#let place-columns(body) = [
  //#place-content(alignment: auto, content: body)
  #columns(2, gutter: 18pt)[
    #body
  ]
]

#let ieee-abstract(
  content: []
) = {
  context [
    #let abstract-title = transl("abstract", mode: str);
    
    #text(size: 12pt)[
      *#emph(abstract-title)* - *#content*
    ]
  ]
}

#let ieee-toc(
  indent: 2em,
) = {
  context [
      #let toc-title = transl("table of contents", mode: str);
      
      #place(
        top + center,
        scope: "parent",
        float: true,
        text(size: 2em, weight: "bold")[
          #toc-title
        ],
      )
    ]

  v(1em)

  outline(
    title: none,
    indent: indent
  )
  pagebreak()
}

#let ieee-acronyms(
  acronyms: (:),
  caption: [List of acronyms],
) = {
  context [
      #let toc-title = transl("acronyms", mode: str);
      
      #place(
        top + center,
        scope: "parent",
        float: true,
        text(size: 2em, weight: "bold")[
          #toc-title
        ],
      )
    ]
  
  v(1em)

  init-acronyms(
    acronyms
  )

  //print-index()

  // Or customize it:
  figure(
    print-index(
      //level: 2,
      //numbering: "1.",
      outlined: false,
      //sorted: "up",
      //used_only: true,
      title: "",
      delimiter: "",
      row-gutter: 6pt, 
      used-only: false, 
      column-ratio: 0.2,
      clickable:true
    ),
    caption: caption,
    kind: table
  )
  
  pagebreak()
}

// Advanced, customizable split footer suitable for IEEE-like docs.
#let ieee-footer-advanced(
  // Content slots
  leftc: none,      // e.g. short title
  centerc: none,    // default: page number
  rightc: none,     // e.g. version / author / label

  // Typography
  font-size: 9pt,
  font-color: rgb("#666666"),
  font-weight: "regular",
  font-family: none,   // e.g. "Latin Modern Roman" if you want

  // Layout
  padding-top: 6pt,
  padding-bottom: 10pt,
  column-ratio: (1fr, auto, 1fr),  // (left, center, right)
  gutter: 0pt,

  // Optional top rule
  show-rule: true,
  rule-color: rgb("#dddddd"),
  rule-thickness: 0.5pt,
  rule-length: 100%,

  // Page number helpers
  auto-center-page: true,   // if center == none, put page number automatically
  page-label: none,         // e.g. [Page], [p.]
) = {
  block(width: 100%)[
      // Base text styling
      #set text(
        size: font-size,
        fill: font-color,
        weight: font-weight,
      )

      // Optional rule above the footer
      #if show-rule [
        #line(length: rule-length, stroke: rule-thickness + rule-color)
        #v(padding-top)
      ] else [
        #v(padding-top)
      ]

      // Determine center content (auto page number if desired)
      #let center-content = if centerc != none {
        centerc
      } else if auto-center-page {
        context [
          #let current = counter(page).get().first()
          #let total = counter(page).final().first()
          
          #text(size: 11pt, fill: rgb("#666666"))[Pg #current #transl("of") #total] 
        ]
      } else {
        []
      }

      // 3-column layout with grid
      #grid(
        columns: column-ratio,
        gutter: gutter,
        // LEFT cell
        align: left,
        [#leftc],

        // CENTER cell
        [#center-content],

        // RIGHT cell
        align(right)[#rightc]
        
      )

      #v(padding-bottom)
    ]
  
}

#let ieee-footer-meta(
  short-title: none,
  version: none,
  confidentiality: none,    // [Internal Use Only], [Confidential], etc.
  author: none,
  affiliation: none,

  // Pass-through styling overrides (optional)
  font-size: 9pt,
  font-color: rgb("#666666"),
) = {
  // Build LEFT, CENTER, RIGHT pieces

  // Left: short title (if any)
  let left = if short-title != none {
    short-title
  } else {
    none
  }

  // Center: leave none, ieee-footer-advanced will auto-fill page number
  let center = none

  // Right: version / confidentiality / author (compact)
  let right = none

  if version != none or confidentiality != none or author != none {
    // Build a small inline sequence like: v1.2 • Internal Use Only • J. Doe (TU Delft)
    right = [
      #if version != none [v#version]
      #if version != none and (confidentiality != none or author != none) [ • ]
      #if confidentiality != none [#confidentiality]
      #if confidentiality != none and author != none [ • ]
      #if author != none [
        #author
        #if affiliation != none [ (#affiliation) ]
      ]
    ]
  }

  // Call the advanced footer
  ieee-footer-advanced(
    leftc: left,
    centerc: center,
    rightc: right,
    font-size: font-size,
    font-color: font-color,
    // Keep the rest of the defaults, but you can expose more if you want
  )
}


#let extend-abstract-page(
  content: []
) = {
  context [
    #let abstract-title = transl("abstract", mode: str);

    /*#place(
      top + center,
      scope: "parent",
      float: true,
      text(size: 2em, weight: "bold")[
        #abstract-title
      ],
    )*/
    #heading(level: 1, numbering: none,)[#abstract-title]
  ]
  v(1em)
  
  content
  pagebreak()
}

#let chapter-numbering = (..nums) => {
  let level = nums.pos().len()
  nums.pos().map(str).join(".")
}