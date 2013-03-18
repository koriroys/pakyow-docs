---
name: Namespaces
---

Namespaces make it possible to group routes under a common URL.

    ruby:
    namespace('foo') {
      default {
        pp 'foo: default'
      }

      get('bar') {
        pp 'foo: bar'
      }
    }

    # sending a GET request to '/foo' prints 'foo: default'
    # sending a GET request to '/foo/bar' prints 'foo: bar'
    # sending a GET request to '/' or '/bar' results in a 404

A namespace is implemented as a special kind of group (TODO reference), so everything about a group is also true of a namespace. This means that namespaces can be assigned hooks and given a name.

    ruby:
    namespace(:foo, 'foo', before: [:some_hook]) {
      # foo routes go here
    }
