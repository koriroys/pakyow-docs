---
name: Route Templates
---

Route templates make it easy to define a set of routes and that can be used multiple times in an application. Each use, or expansion, of the template has its own set of route functions. During expansion the template takes care of defining the routes and setting the name, path, and hooks for each route. A template expansion can also create a group (TODO reference) or namespace (TODO reference).

Templates are useful in cases where sets of common actions are needed that follow a similar pattern. RESTful routes (TODO reference) are a perfect use-case for templates. In fact, there is a built-in template for defining RESTful routes. Here is the template:

    ruby:
    template(:restful) {
      default, fn(:default)
      
      get '/:id', fn(:show)

      get '/new', :new, fn(:new)
      post '/', :create, fn(:create)

      get '/:id/edit', :edit, fn(:edit)
      put '/:id', :update, fn(:update)

      delete '/:id', :delete, fn(:delete)
    }

When expanding a template, route functions are defined as named actions:

    ruby:
    expand(:restful) {
      action(:default) {
        # default
      }

      action(:show) {
        # show
      }
    }

If we did this long-hand, it would look like this:

    ruby:
    default {
      # default
    }
      
    get('/:id') {
      # show
    }

The big win offered by templates is the ability to hide intricate routing details in the template definition, leaving the implementor to stay focused on writing application logic. 

Templates offer a few wins over the long-hand approach:

  - Intricacies of the particular routes are hidden in the template definition, leaving the implementor to focus on the logic tied to the routes.
  - Common patterns can be expressed, leading to a potentially significant reduction in code duplication.
  - Route changes can be made in one place and be automatically applied to each expansion.

#### Groups &amp; Namespaces

Expanding a template creates either a group or a namespace (TODO reference) (yes, the long-hand example above is kind of a lie). What is created is dependent on the arguments passed to the expansion. If only a route name is passed, an unnamed group is created. Passing two arguments results in a named route group. The following expands the `restful` template into a group named `posts`:

    ruby:
    expand(:restful, :posts) {}

Passing the path as a third argument creates a namespace:

    ruby:
    expand(:restful, :posts, '/posts') {}

The example above creates a group of routes called `posts` namespaced under `/posts`.

#### Template Hooks

Hooks (TODO reference) can be defined in the template definition or expansion. The difference is defining a hook in the definition applies the hook to every expansion, while defining a hook on a single expansion applies it to that one expansion. They can be defined at different levels in each case.

For definitions, hooks can be defined on the entire definition or only for a particular route in the definition.

    ruby:
    template(:my_template, before: [:foo]) {
      get 'one', before: [:bar], fn(:one)
      get 'two', fn(:two)
    }

    expand(:my_template) {
      action(:one) {}
      action(:two) {}
    }

In the above example both routes have the `foo` before hook, but only the first route has both `foo` and `bar` before hooks.

Expansions work in a similar way. Hooks can be defined on the entire expansion or only for a particular route in the definition.

    ruby:
    template(:my_template) {
      get 'one', fn(:one)
      get 'two', fn(:two)
    }

    expand(:my_template, before: [:foo]) {
      action(:one, before: [bar]) {}
      action(:two) {}
    }

The above example results in the same routes as the definition example.
