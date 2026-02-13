//------------------------------------------------
// Document features
//------------------------------------------------

//#import "version-history.typ": *

// Tablex is used for advanced table manipulation, like merging cells.
#import "@preview/tablex:0.0.9" as tablex

// Lilaq is used for advanced plotting
#import "@preview/lilaq:0.5.0" as lq

// round, uround, urounds
#import "@preview/sigfig:0.1.0" as sigfig

// Numerical library
#import "@preview/zero:0.5.0": zi, ztable, num

// Used for digital circuits
#import "@preview/circuiteria:0.2.0"

// Neural network drawing library
#import "@preview/neural-netz:0.3.0": draw-network

#import "@preview/rivet:0.3.0": schema

//#import "@preview/unify:0.5.0" as unify

#import "tools/version-history.typ": *

#import "/files/IEEE/PageFormats/page-setup.typ": *

//------------------------------------------------
// Document formats
//------------------------------------------------

#let kohm = zi.declare($k Omega$)
#let Mohm = zi.declare($M Omega$)
#let Gohm = zi.declare($G Omega$)


#import "@preview/rivet:0.3.0": schema
#let doc = schema.load(yaml("/files/test2.yaml"))
#schema.render(doc)

#import "academic.typ": *
#import "testplan.typ": *
#import "meetrapport.typ": *