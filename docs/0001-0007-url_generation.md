---
name: URL Generation
---

Pakyow provides a way to generate full URL strings with a named route and route data. This means the URL is defined once (in the route definition) and can be used throughout the application without duplication. API changes are much less menacing.

Let's start with a simple route:

    ruby:
    get(:foo, 'foo') {}

The URL for the `:foo` route can be generated from the current instance of `Router`:

    ruby:
    router.path(:foo)
    # => /foo

For routes with arguments, data can be passed to `#path` that is applied to the generated URL:

    ruby:
    get(:bar, 'bar/:my_arg') {}
    router.path(:bar, { my_arg: '123' })
    # => /bar/123

Any object can be passed as data to `#path` that supports key lookup (e.g. `Hash`).

#### Grouped Routes

To generate a URL for a grouped path, simply look up the group before calling `#path`:

    ruby:
    group(:foo) {
      get(:bar, 'bar') {}
    }
    router.group(:foo).path(:bar)
    # => /bar

Routes in nested groups are referencable by the group they directly belong to.
