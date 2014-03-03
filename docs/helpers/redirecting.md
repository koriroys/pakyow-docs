---
name: Redirecting
---

Issuing a browser redirect is easy:

    ruby:
    redirect '/foo'

Or even better, if you define your route with a name (such as :foo) the URI will be generated [automatically](/routing#uri_generation):

    ruby:
    redirect :foo

When redirecting, the response status is set to 302 by default and the response is sent immediately.

You can override the default status by passing a status code:

    ruby:
    redirect '/foo', 301
