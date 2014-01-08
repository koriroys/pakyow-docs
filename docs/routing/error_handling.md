---
name: Error Handling
---

Handlers are responsible for intercepting an error so that it can be handled by back-end logic. They are defined within the `core` block in app.rb.

Here are two basic handler definitions:

    ruby:
    handler 404 do
      p 'not found'
    end

    handler 500 do
      p 'internal server error'
    end

When invoked, current execution is stopped, the response status is set accordingly, and control is transferred to the handler. A handler can be invoked explicitely by calling it from a route block, controller, hook, or another handler.

    ruby:
    get '/' do
      p 'foo'
      handle 404

      p 'will never see this'
    end

    # a GET request to '/' will print 'foo' and then 'not found' and return with a status of 404

There are also two scenarios where a handler can be invoked implicitely:

  1. If a request doesn't match a route, a view path, or a static file then a 404 response status is automatically set, and if a 404 handler has been defined it will be invoked.
  2. If an exception is raised in the back-end code then a 500 response status is automatically set, and if a 500 handler has been definied it will be invoked.
