// ============================================================
// MEETRAPPORT.TYP - Template voor meetrapporten
// ============================================================

#import "styling.typ": *
#import "cover-pages.typ": measurement-cover
#import "front-matter.typ": *

#import "@preview/oxifmt:0.2.1": strfmt

#let meetrapport(
  // Cover page parameters
  title: [Meetrapport],
  subtitle: none,
  course: none,
  course-code: none,
  experiment-number: none,
  date: datetime.today(),
  authors: (),
  instructor: none,
  university: [NHL Stenden],
  logo: none,
  
  // Document options
  show-toc: true,
  show-list-of-figures: false,
  show-list-of-tables: false,
  acronyms: (:),
  
  // Abstract/samenvatting
  samenvatting: none,
  
  // Bibliography
  bibliography: none,
  
  // Body content
  body
) = {
  // Document setup
  setup-document(title, authors.join(", "))
  
  // Cover page
  measurement-cover(
    title: title,
    subtitle: subtitle,
    course: course,
    course-code: course-code,
    experiment-number: experiment-number,
    date: date,
    authors: authors,
    instructor: instructor,
    university: university,
    logo: logo,
  )
  
  // Page numbering setup
  set page(numbering: "1")
  counter(page).update(1)

  set page(footer: context [
    #let current = counter(page).get().first()
    #let total = counter(page).final().first()
    
    #table(
      columns: (1fr, auto),
      stroke: 0pt,
      inset: 0pt,
      align: (left, horizon + right),
      [
        #if logo != none [
          #image(logo, width: 50pt)
        ]
      ],
      [
        #text(size: 11pt, fill: rgb("#111111"))[Pg #current van #total]
      ]
    )
  ])
  
  // Apply styling
  setup-headings()
  setup-figures()
  setup-paragraphs()
  setup-outline()
  
  // Samenvatting (optioneel)
  if samenvatting != none {
    make-abstract(samenvatting, title: [Samenvatting])
  }
  
  // Table of Contents
  if show-toc {
    make-toc(title: [Inhoudsopgave])
  }
  
  // List of Figures
  if show-list-of-figures {
    make-list-of-figures()
  }
  
  // List of Tables
  if show-list-of-tables {
    make-list-of-tables()
  }
  
  // Acronyms
  if acronyms != (:) {
    make-acronyms(acronyms: acronyms)
  }
  
  // Main content heading numbering
  set heading(numbering: "1.1")
  
  // Bibliography styling
  if bibliography != none {
    setup-bibliography()
  }
  
  // Main body
  body
  
  // Bibliography
  if bibliography != none {
    pagebreak()
    bibliography
  }
}

// ============================================================
// HELPER FUNCTIES VOOR MEETRAPPORTEN
// ============================================================

// Meetgegevens tabel
#let measurement-table(
  data,
  caption: [Meetgegevens],
  columns: auto,
) = {
  figure(
    table(
      columns: columns,
      stroke: 0.5pt,
      align: center,
      ..data.flatten()
    ),
    caption: caption,
    kind: table
  )
}

// Resultaten sectie met formule en berekening
#let result-section(
  title,
  formula,
  calculation,
  result,
  unit: none
) = [
  === #title
  
  *Formule:*
  
  #formula
  
  *Berekening:*
  
  #calculation
  
  *Resultaat:*
  
  #result #if unit != none [ #unit ]
]

// Onzekerheidsanalyse helper
#let uncertainty-analysis(
  value,
  absolute-uncertainty,
  relative-uncertainty,
  unit: none
) = {
  let rel-percent = relative-uncertainty * 100
  
  [
    *Meetwaarde:* #value #if unit != none [#unit]
    
    *Absolute onzekerheid:* ± #absolute-uncertainty #if unit != none [#unit]
    
    *Relatieve onzekerheid:* ± #strfmt("{:.2}", float(rel-percent))
  ]
}
