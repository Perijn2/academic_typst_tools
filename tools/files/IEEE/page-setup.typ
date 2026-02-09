#import "page-cover.typ": IEEE-academic-frontpage, IEEE-test-report-frontpage
#import "page-utils.typ": *

#import "/files/tools/version-history.typ" as vh

#let IEEE-academic-journal(
  // Cover page parameters
  title: [Document Title],
  authors: "Author Name",

  degree: [Bachelor of Science],
  degree-goal: [
        A Thesis Submitted in Fulfillment of the Requirements \
        for the Degree of
      ],

  department: [Department Name],
  university: [University Name],
  supervisor: [Supervisor Name],

  date: datetime.today(),
  location: [City, Country],
 
  use-front-cover: true,
  logo: none,
  
  // Front matter
  extend-abstract: false,
  abstract: none,

  acronyms: none,

  footer-config: (
    short-title: [#title],
    version: "1",
    confidentiality: [Internal Use Only],
    author: none,
    affiliation: none, //[NHL Delft],
    font-size: 8.5pt,
  ),

  use-toc: false,
  
  // Bibliography
  references: none,
  reference-style: "ieee",
  
  // Body
  body
) = {
  // Document setup
  transl(data: yaml("/files/assets/langs.yaml"))
  
  set par(justify: true)
  set text(size: 10pt, overhang: true, hyphenate: true, costs: (hyphenation: 500%))

  if use-front-cover {
    IEEE-academic-frontpage(
      // Title of the document
      title: title,
    
      // Authors of the document
      authors: authors,
    
      // Academic degree (e.g. "Bachelor of Science")
      degree: degree,
      
      // Degree goal (e.g. "A thesis submitted in fulfillment ...")
      degree-goal: degree-goal,
          
      department: department,
      university: university,
      supervisor: supervisor,
      
      date: date,
      location: location,
      logo: logo,
    )
  }

  set page(footer: ieee-footer-meta(..footer-config))
  
  //set page(columns: 2)
  counter(page).update(1)

  if use-front-cover == false {
    place(
      top + center,
      scope: "parent",
      float: true,
      text(size: 2em, weight: "bold")[
        #title
      ],
    )
  }

  if extend-abstract == false{
    ieee-abstract(content: [#abstract])
  } else {
    extend-abstract-page(content: [#abstract])
  }

  if use-toc == true {
    ieee-toc()
  }
  
  v(3em, weak: true)

  show heading: it => {
    v(1em)
    if it.level == 1 {
      align(center)[
        #text(size: 12pt, weight: "medium")[#it]
      ]
    }
    else {
      text(size: 12pt, weight: "medium")[#it]
    }
    
    v(1em)
  }
  
  set heading(numbering: chapter-numbering)
  
  // Main body
  [
    #body
  ]

  v(5em)
  
  // Bibliography
  if references != none {
    bibliography(references, style: reference-style, full: true)
  }
}

#let IEEE-academic-test-repport(
  // Cover page parameters
  title: [Document Title],
  project-name: [Project],
  version: "1.0.0",
  
  authors: (:),
  reviewers: (:),
  approvers: (:),
  
  department: [Department Name],
  university: [University Name],

  date: datetime.today(),
  location: [City, Country],
 
  use-front-cover: false,
  logo: none,

  show-version-history: true,
  version-history: (:),
  
  // Front matter
  extend-abstract: false,
  abstract: none,

  acronyms: none,

  footer-config: (
    short-title: [#title],
    version: version,
    confidentiality: [Internal Use Only],
    author: none,
    affiliation: none,
    font-size: 8.5pt,
  ),

  use-toc: false,
  
  // Bibliography
  references: none,
  
  // Body
  body
) = {
  // Document setup
  transl(data: yaml("/files/assets/langs.yaml"))

  IEEE-test-report-frontpage(
    // Title of the document
    title: title,
  
    // Authors of the document
    authors: authors,
    reviewers: reviewers,
    approvers: approvers,
        
    department: department,
    university: university,
    
    date: date,
    location: location,
    logo: logo,
  )

  set page(footer: ieee-footer-meta(..footer-config))
  
  //set page(columns: 2)

  // Version History
  if show-version-history and version-history.len() > 0 {
    vh.version-history(
      title: "Project Version History",
      level: 1,
      ..version-history.flatten(),
    )
  }

  if extend-abstract == false{
    ieee-abstract(content: [#abstract])
  } else {
    extend-abstract-page(content: [#abstract])
  }
  
  v(3em, weak: true)

  if use-toc == true {
    ieee-toc()
  }

  if acronyms != none {
    ieee-acronyms(acronyms: acronyms)
  }

  show heading: it => {
    align(center)[
        #text(size: 16pt, weight: "medium")[#it]
      ]
    
    v(1em, weak: true)
  }
  
  set heading(numbering: chapter-numbering)
  
  // Main body
  body

  v(5em)
  
  // Bibliography
  if references != none {
    references
  }
}