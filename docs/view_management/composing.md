---
name: Composing Views
---

View compilation is easily managed from the backend. The view path can be changed:

    ruby:
    presenter.path = 'some/path'

The view can also be set explicitly:

    ruby:
    presenter.view = a_view_object

Complex views can also be composed and set. This is done through the `ViewComposer` object. The way composer works is you specify the path you want to compose at, then override any part of the view (e.g. a template, page, or partial).

    ruby:
    presenter.view = compose_at('some/path', template: 'some_other_template')
