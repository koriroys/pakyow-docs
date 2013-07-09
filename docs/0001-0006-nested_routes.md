---
name: Nested Routes
---

Groups, namespaces, and template expansions can each be nested at multiple levels. Nesting makes it easier to create and maintain complex route sets, like so:

    ruby:
    namespace(:foo, 'foo') {
      default {}

      namespace(:bar, 'bar') {
        default {}
      }
    }

Two routes are created:

  - GET /foo
  - GET /foo/bar

Adding a group is just as easy:

    ruby:
    namespace(:foo, 'foo') {
      default {}

      namespace(:bar, 'bar') {
        default {}
      }

      group(before: [:protect]) {
        get('/cannot_see_this') {}
      }
    }

In this case four routes are created:

  - GET /foo
  - GET /foo/bar
  - GET /foo/cannot_see_this

The grouped route inherits the `protect` hook from the group it belongs in. So as expected, hooks are applied at and below the depth they are defined.

#### Nested Template Paths

When nesting templates, the default nested path is the path provided in the expansion. This, for example:

    ruby:
    template(:mine) {
      default, fn(:default)
    }

    expand(:mine, :foo, 'foo') {
      action(:default) {}

      expand(:mine, :bar, 'bar') {
        action(:default) {}
      }
    }

results in the following routes:

  - GET /foo
  - GET /foo/bar

However, there are times when the path for nested expansions need to be altered. A good example of this is in nested RESTful routes, where the nested url is actually the show path for the parent resource. We would expect this:

    ruby:
    expand(:restful, :post, 'posts') {
      default {}

      expand(:restful, :comment, 'comments') {
        default {}
      }
    }

to result in the following routes:

  - GET /posts
  - GET /posts/:post_id/comments

however, these are the default resulting routes:

  - GET /posts
  - GET /posts/comments

This is solved by overriding the nested url in the `:restful` template definition:

    ruby:
    template(:restful) {
      nested_url { |group, path
        File.join(path, ":#{group}_id")
      }

      # ...
    }

The `nested_url` block receives the group name and expansion path as arguments, and the return value is used as the new nested url for that expansion Now the routes are created as expected:

  - GET /posts
  - GET /posts/:post_id/comments

The `:restful` template build in to Pakyow already works this way.
