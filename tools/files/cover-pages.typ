// ============================================================
// COVER-PAGES.TYP - Herbruikbare cover page componenten
// ============================================================

#import "@preview/transl:0.1.1": transl, fluent, std

#let page-footer(
  page-counter: none,
  page-symbol: none,
  page-text: [],
) = {
  set page(footer: context [
    #let current = counter(page).get().first()
    #let total = counter(page).final().first()
    
    #table(
      columns: (1fr, auto),
      stroke: 0pt,
      inset: 0pt,
      align: (left, horizon + right),
      [
        #if page-symbol != none [
          #image(page-symbol, width: 50pt)
        ]
      ],
      page-text,
      [
        #if page-counter != none [
         #text(size: 11pt, fill: rgb("#111111"))[#page-counter #current #transl("of") #total] 
        ]
      ]
    )
  ])
}

#let date-section(
  date: datetime.today(),
) = {
  v(1fr)
  line(length: 70%, stroke: 1.5pt + rgb("#333333"))
  v(12pt, weak: true)
  text(size: 10pt, fill: gray)[
    #date.display("[day] [month repr:long] [year]")
  ]
  v(8pt, weak: true)
}

// Academische cover page
#let academic-front-cover(
  // Title of the document
  title: [Document Title],

  // Authors of the document
  authors: [Author],

  // Acedemic degree
  degree: [Bachelor of Science],
  
  // Acedemic degree goal
  degree-goal: [A Thesis Submitted in Fulfillment of the Requirements \ 
      for the Degree of],
      
  department: [Department Name],
  university: [University Name],
  supervisor: [Supervisor Name],
  
  date: datetime.today(),
  
  location: [City, Country],
  logo: none,
) = {
  
  // ============================================================
  // COVER PAGE
  // ============================================================
  set text(size: 14pt)
  align(center)[
    // Header section
    #text(size: 22pt, weight: "bold", fill: rgb("#1a1a1a"))[#university]
    #v(8pt, weak: true)
    
    #if logo != none [
      #image(logo, width: 160pt)
      #v(12pt, weak: true)
    ]
    
    // Divider line
    #line(length: 70%, stroke: 1.5pt + rgb("#333333"))
    #v(16pt, weak: true)

    // Title section
    #text(size: 19pt, weight: "bold", fill: rgb("#1a1a1a"))[#title]
    
    #v(10pt, weak: true)
    #text(size: 12pt)[
      #degree-goal
    ]
    #v(28pt, weak: true)
    
    #text(weight: "bold", size: 13pt)[#upper(transl("authors"))]
    #v(6pt, weak: true)
    #text(size: 12pt)[#authors]
    #v(16pt, weak: true)

    #v(38pt, weak: true)
    #text(weight: "bold", size: 13pt)[#upper(transl("department"))]
    #v(6pt, weak: true)
    #text(size: 12pt)[
      #department
      
      #university
    ]

    #v(38pt, weak: true)
    #text(size: 12pt)[
      #transl("supervised by"): #text(weight: "bold")[#supervisor]
    ]
    
    //#text(size: 11pt)[© #month #year]
    #v(1fr)
    #line(length: 70%, stroke: 1.5pt + rgb("#333333"))
    #v(12pt, weak: true)
    #text(size: 10pt, fill: gray)[
      #date.display("[day] [month repr:long] [year]")
    ]
  ]
  pagebreak()
}

