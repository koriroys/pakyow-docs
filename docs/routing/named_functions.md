---
name: Named Route Functions
---

Named functions are exactly that &ndash; named functions that can be used as a primary function for a route. They also come into play when defining route hooks (TODO reference). Defining a function and referencing it in one or more route definitions is easy.

    ruby:
    fn :foo do
      p 'foo fn'
    end

    get 'foo', fn(:foo)
    get 'bar', fn(:foo)

    # sending a GET request to '/foo' or '/bar' prints 'foo fn'

#### Function Builders

When looking up a function, the `fn` helper returns the proc used when defining the function. This reveals a key detail in how Pakyow works &ndash; that is a route always maps a matcher to one or more functions. Just to prove the point, we could define a route with an inline call to `lambda`:

    ruby:
    get 'foo', lambda { p 'foo fn' }

This allows other route helpers to be defined that return a single or set of functions. An example of this can be found in Controllers (TODO reference).

#### Function Context

All functions for a particular route are evaluated in a single context. This allows state to be shared between functions, like so (use of before is covered under Route Hooks (TODO reference)):

    ruby:
    fn :foo do
      @state = 'bar'
    end

    get '/', before: [:foo] do
      p @state
      # => bar
    end
