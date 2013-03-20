---
name: Grouping Routes
---

Groups make it possible to organize related routes. A route group can be named and used later when looking up and populating a route (TODO reference or include inline example). Names are optional, but routes in an unnamed group cannot be accessed for URL generation (TODO reference).

    ruby:
    group(:foo) {
      get('/bar') { ... }
    }

Hooks (TODO reference) can be applied to a group of routes, making it easier to organize back-end logic. A common need in a web-based application is to protect parts of the application so only authenticated users have access. Though an easy problem to solve conceptually, it becomes tedius to define and manage the routes if hooks are applied to each route individually. Instead, we can use route groups:

    ruby:
    fn(:login_required) {
      app.redirect('/') unless session[:user]
    }

    group(:protected, before: [:login_required]) {
      get('/bar') {
        pp "You found foo."
      }

      get('/bar') {
        pp "You found bar."
      }
    }

    group(:unprotected) {
      default {
        pp "This route is unprotected."
      }
    }

Looking at the code above we have a much better understanding of what the routes do. It's also easier to add or reorganize routes in the future.
