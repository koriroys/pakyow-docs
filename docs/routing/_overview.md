---
name: Routing
---

Routes are responsible for routing a request to back-end logic. In Pakyow, a route consists of:

  1. HTTP method (GET, PUT, POST, DELETE)
  2. Pattern to match request path
  3. Route function(s)
  4. Name (optional)

This is one of the simplest route definitions:

    ruby:
    get('/') {
      p 'got it'
    }

    # sending a GET request to '/' prints 'got it'

Defining routes for the other supported HTTP methods is just as easy:

    ruby:
    put('/') {
      p 'put'
    }

    post('/') {
      p 'post'
    }

    delete('/') {
      p 'delete'
    }

Routes should be defined inside an app's `core` block (TODO reference).

    ruby:
    class PakyowApplication < Pakyow::Application
      core do
        get('/') {
          p 'got it'
        }

        put('/') {
          p 'put'
        }

        post('/') {
          p 'post'
        }

        delete('/') {
          p 'delete'
        }
      end
    end

#### Route Arguments

Named arguments can be defined for a route. When the route is matched, data will be parsed from the incoming request and available in the back-end logic through the `params` helper (TODO reference).

    ruby:
    get('say/:msg') {
      p params[:msg]
    }

    # sending a GET request to '/say/hello' prints 'hello'

#### Named Routes

Routes can be given an optional name.

    ruby:
    get(:root, '/') {}

This name is used to look up and populate routes in your app (TODO reference).

#### Default Route

For convience, a default route can be defined without providing a path.

    ruby:
    default {}

This is identical to defining a `get` route for `/` with a name of `:default`.

    ruby:
    get(:default, '/') {}

#### Regex Matchers

In addition to string matchers, regex is also supported.

    ruby:
    # match anything
    get(/.*/) {}

Named captures (available since ruby-1.9) are also supported. When matched, data will be available just like with a route argument.

    ruby:
    get(/say\/(?<msg>(.*))/) {
      p params[:msg]
    }

    # sending a GET request to '/say/hello' prints 'hello'