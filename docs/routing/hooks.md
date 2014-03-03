---
name: Route Hooks
---

Another use for named functions is as a before, after, or around hook for a route. Once defined, hooks will be executed in order along with the main route function. For example, we could define a `require_auth` function that checks for proper authentication:

    ruby:
    fn :require_auth do
      redirect '/' unless session[:user]
    end

    get 'protected', :before => :require_auth

    # sending a GET request to '/protected' results in a call order of:
    #   require_auth
    #   main route function

Though a silly example, we could also use the function as an after hook:

    ruby:
    get 'protected', :after => :require_auth

    # sending a GET request to '/protected' results in a call order of:
    #   main route function
    #   require_auth

Multiple hooks of a type are supported and are called in the order defined:

    ruby:
    get '/', before: [:foo, :bar]

    # sending a GET request to '/' results in a call order of:
    #   foo
    #   bar
    #   main route function
