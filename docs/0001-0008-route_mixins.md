---
name: Route Mixins
---

As a Pakyow application grows, so does app.rb (TODO reference architecture). Route mixins allow sets of routes to be moved out of app.rb into their own source files. Each set is registered with a unique name, like so:

    ruby:
    Pakyow.app.routes(:set_name) {
      # routes go here
    }

An application's main route set is called `:main`, and is defined without passing a set name:

    ruby:
    Pakyow.app.routes {
      # main routes go here
    }

Matching is done using a LIFO (last in, first out) pattern, so the order in which route sets are loaded matters. Main routes are always loaded last and thus have top priority in an application (if two routes match, the one in the main route set wins). Load order for additional route sets is configuration (TODO define).

Only main routes will be auto-reloaded by default. This is configurable (TODO define).

Route mixins also provide a way for other libraries to add routes to an application. This is discussed in more detail in "Plugging Pakyow" (TODO reference).