// ============================================================
// FRONT-MATTER.TYP - Front matter componenten (abstract, TOC, etc.)
// ============================================================

#import "@preview/acrostiche:0.7.0": *
#import "@preview/transl:0.1.1": transl, fluent, std

#import "tools/version-history.typ": version-history

// Abstract sectie
#let make-abstract(
  content,
  keywords: none,
) = {
  context [
    #let abstact-title = transl("abstract", mode: str);
    #heading(level: 1, numbering: none)[ 
      #abstact-title.replace(regex("^\w"), m=>{
        upper(m.text)
      })
    ]
  ]
  
  content
  
  if keywords != none {
    v(1.5em)
    context [
      #let abstact-title = transl("keywords", mode: str);
      #text(weight: "bold")[ 
        #abstact-title.replace(regex("^\w"), m=>{
          upper(m.text)
        })
      ]
    ]
    text(weight: "bold")[#keywords]
  }
  
  pagebreak()
}

// Acknowledgments sectie
#let make-acknowledgments(
  content,
) = {
  context [
    #let abstact-title = transl("acknowledgments", mode: str);
    #heading(level: 1, numbering: none)[ 
      #abstact-title.replace(regex("^\w"), m=>{
        upper(m.text)
      })
    ]
  ]
  
  content
  
  pagebreak()
}

// Table of Contents
#let make-toc(
  indent: 2em
) = {
  outline(
    title: context [
      //#transl("table of contents", mode: str);
    ], 
    indent: indent
  )
  pagebreak()
}

// List of Figures
#let make-list-of-figures(
  indent: 2em
) = {
  //heading(level: 1, numbering: none)[#title]
  outline(
    title: context [
      #transl("list of figures", mode: str);
    ], 
    target: figure.where(kind: image), 
    indent: indent
  )
  pagebreak()
}

// List of Tables
#let make-list-of-tables(
  indent: 2em
) = {
  outline(
    title: context [
      #transl("list of tables", mode: str);
    ], 
    target: figure.where(kind: table), 
    indent: indent
  )
  pagebreak()
}

// Acronyms/Abbreviations lijst
#let make-acronyms(
  acronyms: (:),
  caption: [Definities van Afkortingen]
) = {
  /*heading(level: 1, numbering: none)[#title]
  
  v(1em)
  
  if acronyms != (:) {
    figure(
      table(
        columns: (25%, 75%),
        stroke: 0.5pt,
        align: (center, left),
        table.header(
          [*Afkorting*], [*Definitie*]
        ),
        ..acronyms.pairs()
          .sorted(key: pair => pair.at(0))
          .map(((key, value)) => (key, value))
          .flatten()
      ),
      caption: caption,
      kind: table
    )
  }*/
  
  context [
    #let abstact-title = "acronyms" //transl("acronyms", mode: str);
    #heading(level: 1, numbering: none)[ 
      #abstact-title.replace(regex("^\w"), m=>{
        upper(m.text)
      })
    ]
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

// Version history tabel (nuttig voor rapporten en testplannen)
#let make-version-history(
  versions: none,
) = {
  heading(level: 1, numbering: none)[#title]

  context [
    #let abstact-title = transl("version history", mode: str);
    #heading(level: 1, numbering: none)[ 
      #abstact-title.replace(regex("^\w"), m=>{
        upper(m.text)
      })
    ]
  ]
  
  if versions != none {
    version-history(
      title: none,
      level: 1,
      
      ..versions.flatten(),
    )
  }
  
  pagebreak()
}

// Executive Summary (voor rapporten)
#let make-executive-summary(
  content,
  title: [Executive Summary]
) = {
  heading(level: 1, numbering: none)[#title]
  
  content
  
  pagebreak()
}

// Preface (Voorwoord)
#let make-preface(
  content,
  title: [Voorwoord]
) = {
  heading(level: 1, numbering: none)[#title]
  
  content
  
  pagebreak()
}
