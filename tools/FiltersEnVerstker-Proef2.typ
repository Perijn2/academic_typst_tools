#import "@preview/unify:0.7.1": num,qty,numrange,qtyrange
#import "files/academic-tools.typ": *

#import "@preview/meander:0.4.0": *

#set text(lang: "nl")

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

  acronyms: (
    "NI": "National Instruments",
    "D.M.V." : "door middel van",
  ),
  
  use-front-cover: true,
  logo: [#image("files/assets/NHL_logo.jpg", width: 140pt)],
  
  // Front matter
  extend-abstract: false,
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
  references: none,
  reference-style: "ieee",
)

  = Modelberekeningen en simulaties
  Het doel van deze proef is het ontwerpen van een transistorversterkerschakeling in GES
  (Gemeenschappelijke Emitter Schakeling). Deze schakeling fungeert als een
  wisselspanningsversterker voor kleine signalen. Aan de hand van metingen wordt onderzocht
  of de versterker voldoet aan de gestelde ontwerpeisen. Vervolgens wordt dezelfde
  versterkerschakeling geanalyseerd met behulp van het simulatie- en analyseprogramma LTspice.
  
  In dit hoofdstuk worden de benodigde componentwaarden berekend op basis van de opgegeven
  ontwerpeisen. Deze eisen luiden als volgt:
  
  - De spanningsversterking moet voldoen aan: $A_v = -15 plus.minus 1$
  - De uitgangsspanning moet $V_o = 4 V_"tt"$ kunnen bedragen over een belasting van
    $R_L = #kohm(10)$ bij een voedingsspanning van $V_"cc" = #zi.volt(12)$
  - De ingangsimpedantie $Z_"in"$ moet minimaal #kohm(25) bedragen
  - De in- en uitgangscondensatoren moeten zodanig worden gekozen dat frequenties vanaf
    #zi.hertz(15) (#zi.decibel(-3)) worden doorgelaten
  - Alle weerstandwaarden moeten worden gekozen uit de E12-reeks
  
  == DC-biasinstelling
  Als eerste stap is de gelijkstroominstelling (DC-bias) van de versterker bepaald.
  Voor een symmetrische uitsturing wordt de collectorspanning gekozen als:
  
  $ V_C = V_"CC" / 2 $
  
  Met $V_"CC" = #zi.volt(12)$ volgt:
  
  $ V_C = #zi.volt(6) $
  
  De ruststroom is gekozen als:
  
  $ I_C = #zi.mA(1) $
  
  Met deze waarden kan de collectorweerstand worden berekend met:
  
  $ R_C = (V_"CC" - V_C) / I_C $
  
  Dit resulteert in:
  
  $ R_C = #kohm(6) $

  En dus de E12 waarde voor $R_C$ is #kohm(5.6)
  
  Vervolgens zijn de basisweerstanden $R_"B1"$ en $R_"B2"$ bepaald volgens de gegeven
  ontwerpregels. Deze worden berekend met:
  
  $ R_"B1" = beta dot (0.8 V_"CC" - 0.6) / (11 I_C) $
  
  $ R_"B2" = beta dot (0.2 V_"CC" + 0.6) / (10 I_C) $
  
  Hieruit volgen de waarden:
  
  $ R_"B1" = #kohm(163) quad and quad R_"B2" = #kohm(60) $

  En dus de E12 waarde voor $ R_"B1" = #kohm(220) quad and quad R_"B2" = #kohm(83) $
  
  Met deze weerstanden kan de basisspanning worden berekend:
  
  $ V_B = V_"CC" dot (R_"B2" / (R_"B1" + R_"B2")) $
  
  Dit resulteert in:
  
  $ V_B = #zi.volt(3.26) $
  
  De emitters­panning volgt uit:
  
  $ V_E = V_B - #zi.volt(0.7) $
  
  waardoor geldt:
  
  $ V_E = #zi.volt(2.56) $
  
  === AC-versterking
  De spanningsversterking in het middenfrequentgebied kan benaderd worden met:

  $ A_v approx - ((g_m R_L^*) / (1 + g_m R_"E1")) $ <formule-A_v>
  
  waarbij de effectieve collectorbelasting wordt gegeven door:
  
  $ R_L^* = (R_C R_L) / (R_C + R_L) $

  dit resulteert in:

  $ R_L^* = #kohm(3.59) $

  Om vervolgens $R_"E1"$ te berekenen wordt @formule-A_v omgebouwd, hieruit volgt:

  $ R_"E1" = (R_L^*) / (abs(A_v)) - (1 / g_m) $

  hieruit volgt:

  $ R_"E1" = #zi.ohm(214) $

  En dus de E12 waarde voor $R_"E1"$ is #zi.ohm(220)

  om $R_"E2"$ te bepalen wordt de volgende formule gebruikt:

  $ R_"E1" + R_"E2" = (V_"CC") / (5 I_C) $

  hieruit leidt dat:

  $ R_"E2" = (V_"CC") / (5 I_C) - R_"E1" $

  dit resulteert in:

  $ R_"E2" = #kohm(2.19) $

  En dus de E12 waarde voor $R_"E2"$ is #kohm(2.2)

  == Ingangsimpedantie validatie
  Voor het valideren voor de ingangsimpedantie $Z_"in"$ wordt er gebruik gemaakt van:

  $ Z_"in" = R_"B1" parallel R_"B2" parallel (r_pi dot (1 + g_m R_"E1")) $

  waarbij $r_pi$ is:

  $ r_pi = beta / g_m = #kohm(5) $

  hieruit volgt:

  $ Z_"in" = R_"in" = #kohm(26.6) $

  == Koppel condensatoren

  Voor de ontkoppel condensatoren worden de volgende formules gebruikt:

  $ C_"in" = (1) / (2 pi f_L R_"in") $

  $ C_"uit" = (1) / (2 pi f_L dot (R_C + R_L)) $

  wederom volgt hieruit:

  $ C_"in" = #zi.µF(1.1) quad and quad C_"uit" = #zi.nF(618) $

  En dus de E12 waarde voor $ C_"in" = #zi.µF(1) quad and quad C_"uit" = #zi.nF(680) $
  
  = Experimentele opstelling

  == Gebruikte apparatuur
  - 1 x Dual power supply E 018 - 0.6D
  - 1 x Tektronix AFG31000 Waveform generator
  - 1 x Tektronix MSO24
  - 2 x Testec TT-LF 312 passive probe 150MHz 600Vp

  == Gebruikte schakeling

  
  #image("opstelling_schakeling.png")
  
  = Meetresultaten

  == Meting 1: Gelijkstroominstelling van de schakeling
  Het doel van deze meting is om de gelijkspanning $V_C$ en $V_"CC"$ te meten.
  
  *Werkwijze:*
  - Meet de voedingsspanning $V_"CC"$ met oscilloscoop
  - Meet de gelijkspanning $V_C$ op de collector met oscilloscoop
  - Neem screenshot op in logboek
  - Zet beide waarden in tabel hieronder
  
  *Meetresultaten:*
  
  #figure(
    tablex.tablex(
      columns: 3,
      align: center + horizon,
      auto-vlines: true,
      
      [*Parameter*], [*Waarde*], [*Eenheid*],
      [$V_"CC"$], [$ #num(sigfig.round(11.78, 3))$], [#zi.volt()],
      [$V_C$], [$ #num(sigfig.round(6.333, 3))$], [#zi.volt()],
      [$R_C$], [$ #num(sigfig.round(5.6, 3))$], [#kohm()], //5.549
      [$I_C$ (berekend)], [$ #num(sigfig.round((11.78 - 6.333) / 5.6, 3))$], [#zi.mA()],
    ),
    caption: [Meting 1: Gelijkstroominstelling],
    kind: table,
  ) <table:m1>

  #place(
    auto,
    scope: "parent",
    float: true,
    clearance: 3em,
  )[
    #figure(
      image("Meting1.PNG"),
      caption: [Meting 1: Gelijkstroominstelling],
      kind: image,
    ) <image:m1>
    #align(center)[
    #grid(
      columns: (auto, auto),
      gutter: 8pt,
      align: left,
      [#box(fill: yellow, width: 1.2em, height: 0.8em, radius: 2pt) *CH1:*],
      [$U_"cc"$ [5V/div]],
      
      [#box(fill: rgb("#00FFFF"), width: 1.2em, height: 0.8em, radius: 2pt) *CH2:*],
      [$U_c$ [5V/div]], 
      
      [*Tijdbasis:*], [#zi.µs(200)/div],
    )
  ]
  ]

  == Meting 2: Wisselstroomversterking bij 1000 Hz
  Bij meting 2 wordt er gekeken hoe de schakeling reageert op een wisselspanning signaal van #zi.kHz(1). Hierbij wordt er gekeken naar de ingangsspanning ($v_s$) en de uitgangsspanning ($v_o$)
  
  *Werkwijze:*
  - Stel ingangsspanning in op 1000 Hz, 150 mVtt
  - Meet $v_s$ (ingansspanning) nauwkeurig met oscilloscoop
  - Meet $v_o$ (uitgangsspanning) nauwkeurig met oscilloscoop
  - Neem screenshot op
  - Bereken versterking
  
  *Meetresultaten:*
  
 #figure(
    tablex.tablex(
      columns: (auto, 5em, 5em),
      align: center + horizon,
      auto-vlines: true,
      
      [*Parameter*], [*Waarde*], [*Eenheid*],
      [Frequentie], [1000], [Hz],
      [$v_s$ (gemeten)], [$ #num(sigfig.round(149.684, 3))$ ], [mVtt],
      [$v_o$ (gemeten)], [$ #num(sigfig.round(2.220, 3))$ ], [Vtt],
      [$A_V$ (berekend)], [$ #num(sigfig.round((2.220 / 149.684e-3), 3))$ ], [-],
      [$A_V$ (dB)], [$#sigfig.round(20 * calc.log((2.220 / 149.684e-3), base: 10), 3)$  ], [dB],
    ),
    caption: [Meting 2: AC versterking bij 1000 Hz],
    kind: table,
  ) <table:m2>

 
  #figure(
      image("Meting2_2.PNG"),
      caption: [Meting 1: Gelijkstroominstelling],
      kind: image,
    ) <image:m1>
    #align(center)[
  #grid(
    columns: (auto, auto),
    gutter: 8pt,
    align: left,
    [#box(fill: yellow, width: 1.2em, height: 0.8em, radius: 2pt) *CH1:*],
    [$U_s$ [50 mV/div]],
    
    [#box(fill: rgb("#00FFFF"), width: 1.2em, height: 0.8em, radius: 2pt) *CH2:*],
    [$U_o$ [500 mV/div]], 
    
    [*Tijdbasis:*], [200 µs/div],
  )


  
  == Meting 3: Maximale uitgangsamplitude
  Sluit oscilloscoop aan op $V_C$ (collector). Verhoog ingangsspanning tot afplatting optreedt.

  *Werkwijze:*
  - Stel ingang in op 1000 Hz
  - Verhoog ingangsspanning langzaam
  - Observeer $V_C$ op oscilloscoop
  - Stop wanneer afplatting zichtbaar is
  - Lees top-top waarde af
  - Neem screenshot op
  
  *Meetresultaten:*
  
  #figure(
    tablex.tablex(
      columns: 3,
      align: center + horizon,
      auto-vlines: true,
      
      [*Parameter*], [*Waarde*], [*Eenheid*],
      [$v_s$ (bij afplatting)], [$ #num(sigfig.round(500, 3))$ ], [mVtt],
      [$V_C$ (top-top)], [$ #num(sigfig.round(6.640, 3))$ ], [Vtt],
      [Opmerking], [#h(3em) ], [-],
    ),
    caption: [Meting 3: Maximale uitgangsamplitude],
    
    kind: table,
  ) <table:m3>
  
  #let unit-header(var, unit-str) = {
    math.equation(numbering: none, [$#var$ [$#unit-str$]])
  }

#v(1em)

== Meting 4: Frequentiekarakteristiek - Laag afvalpunt

Meet $v_s$ en $v_o$ bij verschillende frequenties. Bepaal #zi.decibel(-3) afvalpunt t.o.v. #zi.hertz(1000).

*Ingangsspanning:* 150 $"mV"_"tt"$ (constant houden)

*Formules:*

Spanningsversterking (lineair):
$ A_V = frac(v_o, v_s) $ <fom:Av_lin>

Spanningsversterking (dB):
$ A_V ("dB") = 20 log_(10) (frac(v_o, v_s)) $ <fom:Av_dB>

Afvalpunt (-3 dB):
$ f_(-3"dB") = f_(1"kHz") - 3 " dB" $ <fom:cutoff>

*Werkwijze:*
- Houd $v_s$ constant op 150 $"mV"_"tt"$
- Meet $v_o$ bij elke frequentie in tabel
- Bereken $A_V$ (lineair en dB)
- Bepaal referentiewaarde bij 1000 Hz
- Vind frequentie waar versterking 3dB lager is

*Meetgegevens:*

// Data array - VULT JE HIER IN
#let data_frequency = (
  (1, 149.684, 0.200),
  (2, 149.684, 0.240),
  (5, 149.684, 0.520),
  (10, 149.684, 0.940),
  (20, 149.684, 1.480),
  (50, 149.684, 2.040),
  (100, 149.684, 2.160),
  (200, 149.684, 2.240),
  (500, 149.684, 2.240),
  (1000, 149.684, 2.240),  // Referentie: vs = 150 mVtt
  (2000, 149.684, 2.240),
  (5000, 149.684, 2.240),
  (10000, 149.684, 2.240),
  (20000, 149.684, 2.240),
  (50000, 149.684, 2.240),
  (100000, 149.684, 2.200),
)

#figure(
  tablex.tablex(
    columns: 5,
    align: center + horizon,
    auto-vlines: true,
    repeat-header: true,
  
    /* #v(3em) header #v(3em) */
    tablex.rowspanx(2)[*Frequentie*], tablex.colspanx(2)[*Gemeten*], (), tablex.colspanx(2)[*Berekend*],
    (),                 [#unit-header($v_s$, $"mV"_"tt"$)], [#unit-header($v_o$, $"V"_"tt"$)], [#unit-header($A_V$, $"-"$)], [#unit-header($A_V$, $"dB"$)],
    /* #v(3em)#v(3em)#v(3em)#v(3em)-- */
  
    ..data_frequency.map(row => {
        let (freq, vs, vo) = row
        let av_linear = if vs > 0 { vo*1e3 / vs } else { 0 }
        let av_db = if av_linear > 0 { 20 * calc.log(av_linear, base: 10) } else { 0 }
        (
          [#zi.Hz(freq)],
          [#num(sigfig.round(vs, 3))],
          [#num(sigfig.round(vo, 3))],
          [#num(sigfig.round(av_linear, 3))],
          [#num(sigfig.round(av_db, 3))]
        )
      }).flatten()
  ),
  caption: [Meting 4: Frequentiekarakteristiek],
  kind: table,
) <table:m4>

#let (freqs_open, magnitudes_open) = (
  data_frequency.map(row => {
    let (freq, Vin, Vo) = row
    freq
  }),
  data_frequency.map(row => {
    let (freq, Vin, Vo) = row
    20 * calc.log(Vo*1e3 / Vin, base: 10)
  })
)


#figure(
  lq.diagram(
    width: 7cm, 
    height: 5cm,
    title: [AC versterking BC547],
    
    xlim: (1, 100000),
    ylim: (0, 30),
    
    xlabel: $"Frequentie [Hz]"$, 
    ylabel: $"Versterking [dB]"$,
    xscale: "log",
    
    grid: (stroke: black, stroke-sub: 0.25pt),
    lq.plot(freqs_open, magnitudes_open, stroke: 2pt,mark-size: 12pt),

    lq.line(
      stroke: (paint: red, dash: "dashed", thickness: 2pt),
      (20, 20), (20, -7)
    ),

    lq.line(
      stroke: (paint: red, dash: "dashed", thickness: 2pt),
      (1, 20), (20, 20)
    ),

    //lq.place(44.8, 18, align: left, pad(.7em)[$"-3dB"$]),

    lq.place(
      17, -1.2,
      align: left,
      
      [$"2" dot 10^1$]
    )
  ),
  caption: [$"Versterking" A_("v") "vs Frequentie Hz"$],
) <fig:bode_v>


#v(1em)

*Resultaten:*
#figure(
  tablex.tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: true,
    
    [*Parameter*], [*Waarde*], [*Eenheid*],
    [$A_V$ @ 1000 Hz], [23.5 ], [dB],
    [$A_V$ @ 1000 Hz -3 dB], [20 ], [dB],
    [$f_"L"$ (-3 dB afvalpunt)], [20 ], [Hz],
  ),
  caption: [Resultaten Meting 4],
  kind: table,
) <table:m4_result>

== Meting 5: Ingangsimpedantie

Bepaal ingangsimpedantie via twee metingen met en zonder serieweerstand.

*Formules:*

Zonder serieweerstand:
$ v_("o1") = A_V dot v_s $ <fom:Rin1>

Met serieweerstand:
$ v_("o2") = frac(R_"in", R_"in" + R_s) dot A_V dot v_s $ <fom:Rin2>

Ingangsimpedantie:
$ R_"in" = R_s dot (frac(v_("o1"), v_("o2")) - 1) $ <fom:Rin>

*Werkwijze:*
- Ingang: #zi.Hz(1000), 150 $"mV"_"tt"$ (zonder serieweerstand)
- Meet $v_o arrow.r$ zet neer als $v_("o1")$
- Voeg serieweerstand $R_s$ in
- Meet $v_o$ opnieuw → zet neer als $v_("o2")$
- Bereken $R_"in"$ met formule
- Neem screenshots van beide situaties

*Meetresultaten:*

#figure(
  tablex.tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: true,
    
    [*Parameter*], [*Waarde*], [*Eenheid*],
    [Ingang (frequentie)], [1000], [Hz],
    [Ingang (spanning)], [150], [mVtt],
    [$v_("o1")$ (zonder Rs)], [#num(sigfig.round(2.200, 3)) ], [Vtt], //26.90k
    [$R_s$ (serieweerstand)], [#num(sigfig.round(25, 3)) ], [kΩ],
    [$v_("o2")$ (met Rs)], [#num(sigfig.round(1.220, 3)) ], [Vtt],
    [$R_"in"$ (berekend)], [#num(sigfig.round(25e3 / ((2.200 / 1.220) - 1)/1e3, 3)) ], [kΩ],
  ),
  caption: [Meting 5: Ingangsimpedantie],
  kind: table,
) <table:m5>



#v(3em)


== Meting 6: Uitgangsimpedantie (indirecte bepaling)

Bepaal uitgangsimpedantie via twee metingen met en zonder belastingsweerstand.

*Formule:*

Met belasting $R_L$:
$ v_("o1") = A_V dot v_s $ <fom:Rout1>

Zonder belasting:
$ v_("o2") = A_V dot v_s $ <fom:Rout2>

Uitgangsimpedantie:
$ R_"out" = R_L dot (frac(v_("o2"), v_("o1")) - 1) $ <fom:Rout>

*Werkwijze:*
- Ingang: 1000 Hz, 150 mVtt (met $R_L$ aangesloten)
- Meet $v_o$ → zet neer als $v_("o1")$
- Verwijder $R_L$ 
- Meet $v_o$ opnieuw → zet neer als $v_("o2")$
- Bereken $R_"out"$ met formule
- Neem screenshots van beide situaties

*Meetresultaten:*

#figure(
  tablex.tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: true,
    
    [*Parameter*], [*Waarde*], [*Eenheid*],
    [Ingang (frequentie)], [1000], [$H_z$],
    [Ingang (spanning)], [150], [$"mV"_"tt"$],
    [$R_L$ (belasting)], [#num(sigfig.round(10, 3)) ], [k$Omega$],
    [$v_("o1")$ (met $R_L$)], [#num(sigfig.round(2.240, 3)) ], [$V_"tt"$],
    [$v_("o2")$ (zonder $R_L$)], [#num(sigfig.round(3.440, 3)) ], [$V_"tt"$],
    [$R_"out"$ (berekend)], [#num(sigfig.round(10 * ((3.440 / 2.240) - 1), 3)) ], [k$Omega$],
  ),
  caption: [Meting 6: Uitgangsimpedantie],
  kind: table,
) <table:m6>

*Screenshots:*
- Situatie 1 (met RL):
#figure(
      image("Meting6_2.png"),
      caption: [Meting 1: Gelijkstroominstelling],
      kind: image,
    ) <image:m1>
    #align(center)[
  #grid(
    columns: (auto, auto),
    gutter: 8pt,
    align: left,
    [#box(fill: yellow, width: 1.2em, height: 0.8em, radius: 2pt) *CH1:*],
    [$U_s$ [1 V/div]],
    
    [#box(fill: rgb("#00FFFF"), width: 1.2em, height: 0.8em, radius: 2pt) *CH2:*],
    [$U_o$ [50 mV/div]], 
    
    [*Tijdbasis:*], [100 µs/div],
  )
]
  



  - Situatie 2 (zonder RL):
  #figure(
        image("Meting6_4_zonder_Rl.png"),
        caption: [Meting 1: Gelijkstroominstelling],
        kind: image,
      ) <image:m1>
      #align(center)[
    #grid(
      columns: (auto, auto),
      gutter: 8pt,
      align: left,
      [#box(fill: yellow, width: 1.2em, height: 0.8em, radius: 2pt) *CH1:*],
      [$U_s$ [2 V/div]],
      
      [#box(fill: rgb("#00FFFF"), width: 1.2em, height: 0.8em, radius: 2pt) *CH2:*],
      [$U_o$ [50 mV/div]], 
      
      [*Tijdbasis:*], [100 µs/div],
    )
  ]

  = Simulatie
  #image("Schema_LTSPICE.png")
  #image("Screenshot 2025-12-12 101413.png")
  #image("Screenshot 2025-12-12 105331 (1).png")
  #image("Screenshot 2025-12-12 110645.png")
  #image("Screenshot 2025-12-12 112618 (1).png")
  #image("Screenshot 2025-12-12 113053.png")

  = Discussie
  De gemeten waarden komen grotendeels overeen met de berekeningen. De gemeten waarde van de collectorspanning van 6,33V is iets hoger dan de gementen waarde die 6V is. Hierdoor is de collectorstroom iets lager namelijk 0,973 mA dan de gekozen 1 mA. De wisselspanningsversterking Av bij 1 kHz is 14,8 wat binnen de marges is. Dit geeft aan dat de versterker goed ontworpen is. De ingangsimpedantie van 31,1 kΩ ligt boven de minimaal vereiste 25 kΩ. Bij de frequentiekarakteristiek is het laagfrequent afvalpunt bepaald op 20Hz. De eis was 15 Hz dus het afvalpunt ligt hoger. Een reden hiervoor kan zijn dat de condensatorwaarden uit de E12-reeks zijn gepakt. De gemeten 1,1 µF is afgerond naar 1 µF en de 618 nF naar 680 nF.
  
    = Conclusie
  In dit practicum is er een gemeenschappelijke-emitterschakeling ontworpen. Deze schakeling voldoet aan de gestelde eisen. De schakeling heeft een minimale ingangsimpedantie van 25 kΩ, een wisselspanningversterking van -15±1 v/v en dat het laagfrequent afvalpunt dicht bij de 15 Hz ligt. 1

  = Appendix

  
]



