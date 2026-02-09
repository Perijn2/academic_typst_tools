#import "@preview/elembic:1.1.1" as e

// Define version entry type
#let contributor = e.types.declare(
  "contributor",
  prefix: "@preview/type-contributor,v1",
  doc: "Contributor type",
  
  fields: (
    e.field("name", str, required: true, named: true),
    e.field("department", str, required: true, named: true),
    e.field("description", e.types.any, required: true, named: true),
    e.field("date", str, required: true, named: true),
    e.field("level", int, default: 3, named: true),
  ),
)