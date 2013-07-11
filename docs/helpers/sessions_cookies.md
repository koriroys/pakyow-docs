---
name: Sessions & Cookies
---

Sessions keep state across requests. They can be enabled by using any Rack session middleware:

    ruby:
    middleware do
      use Rack:Session::Cookie
    end

Sessions can then be set and fetched through the `sessions` helper:

    ruby:
    session[:foo] = 'bar'
    p session[:foo]

    # prints 'bar'

Cookies can be set and fetched the same way:

    ruby:
    cookies[:foo] = 'bar'
    p cookies[:foo]

    # prints 'bar'

By default, a cookie is created for path '/' and is set to expire in seven days. These defaults can be overridden by using the `set_cookie` helper:

    ruby:
    response.set_cookie :foo, {
      :value => 'bar',
      :expires => Time.now + 3600,
      :path => '/login'
    }
