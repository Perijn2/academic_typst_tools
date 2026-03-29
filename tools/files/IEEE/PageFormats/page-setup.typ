#import "page-cover.typ": IEEE-academic-frontpage, IEEE-test-report-frontpage
#import "page-utils.typ": *

#import "../Styling/heading-style.typ": *

#import "/files/tools/version-history.typ" as vh

#import "@preview/meander:0.4.0"

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

  show-version-history: false,
  version-history: (:),

  footer-config: (
    short-title: [#title],
    version: "1",
    confidentiality: [Internal Use Only],
    author: none,
    affiliation: none, //[NHL Delft],
    font-size: 8.5pt,
  ),

  use-toc: false,

  figure-supplement: [Fig.],

  paper-size: "a4",
  
  // Bibliography
  references: none,
  reference-style: "ieee",
  
  // Body
  body
) = {
  // Document setup
  transl(data: yaml("/files/assets/langs.yaml"))
  
  set par(justify: true)
  set text(size: 10pt, font: "STIX Two Text", overhang: true, hyphenate: true, costs: (hyphenation: 500%))

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

  set columns(gutter: 12pt)
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    footer: ieee-footer-meta(..footer-config)
  )
  //set page(footer: ieee-footer-meta(..footer-config))
  
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

  if extend-abstract == true{
    extend-abstract-page(content: [#abstract])
  }

  if use-toc == true {
    ieee-toc()
  }

  // Tables & figures
  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top, separator: [\ ])
  show figure.where(kind: table): set text(size: 9pt)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  show figure.caption: set text(size: 9.5pt)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set align(center)

  // Adapt supplement in caption independently from supplement used for
  // references.
  set figure.caption(separator: [. ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [TABLE]
      else if fig.kind == image [Fig.]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    // Wrap figure captions in block to prevent the creation of paragraphs. In
    // particular, this means `par.first-line-indent` does not apply.
    // See https://github.com/typst/templates/pull/73#discussion_r2112947947.
    show figure.caption: it => block[#prefix~#numbers#it.separator#it.body]
    show figure.caption.where(kind: table): smallcaps
    fig
  }

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 1em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      // Other references as usual.
      it
    }
  }

  //show heading: ieee_heading

  // Configure headings.
  set heading(numbering: "1.A.1.a)")
  show heading: it => {
    // Find out the final number of the heading counter.
    let levels = counter(heading).get()
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(10pt, weight: 400)
    if it.level == 1 {
      // First-level headings are centered smallcaps.
      // We don't want to number the acknowledgment section.
      let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [Acknowledgments], [Acknowledgements])
      set align(center)
      set text(if is-ack { 10pt } else { 11pt })
      show: block.with(above: 15pt, below: 13.75pt, sticky: true)
      show: smallcaps
      if it.numbering != none and not is-ack {
        numbering("1.", deepest)
        h(7pt, weak: true)
      }
      it.body
    } else if it.level == 2 {
      // Second-level headings are run-ins.
      set text(style: "italic")
      
      show: block.with(spacing: 10pt, sticky: true)
      if it.numbering != none {
        v(8pt)
        numbering("A.", deepest)
        h(7pt, weak: true)
      }
      it.body

    } else [
      #set text(style: "italic")
      // Third level headings are run-ins too, but different.

      #h(1em * (it.level - 2))
      #if it.level == 3 {
        //h(.5em * it.level)
        numbering("1)", deepest)
        [ ]
      } else if it.level == 4 {
        //h(.5em * it.level)
        numbering("a)", deepest)
        [ ]
      }
      #(it.body):
    ]
  }

  if acronyms != none {
    ieee-acronyms(acronyms: acronyms)
  }

  // Version History
  if show-version-history and version-history.len() > 0 {
    vh.version-history(
      title: "Project Version History",
      level: 1,
      ..version-history.flatten(),
    )
  }
  
  pagebreak()

  //meander.reflow({
  //  import meander: *

  //  container()
  
  body

    
  //})
  
  // Main body
  //[
    
  //]

  v(5em)
  
  // Bibliography
  if references != none {
    references
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