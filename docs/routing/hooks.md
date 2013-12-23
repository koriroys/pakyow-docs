---
name: Route Hooks
---

Another use for named functions is as a before, after, or around hook for a route. Once defined, hooks will be executed in order with the main route function. For example, we could define a `login_required` function that checks for proper authentication:

    ruby:
    fn :login_required do
      redirect '/' unless session[:user]
    end

    get 'protected', :before => :login_required

    # sending a GET request to '/protected' results in a call order of:
    #   login_required
    #   main route function

Though a silly example, we could use the function as an after hook (TODO instead of a silly example, how about a call to a user activity log function? - CH):

    ruby:
    get 'protected', :after => :login_required

    # sending a GET request to '/protected' results in a call order of:
    #   main route function
    #   login_required

Multiple hooks of a type are supported and are called in the order defined:

    ruby:
    get '/', before: [:foo, :bar]

    # sending a GET request to '/' results in a call order of:
    #   foo
    #   bar
    #   main route function
