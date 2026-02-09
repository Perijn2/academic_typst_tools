/*#import "/files/academic-tools.typ": *

#import "@preview/unify:0.7.1": num,qty,numrange,qtyrange

#set text(lang: "nl")

#show: IEEE-academic-test-repport.with(
  // Cover page parameters
  title: [Testplan capstan drive],
  project-name: [Embedded systems - Robothond],
  version: "1.0.0",
  
  authors: ("Ruben van der Veen"),
  reviewers: ("R, Moedt"),
  approvers: ("R, Moedt"),
  
  department: [Electrical engineering],
  university: [NHL Stenden],

  date: datetime.today(),
  location: [City, Country],
 
  logo: [#image("files/assets/NHL_logo.jpg", width: 100pt)],

  show-version-history: true,
  version-history: (
    version(
      committee: [kaas \ is \ lekker],
      description: [Initiële commit],
      date: "2025-12-15",
      level: 3,
    ),
  ),
  
  // Front matter
  extend-abstract: true,
  abstract: [test],

  acronyms: (
    "DUT": "Device under Test",
    "ADC": "Analog-to-Digital Converter",
    "I2C": "Inter-Integrated Circuit",
    "SPI": "Serial Peripheral Interface",
    "UART": "Universal Asynchronous Receiver-Transmitter",
    "MCU": "Microcontroller Unit",
    "GPIO": "General Purpose Input/Output",
  ),

  use-toc: true,

  footer-config: (
    short-title: [Testplan],
    version: "1.0.0",
    confidentiality: [Internal Use Only],
    author: none,
    affiliation: none,
    font-size: 8.5pt,
  ),
  
  // Bibliography
  references: none,
)

= test */

#import "@preview/unify:0.7.1": num,qty,numrange,qtyrange
#import "files/academic-tools.typ": *

#set text(lang: "nl")
#set text(font: "STIX Two Text")

#show: IEEE-academic-journal.with(
  // Cover page parameters
  title: [Power transmissie robot actuatoren analyse],
  authors: "Perijn Huijser",

  degree: [Bachelor of Electrical engineering],
  degree-goal: [
        Een onderzoek benodigd voor het realiseren van een accurate robot actuator
      ],

  department: [Bachelors student],
  university: [NHL Stenden, Hogeschool],
  supervisor: [R. Moedt\ C. Mari Spies],

  date: datetime.today(),
  location: [Leeuwarden, Nederland],
  
  use-front-cover: true,
  logo: [#image("files/assets/NHL_logo.jpg", width: 140pt)],
  
  // Front matter
  extend-abstract: true,
  abstract: [Dit onderzoek is uitgevoerd in het kader van het Embedded Systems Project 2025–2026 aan NHL Stenden Hogeschool te Leeuwarden. Het project heeft als doel een functioneel embedded apparaat te ontwikkelen dat ingezet kan worden tijdens toekomstige open dagen. In deze context richt het onderzoek zich op het ontwerpen en realiseren van een robothond als demonstratieplatform voor embedded technologieën.

  Om tot een technisch onderbouwd en betrouwbaar ontwerp te komen, is uitgebreide literatuurstudie noodzakelijk. Deze studie stelt het projectteam in staat om weloverwogen ontwerpkeuzes te maken op het gebied van mechanica, aandrijving, sensortechniek, elektrotechniek en systeemintegratie. Het onderzoek vormt daarmee de basis voor het ontwerptraject en draagt bij aan de realisatie van een robuust, functioneel en didactisch inzetbaar demonstratiemodel.],
  
  footer-config: (
    short-title: [Transmissie analyse],
    version: "1.0",
    confidentiality: [Internal Use Only],
    author: [],
    affiliation: [NHL Stenden],
    font-size: 8.5pt,
  ),
  
  // Bibliography
  references: "/zotero.bib",
  reference-style: "ieee",
)



