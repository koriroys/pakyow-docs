---
name: Traversing Views
---

Pakyow makes it possible to traverse significant nodes in a view. A significant node is one that has been labeled as a `scope` or `prop`.

    ruby:
    view.scope(:some_scope)
    view.prop(:some_prop)

In addition, parts of a view can be accessed using the following helper methods:

    ruby:
    template
    page
    partial(:some_partial)
    container(:some_container)

We don't recommend using it, but the underlying Nokogiri document is accessible via the `doc` method.
