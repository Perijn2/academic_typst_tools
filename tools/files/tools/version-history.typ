#import "@preview/elembic:1.1.1" as e

// Define version entry type
#let version = e.types.declare(
  "version",
  prefix: "@preview/version-history,v1",
  doc: "Version entry",
  
  fields: (
    e.field("committee", e.types.any, required: true, named: true),
    e.field("description", e.types.any, required: true, named: true),
    e.field("date", str, required: true, named: true),
    e.field("level", int, default: 3, named: true),
  ),
)

// Version history element that accepts version children
#let version-history = e.element.declare(
  "versionHistory",
  prefix: "@preview/version-history,v1",
  
  display: it => {
    let versions = it.children.filter(c => {
      type(c) == dictionary and e.eid(c) == e.eid(version)
    })
    
    // Calculate version number
    let calculate = (index) => {
      let major = 1
      let minor = 0
      let patch = 0
      for i in range(0, index + 1) {
        let level = versions.at(i).level
        
        if level == 1 {
          major += 1
          minor = 0
          patch = 0
        } else if level == 2 {
          minor += 1
          patch = 0
        } else {
          patch += 1
        }
      }
      str(major) + "." + str(minor) + "." + str(patch)
    }

    heading(level: it.level, it.title)
    
    if versions.len() > 0 {
      table(
        columns: (auto, 1.5fr, 3fr, auto),
        stroke: 0.5pt,
        inset: 8pt,
        align: (center, left, left, center),
        
        table.header(
          [*Version*], [*Committee*], [*Description*], [*Date*]
        ),

        ..versions.enumerate().map(item => {
          let (idx, ver) = item
          (
            calculate(idx),
            ver.committee,
            ver.description,
            ver.date
          )
        }).flatten()
        
      )
    } else {
      [_No version history entries_]
    }
  },
  
  fields: (
    e.field("children", e.types.any, required: true),
    e.field("title", str, default: "Version History", named: true),
    e.field("level", int, default: 1, named: true),
  ),
  
  parse-args: (default-parser, fields: none, typecheck: none) => (args, include-required: false) => {
    let args = if include-required {
      let values = args.pos()
      arguments(values, ..args.named())
    } else if args.pos() == () {
      args
    } else {
      return (false, "element 'versionHistory': unexpected positional arguments")
    }

    default-parser(args, include-required: include-required)
  },
)




// ============================================
// USAGE EXAMPLE
// ============================================
