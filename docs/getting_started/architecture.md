---
name: Architecture
---

Here's a rundown of the important bits of a generated Pakyow app:

- app.rb: app environment [configuration](/docs/configuration)
- app/lib: all of your back-end code goes here (every .rb file will be loaded automatically)
- app/lib/bindings.rb: define your [bindings](/docs/bindings) here
- app/lib/helpers.rb: define your [helpers](/docs/helpers) here
- app/lib/routes.rb: define your [routes](/docs/routing) here
- app/views: define your [views](/docs/view_composition) here
- public: for static files (images, stylesheets, javascripts, etc)