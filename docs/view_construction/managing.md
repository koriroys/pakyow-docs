---
name: Managing Compilation
---

TODO needs to be rewritten based on latest

View compilation is easily managed from the backend. The view path can be changed:

    ruby:
    presenter.view_path = 'some/path'

Or, changing just the root view path:

    ruby:
    presenter.root_path = 'some_root.html'

As long as the view hasn't been accessed, changing these paths has no impact on performance since the view isn't compiled until it's accessed.

The view can be set explicitly:

    ruby:
    presenter.view = some_view_object

Complex views can also be built and set. Build a view for a particular path using the `at_path` method:

    ruby:
    presenter.view = View.at_path('some/path')

Or compile a view at a particular path:

    ruby:
    presenter.view = View.new('some_view.html').compile('some/path')

Similarly, the root view can be set explicitly:

    ruby:
    presenter.root = some_root_view_object