// Title page (achterkant van cover)
#let academic-title-page(
  title: [Document Title],
  authors: [Author name],
  
  degree: [Bachelor of Science],
  degree-year: [Year],
  program-type: [Program Type],
  department: [Department Name],
  university: [University Name],
  
  location: [City, Country],
  supervisor: [Supervisor Name],
  tutor: [Tutor Name],
) = {
  set text(size: 12pt)
  
  // Header information
  grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    row-gutter: 1.5em,
    align: (left, right),
    [
      #program-type (#degree-year) \
      #department
    ],
    [
      #university \
      #location
    ],
  )
  
  v(4em)
  
  // Detailed information grid
  grid(
    columns: (0.4fr, 1fr),
    column-gutter: 1em,
    row-gutter: 2em,
    align: (left, left),
    
    [*#upper(transl("title")):*],
    [#title],
    
    [*#upper(transl("authors")):*],
    [
      #authors \
      #degree, #department \
      #university \
      #location
    ],
    
    [*#upper(transl("supervisor")):*],
    [#supervisor],

    [*#upper(transl("tutor")):*],
    [#tutor],
    
    [*#upper(transl("number of pages")):*],
    [
      #context {
        let total-pages = counter(page).final().first()
        total-pages
      }
    ]
  )
  pagebreak()
}

// Eenvoudige cover voor meetrapporten
#let measurement-cover(
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
) = {
  set page(margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm))
  set text(size: 11pt, font: "Calibri")
  
  align(center)[ 
    //----------------------------------------------------------------------
    // Header section
    //----------------------------------------------------------------------
    #text(size: 22pt, weight: "bold", fill: rgb("#1a1a1a"))[#university]
    #v(8pt, weak: true)
    
    #if logo != none [
      #image(logo, width: 160pt)
      #v(12pt, weak: true)
    ]
    
    //----------------------------------------------------------------------
    // Divider line
    //----------------------------------------------------------------------
    #line(length: 70%, stroke: 1.5pt + rgb("#333333"))
    #v(16pt, weak: true)
    
    //----------------------------------------------------------------------
    // Title section
    //----------------------------------------------------------------------
    #text(size: 19pt, weight: "bold", fill: rgb("#1a1a1a"))[#title]
    
    #if subtitle != none [
      #v(6pt, weak: true)
      #text(size: 13pt, fill: rgb("#111111"))[#subtitle]
      #v(12pt, weak: true)
    ] else [
      #v(12pt, weak: true)
    ]

    #v(28pt, weak: true)
    #text(weight: "bold", size: 13pt)[CURSUS]
    #v(8pt, weak: true)
    // Experiment and course info
    #if experiment-number != none or course != none [
        #if experiment-number != none [
          #text(weight: "bold", size: 12pt)[EXPERIMENT #experiment-number]
          #if course != none [ | #text(size: 12pt)[#course] ]
        ] else [
          #text(size: 12pt)[#course]
        ]
        
        #if course-code != none [
          #v(4pt, weak: true)
          #text(size: 11pt, fill: rgb("#111111"))[Code: #course-code]
        ]
       #v(28pt, weak: true)
    ]
    
    // Authors section
    #if authors.len() > 0 [
      #text(weight: "bold", size: 13pt)[AUTEURS]
      #v(6pt, weak: true)
      #text(size: 12pt)[
        #authors.join(", ")
      ]
      #v(28pt, weak: true)
    ]
    
    //----------------------------------------------------------------------
    // Instructor section
    //----------------------------------------------------------------------
    #if instructor != none [
      #text(weight: "bold", size: 13pt)[BEGELEIDER]
      #v(4pt, weak: true)
      #text(size: 12pt)[#instructor]
      #v(16pt, weak: true)
    ]
    
    //----------------------------------------------------------------------
    // Date section
    //----------------------------------------------------------------------
    #date-section()
  ]
  
  pagebreak()
}

// Eenvoudige cover voor testplannen
#let testplan-cover(
  title: [Testplan],
  project-name: none,
  version: "1.0",
  date: datetime.today(),
  authors: (),
  reviewers: (),
  approver: none,
  organization: none,
  logo: none,
) = {
  set text(size: 12pt)
  
  // Titel sectie
  align(center)[
    //----------------------------------------------------------------------
    // Header section
    //----------------------------------------------------------------------
    #text(size: 24pt, weight: "bold", fill: rgb("#1a1a1a"))[#organization]
    #v(8pt, weak: true)
    
    #if logo != none [
      #image(logo, width: 160pt)
      #v(12pt, weak: true)
    ]
    
    //----------------------------------------------------------------------
    // Divider line
    //----------------------------------------------------------------------
    #line(length: 70%, stroke: 1.5pt + rgb("#333333"))
    #v(16pt, weak: true)

    //----------------------------------------------------------------------
    // Title section
    //----------------------------------------------------------------------
    #text(size: 22pt, weight: "bold")[#title]
    
    #if project-name != none [
      #v(1em, weak: true)
      #text(size: 14pt)[#project-name]
      #v(28pt, weak: true)
    ]

    //----------------------------------------------------------------------
    // Authors section
    //----------------------------------------------------------------------
    #if authors.len() > 0 [
      #text(weight: "bold", size: 14pt)[Auteur(s)]
      #v(8pt, weak: true)
      #text(size: 12pt)[
        #authors.join(", ")
      ]
      #v(28pt, weak: true)
    ]

    //----------------------------------------------------------------------
    // Reviewers section
    //----------------------------------------------------------------------
    #if reviewers.len() > 0 [
      #text(weight: "bold", size: 14pt)[Reviewer(s)]
      #v(8pt, weak: true)
      #text(size: 12pt)[
        #reviewers.join(", ")
      ]
      #v(28pt, weak: true)
    ]

    //----------------------------------------------------------------------
    // Goedgekeurd section
    //----------------------------------------------------------------------
    #text(weight: "bold", size: 14pt)[Goedgekeurd door]
    #v(8pt, weak: true)
    
    #if approver != none {
      text(size: 12pt)[
        #approver
      ]
    } else {
      text(size: 12pt)[
        N.V.T
      ]
    }
    #v(28pt, weak: true)
    
    
    //----------------------------------------------------------------------
    // Version information
    //----------------------------------------------------------------------
    #if version != none [
      #text(size: 14pt, weight: "bold", fill: rgb("#1a1a1a"))[Document Versie]
      #v(8pt, weak: true)
      #text(size: 12pt)[Versie #version]
      #v(28pt, weak: true)
    ]

    //----------------------------------------------------------------------
    // Date section
    //----------------------------------------------------------------------
    #date-section(date: date)
  ]
  
  pagebreak()
}
