---
name: Request & Response
---

The underlying Rack Request & Response objects can be accessed through the `request` and `response` methods. This is useful for directly modifying things like response status:

    ruby:
    response.status = 401

In addition, the following things are available in the request:

    ruby:
    request.controller  # the instance of the controller used in this request
    request.action      # the action called in this request
    request.format      # the format used in this request (defaults to HTML)
    request.error       # the error that occurred during the request

See a full explanation of the Request & Response objects here (TODO link).