---
name: Redirecting
---

Issuing a browser redirect is easy:

    ruby:
    app.redirect '/foo'

Or even better, if you define your route with a name (such as :foo) you can use URL generation (TODO reference):

    ruby:
    app.redirect router.path(:foo)

When redirecting, the response status is set to 302 by default and the response is sent immediately.

You can overrwite the default status by passing a status code:

    ruby:
    app.redirect '/foo', 301
