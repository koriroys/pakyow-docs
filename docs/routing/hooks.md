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

As appropriate, we could also use a function as an after hook:

    ruby:
    fn :log_user_activity do
      # write record of data accessed via active page
    end

    get 'tracked_query', :after => :log_user_activity

    # sending a GET request to '/tracked_query' results in a call order of:
    #   main route function
    #   log_user_activity

Multiple hooks of a type are supported and are called in the order defined:

    ruby:
    get '/', before: [:foo, :bar]

    # sending a GET request to '/' results in a call order of:
    #   foo
    #   bar
    #   main route function
