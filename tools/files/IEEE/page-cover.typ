#import "page-utils.typ": *

// Academic cover page
#let IEEE-academic-frontpage(
  // Title of the document
  title: [Document Title],

  // Authors of the document
  authors: [Author],

  // Academic degree (e.g. "Bachelor of Science")
  degree: [Bachelor of Science],
  
  // Degree goal (e.g. "A thesis submitted in fulfillment ...")
  degree-goal: [
    A Thesis Submitted in Fulfillment of the Requirements \
    for the Degree of
  ],
      
  department: [Department Name],
  university: [University Name],
  supervisor: [Supervisor Name],
  
  date: datetime.today(),
  location: [City, Country],
  logo: none,
) = {
  // Base text styling
  set text(size: 12pt, fill: rgb("#222222"))

  align(center)[
    // --------------------------------------------------------
    // Top: institution & logo
    // --------------------------------------------------------
    #text(
      size: 20pt,
      weight: "bold",
      fill: rgb("#111111"),
    )[#university]

    #v(4pt)
    #text(
      size: 11pt,
      fill: rgb("#666666"),
      tracking: 1.5pt,
    )[#department]

    #if logo != none [
      //#image(logo, width: 140pt)
      #logo
      #v(10pt)
    ]

    #v(8pt)

    // --------------------------------------------------------
    // Title block
    // --------------------------------------------------------
    #text(
      size: 22pt,
      weight: "bold",
      fill: rgb("#111111"),
    )[#title]

    #v(10pt)
    #line(length: 55%, stroke: 0.8pt + rgb("#444444"))
    #v(10pt)

    #text(size: 11pt, fill: rgb("#555555"))[
      #degree-goal
    ]
    #v(4pt)
    #text(size: 11pt, weight: "semibold")[
      #degree
    ]

    #v(30pt)

    // --------------------------------------------------------
    // Author & supervisor
    // --------------------------------------------------------
    #text(
      size: 11pt,
      tracking: 1.5pt,
      fill: rgb("#555555"),
    )[ #upper(transl("authors")) ]

    #v(4pt)
    #text(size: 12pt)[ #authors ]

    #v(18pt)

    #text(
      size: 11pt,
      tracking: 1.5pt,
      fill: rgb("#555555"),
    )[ #upper(transl("supervised by")) ]

    #v(4pt)
    #text(size: 12pt)[ #supervisor ]

    #v(1fr)

    // --------------------------------------------------------
    // Footer: date & location
    // --------------------------------------------------------
    #line(length: 55%, stroke: 0.8pt + rgb("#444444"))
    #v(1pt)
    #text(size: 10pt, fill: rgb("#777777"))[
      #location • #date.display("[day] [month repr:long] [year]")
    ]
  ]

  pagebreak()
}



// Academic cover page
#let IEEE-test-report-frontpage(
  // Title of the document
  title: [Document Title],

  // Authors of the document
  authors: (:),
  reviewers: (:),
  approvers: (:),
      
  department: [Department Name],
  university: [University Name],
  
  date: datetime.today(),
  location: [City, Country],
  logo: none,
  
) = {
  // Base text styling
  set text(size: 12pt, fill: rgb("#222222"))

  align(center)[
    // --------------------------------------------------------
    // Top: institution & logo
    // --------------------------------------------------------
    #text(
      size: 20pt,
      weight: "bold",
      fill: rgb("#111111"),
    )[#university]

    #v(4pt)
    #text(
      size: 11pt,
      fill: rgb("#666666"),
      tracking: 1.5pt,
    )[#department]

    #if logo != none [
      #logo
    ]

    #v(10pt, weak: true)
    // --------------------------------------------------------
    // Title block
    // --------------------------------------------------------
    #text(
      size: 22pt,
      weight: "bold",
      fill: rgb("#111111"),
    )[#title]

    
    #line(length: 55%, stroke: 0.8pt + rgb("#444444"))
    #v(1.5em, weak: true)  

    // --------------------------------------------------------
    // Author & supervisor
    // --------------------------------------------------------
    #text(
      size: 11pt,
      tracking: 1.5pt,
      fill: rgb("#555555"),
    )[ #upper(transl("authors")) ]

    #v(4pt)
    #text(size: 12pt)[ #authors ]

    #v(18pt)

    #text(
      size: 11pt,
      tracking: 1.5pt,
      fill: rgb("#555555"),
    )[ #upper(transl("reviewers")) ]

    #v(4pt)
    #text(size: 12pt)[ #reviewers ]

    #v(18pt)

    #text(
      size: 11pt,
      tracking: 1.5pt,
      fill: rgb("#555555"),
    )[ #upper(transl("approved by")) ]

    #v(4pt)
    #text(size: 12pt)[ #approvers ]

    #v(1fr)

    // --------------------------------------------------------
    // Footer: date & location
    // --------------------------------------------------------
    #line(length: 55%, stroke: 0.8pt + rgb("#dddddd"))
    #v(8pt)
    #text(size: 10pt, fill: rgb("#777777"))[
      #location • #date.display("[day] [month repr:long] [year]")
    ]
    #v(10pt)
  ]

  pagebreak()
}