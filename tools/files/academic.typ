// ============================================================
// ACADEMIC-FRONTPAGE.TYP - Gerefactored academic template
// ============================================================

#import "@preview/transl:0.1.1": transl, fluent, std

#import "styling.typ": *
#import "cover-pages.typ": academic-front-cover, academic-title-page
#import "front-matter.typ": *



#let page-footer(
  page-counter: none,
  page-symbol: none,
  page-text: [],
) = {
  context [
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
      //page-text,
      [
        #if page-counter != none [
         #text(size: 11pt, fill: rgb("#111111"))[#page-counter #current #transl("of") #total] 
        ]
      ]
    )
  ]
}

#let academic-frontpage(
  // Cover page parameters
  title: [Document Title],
  authors: "Author Name",
  
  degree: [Bachelor of Science],
  degree-goal: [A Thesis Submitted in Fulfillment of the Requirements \ 
      for the Degree of],
      
  department: [Department Name],
  university: [University Name],
  supervisor: [Supervisor Name],
  tutor: [Tutor Name],
  
  date: datetime.today(),
  degree-year: [Year],
  
  program-type: [Program Type],
  location: [City, Country],
  
  logo: none,
  
  // Front matter
  abstract: none,
  keywords: none,
  acknowledgments: none,
  acronyms: (:),
  
  // Options
  show-list-of-figures: true,
  show-list-of-tables: true,
  
  // Bibliography
  bibliography: none,
  
  // Body
  body
) = {
  // Document setup
  //setup-document(title, authors)
  transl(data: yaml("/files/assets/langs.yaml"))
  

  // Cover page
  academic-front-cover(
    title: title,
    authors: authors,
    degree: degree,
    degree-goal: degree-goal,
    department: department,
    university: university,
    supervisor: supervisor,

    date: date,
    
    location: location,
    logo: logo,
  )

  counter(page).update(1)
  set page(footer: page-footer(page-counter: [Pg]) )
  
  // Title page (back of cover)
  academic-title-page(
    title: title,
    authors: authors,
    degree: degree,
    degree-year: degree-year,
    program-type: program-type,
    department: department,
    university: university,
    location: location,
    supervisor: supervisor,
    tutor: tutor,
  )
  
  // Apply styling
  setup-headings()
  setup-figures()
  setup-paragraphs()
  setup-outline()
  
  // Abstract
  if abstract != none {
    make-abstract(abstract, keywords: keywords)
  }
  
  // Acknowledgments
  if acknowledgments != none {
    make-acknowledgments(acknowledgments)
  }
  
  // Table of Contents
  make-toc()
  
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
    make-acronyms(
      acronyms: acronyms, 
      caption: [Definition of Acronyms]
    )
  }
  
  // Main content setup
  set heading(numbering: chapter-numbering)
  
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
