---
name: Halting & Rerouting
---

The execution of a route block, a controller, a hook, or a handler can be stopped immediately by calling the `halt` helper:

    ruby:
    app.halt

The execution of a route block, a controller, a hook, or a handler can be stopped immediately and control transferred to another route by using the `reroute` helper:

    ruby:
    app.reroute "/foo"

Or even better, if you define your route with a name (such as :foo) you can use URL generation (TODO reference):

    ruby:
    app.reroute router.path(:foo)

The execution of a route block, a controller, a hook, or a handler can also be stopped immediately and control transferred to a handler (TODO reference handlers).