#place-columns()[
  = Introductie
  Het ontwerpen van een functionele robothond vereist zorgvuldige en onderbouwde ontwerpkeuzes op zowel mechanisch als elektrotechnisch niveau. Een cruciale rol binnen dit ontwerp wordt vervuld door het actuatorsysteem, waarin de transmissie-architectuur bepalend is voor de prestaties, efficiëntie en betrouwbaarheid van het geheel.
  
  Dit document richt zich op het onderzoek en de onderbouwing van verschillende transmissieoplossingen die toegepast kunnen worden binnen de robothond. Om tot een weloverwogen ontwerpkeuze te komen, worden meerdere transmissieprincipes geanalyseerd en met elkaar vergeleken op basis van relevante technische criteria.
  
  = Ontwerp criteria <ontwerp-criteria>
  Tijdens het ontwerpen van een powertransmissiesysteem is het cruciaal om vastgestelde ontwerpcriteria te hanteren. Deze criteria waarborgen dat het systeem functioneert volgens de gestelde verwachtingen en ontwerpeisen. In dit hoofdstuk worden de belangrijkste ontwerpcriteria uiteengezet en wordt toegelicht welke invloed zij hebben op het totale systeem.

  == Backlash
  Binnen robotische systemen vormt het minimaliseren van backlash een fundamentele ontwerpprioriteit. Backlash wordt gedefinieerd als de ongewenste mechanische speling tussen samenwerkende tandwielen of transmissie-elementen en beïnvloedt zowel de positionele nauwkeurigheid als de dynamische prestaties van het systeem. De belangrijkste negatieve effecten zijn:
  
  - *Accumulatie van positionele fouten*: Speling kan zich over opeenvolgende bewegingen ophopen, waardoor onzekerheid in de werkelijke coördinaten ontstaat en de stabiliteit van de beweging wordt aangetast.
  - *Versnelde slijtage*: Herhaalde wisselingen in belasting en draairichting leiden tot verhoogde materiaalinteractie in de transmissie element overgang, wat de structurele levensduur van de transmissie vermindert.
  
  Gezien deze nadelige gevolgen dient backlashreductie beschouwd te worden als een *primaire ontwerpeis* voor het actuator- en transmissiesysteem. Naast backlash is het ook essentieel om efficiëntie van de overdacht mee te nemen, aangezien embedded devices gelimiteerde energie capaciteiten hebben.
  
  = Huidige transmissie-opties
  
  Diverse transmissie-architecturen zijn in staat om een aantal ontwerp criteria te behalen. Elk van deze opties brengt specifieke voordelen en beperkingen met zich mee, afhankelijk van de beoogde toepassing:
  
  + *Harmonische aandrijvingen*: Kenmerkend door een zeer lage backlash $approx qtyrange("2", "4", "arcminute", per: "/", delimiter: "\"to\"") $ @noauthor_comparison_2021, maar relatief kostbaar en beperkt in maximaal overdraagbare koppel.
  
  + *Planetaire gearbox*: Hoge mechanische efficiëntie $ approx qtyrange("75", "99", "percent", thousandsep: "'")$ @august_dynamics_1984 @bertoldi_efficiency_2021, lage backlash $approx qtyrange("1", "15", "arcminute", delimiter: "\"to\"")$ en een compact designs.
  
  + *Cycloidal reductoren*: Ondersteunen hoge reductieverhoudingen, lage backlash $approx qtyrange("5", "60", "arcsecond", per: "/", delimiter: "\"to\"") $ en zijn van nature niet-terugdraaibaar.
  
  + *Capstan drives*: Biedt extreem lage backlash $approx$ #zi.arcsecond(0) @mazumdar_synthetic_2017, hoge efficiëntie $ approx qtyrange("95", "96", "percent")$ @mazumdar_synthetic_2017 en simpele designs
  
  In de verdere analyse zullen deze transmissie-opties worden geëvalueerd aan de hand van kosten, efficiëntie, backlash prestaties en integratiecomplexiteit, met als doel een optimaal transmissieconcept te selecteren voor de beoogde robotische toepassing.

  = Architectuur Analyse 
  Om te bepalen welke transmissie architectuur het beste bij ons project past, gaan wij de verschillende opties analyseren. Hierbij ligt de focus op de benoemde criteria (zie @ontwerp-criteria).

]

