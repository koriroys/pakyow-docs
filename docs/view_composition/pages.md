---
name: Pages
---

When fulfilling a request, Pakyow first identifies the page to use based on the request path. For example, a request for '/' would map to the 'index.html' page. Pages can also be nested under folders, meaning either `foo.html` and `foo/index.html` could be used for a view at path `/foo`.

A page implements a single template. If a template isn't specified, Pakyow uses the default template (named `pakyow.html`). A template can be specified by adding YAML front-matter to the page:

      html:
      ---
      template: some_template
      ---

      ...

The title for a page can also be specified in the front-matter.
