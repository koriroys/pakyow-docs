---
name: Architecture
---

Here's a rundown of the important bits of a generated Pakyow app:

- app.rb: app environment [configuration](/configuration)
- app/lib: all of your back-end code goes here (every .rb file will be loaded automatically)
- app/lib/bindings.rb: define your [bindings](/bindings) here
- app/lib/helpers.rb: define your [helpers](/helpers) here
- app/lib/routes.rb: define your [routes](/routing) here
- app/views: define your [views](/view_composition) here
- public: for static files (images, stylesheets, javascripts, etc)