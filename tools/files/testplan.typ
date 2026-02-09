// ============================================================
// TESTPLAN.TYP - Template voor testplannen
// ============================================================

#import "styling.typ": *
#import "cover-pages.typ": testplan-cover
#import "front-matter.typ": *

#import "/files/tools/version-history.typ" as vh

#let testplan(
  // Cover page parameters
  title: [Testplan],
  project-name: none,
  version: "1.0",
  date: datetime.today(),
  authors: (),
  reviewers: (),
  approver: none,
  organization: none,
  logo: none,
  
  // Version history
  version-history: (),
  
  // Document options
  show-toc: true,
  show-version-history: true,
  acronyms: (:),
  
  // Executive summary
  executive-summary: none,
  
  // Body content
  body
) = {
  transl(data: yaml("/files/assets/langs.yaml"))
  
  // Document setup
  setup-document(title, authors.join(", "))
  
  // Cover page
  testplan-cover(
    title: title,
    project-name: project-name,
    version: version,
    date: date,
    authors: authors,
    reviewers: reviewers,
    approver: approver,
    organization: organization,
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
// Heading configuration
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
  
  setup-figures()
  setup-paragraphs()
  setup-outline()
  
  // Version History
  if show-version-history and version-history.len() > 0 {
    vh.version-history(
      title: "Project Version History",
      level: 1,
      ..version-history.flatten(),
    )
  }
  
  // Executive Summary (optioneel)
  if executive-summary != none {
    make-executive-summary(executive-summary)
  }
  
  // Table of Contents
  if show-toc {
    make-toc()
  }
  
  // Acronyms
  if acronyms != (:) {
    make-acronyms(acronyms: acronyms)
  }
  
  // Main content heading numbering
  //set heading(numbering: "1.1")
  set heading(numbering: chapter-numbering)
  
  // Main body
  body

}

// ============================================================
// HELPER FUNCTIES VOOR TESTPLANNEN
// ============================================================

// Test case tabel
#let test-case-table(
  test-cases,
  caption: [Test Cases]
) = {
  figure(
    table(
      columns: (10%, 25%, 25%, 20%, 20%),
      stroke: 0.5pt,
      align: (center, left, left, left, center),
      table.header(
        [*ID*], [*Test Beschrijving*], [*Verwacht Resultaat*], [*Type*], [*Prioriteit*]
      ),
      ..test-cases.map(tc => (
        tc.id,
        tc.description,
        tc.expected,
        tc.type,
        tc.priority
      )).flatten()
    ),
    caption: caption,
    kind: table
  )
}

// Test scope tabel
#let test-scope-table(
  in-scope: (),
  out-of-scope: (),
) = {
  figure(
    table(
      columns: (50%, 50%),
      stroke: 0.5pt,
      align: (left, left),
      table.header(
        [*In Scope*], [*Out of Scope*]
      ),
      [
        #for item in in-scope [
          • #item \
        ]
      ],
      [
        #for item in out-of-scope [
          • #item \
        ]
      ]
    ),
    caption: [Test Scope],
    kind: table
  )
}

// Risk assessment tabel
#let risk-assessment-table(
  risks,
  caption: [Risico Analyse]
) = {
  figure(
    table(
      columns: (20%, 35%, 20%, 25%),
      stroke: 0.5pt,
      align: (left, left, center, left),
      table.header(
        [*Risico*], [*Beschrijving*], [*Impact*], [*Mitigatie*]
      ),
      ..risks.map(r => (
        r.risk,
        r.description,
        r.impact,
        r.mitigation
      )).flatten()
    ),
    caption: caption,
    kind: table
  )
}

// Test schedule tabel
#let test-schedule-table(
  schedule,
  caption: [Test Schema]
) = {
  figure(
    table(
      columns: (30%, 20%, 20%, 30%),
      stroke: 0.5pt,
      align: (left, center, center, left),
      table.header(
        [*Fase*], [*Start Datum*], [*Eind Datum*], [*Deliverables*]
      ),
      ..schedule.map(s => (
        s.phase,
        s.start-date,
        s.end-date,
        s.deliverables
      )).flatten()
    ),
    caption: caption,
    kind: table
  )
}

// Test environment specificatie
#let test-environment(
  hardware: none,
  software: none,
  tools: none,
  data: none
) = [
  == Test Omgeving
  
  #if hardware != none [
    *Hardware:*
    
    #hardware
  ]
  
  #if software != none [
    *Software:*
    
    #software
  ]
  
  #if tools != none [
    *Tools:*
    
    #tools
  ]
  
  #if data != none [
    *Test Data:*
    
    #data
  ]
]

// Entry/Exit criteria
#let criteria-section(
  entry: none,
  exit: none
) = context {
  let level = counter(heading).get().len()
  
  heading(
    level: level + 1,
    outlined: true,
    bookmarked: true,
  )[Entry en Exit Criteria]
  
    
  [
    #if entry != none [
      *Entry Criteria:*
      
      #for criterion in entry [
        - #criterion
      ]
    ]
    
    #v(1em)
    
    #if exit != none [
      *Exit Criteria:*
      
      #for criterion in exit [
        - #criterion
      ]
    ]
  ]
}
