---
name: View Composition
---

An application's views are grouped into a view store, which is a hierarchical set of HTML files that roughly map to an application's routes. These files are composed together into the full view for a particular request.

There are three parts to a view:

1. Template: defines the reusable structure for a view
2. Page: implements a template with page-specific content
3. Partial: a reusable piece that can be included into a Page or Template
