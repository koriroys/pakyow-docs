---
name: Route Sets
---

TODO include something here about mixins, including reference to the more detailed docs on mixins

As a Pakyow application grows, so does app.rb (TODO reference architecture). Route sets allow sets of routes to be moved out of app.rb into their own source files located in your application's lib/routes directory. (TODO does anything need to be done to ensure that these files are loaded?) Each set is registered with a unique name, like so:

    ruby:
    Pakyow.app.routes :my_routes do
      # routes go here
    end

An application's main route set is called `:main`, and is defined without passing a set name:

    ruby:
    Pakyow.app.routes do
      # main routes go here
    end

The first set defined is the first matched, so the order in which route sets are loaded does matter. Main routes are always loaded first and thus have top priority in an application (if two routes match, the one in the main route set wins). Load order for additional route sets is determined by the order of definition.

Route sets also provide a way for other libraries to add routes to an application. This is discussed in more detail in "Plugging Pakyow" (TODO reference).
