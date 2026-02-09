#import "@preview/unify:0.7.1": num,qty,numrange,qtyrange
#import "/files/academic-tools.typ": *

#set text(lang: "nl")
#set text(font: "STIX Two Text")

#set math.equation(numbering: "(1)")

#show: IEEE-academic-journal.with(
  // Cover page parameters
  title: [Practicum Elektronica B\ Proef 2],
  authors: "Daan Smit, Perijn Huijser",

  degree: [Bachelor of Electrical engineering],
  degree-goal: [
        Ontwerp en testen van een versterkerschakeling in GES,\ simulatie en analyse in LTspice.
      ],

  department: [Bachelors student],
  university: [NHL Stenden, Hogeschool],
  supervisor: [H. Rouwhorst],

  date: datetime.today(),
  location: [Leeuwarden, Nederland],

  use-toc: true,
  
  use-front-cover: true,
  logo: [#image("files/assets/NHL_logo.jpg", width: 140pt)],
  
  // Front matter
  extend-abstract: true,
  abstract: [In dit practicum is een transistorversterkerschakeling in
  gemeenschappelijke-emitterconfiguratie (GES) ontworpen, doorgerekend,
  opgebouwd en geanalyseerd. Het doel van de proef was het realiseren van
  een wisselspanningsversterker voor kleine signalen die voldoet aan
  vooraf vastgestelde ontwerpeisen.
  
  Op basis van eenvoudige ontwerpregels is de versterkerschakeling berekend. Vervolgens zijn de benodigde weerstands- en condensatorwaarden afgerond en doorberekend voor de E12 reeks. De schakeling is daarna experimenteel opgebouwd en gekarakteriseerd aan de hand van zes meetstappen, waaronder de gelijkstroominstelling, de spanningsversterking, de maximale
  uitgangsamplitude, de lage kantelfrequentie en de in- en uitgangsimpedantie.
  
  Ter validatie is dezelfde schakeling gemodelleerd en geanalyseerd met
  behulp van LTspice. De resultaten uit de berekeningen, metingen en
  simulaties zijn onderling vergeleken. Hieruit blijkt dat de versterker
  in grote lijnen voldoet aan de gestelde ontwerpeisen. Eventuele
  afwijkingen tussen theorie, meting en simulatie worden verklaard aan de
  hand van componenttoleranties, modelaannames en praktische
  meetonzekerheden.],
  
  footer-config: (
    short-title: [Filters en Versterkers proef 2],
    version: "1.0",
    confidentiality: [Internal Use Only],
    author: [],
    affiliation: [NHL Stenden],
    font-size: 8.5pt,
  ),
  
  // Bibliography
  references: "/automatisch_meten.bib",
  reference-style: "ieee",
)

#place-columns()[
  = Introductie

  = Opdracht

  == Opdracht 1a

  === a)
  #image("digitale_multimeter.png")

  === b)
  #image("digital_lines.png")

  #image("digital_busses.png")

  === c)
  #image("image.png")

  === d)
  #image("oscilloscope.png")

  == Opdracht 1c

  === a)
  Het concept van het block diagram tool is om het grafische source code the scheiden van de user interface @noauthor_labview_nodate. De labview tool kan gebruikt worden om berekeningen en algoritmes uit te voeren op een grafische en logische manier. De block diagram tool biedt 

  
  
  = Appendix

  
]



