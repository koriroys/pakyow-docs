---
name: Application Logic
---

Pakyow provides two different options for organizing your application logic:

  1. Pass blocks containing your application logic to each route definition (TODO reference)
  2. Use controllers to seperate out your application logic

For smaller/simpler applications and APIs, passing blocks to your route definitions might be the best way to go. But for larger/complex applications it can be helpful to break your application logic out into a series of controllers.

#### Controllers

In Pakyow, controllers are optional but are often helpful for large applications. This is an example of a simple controller definition:

	ruby:
	class SomeController
		def some_action
			pp 'got it'
		end
	end

You can route to a controller using the `call` helper (TODO reference):

	ruby:
	get('/', call(:SomeController, :some_action))

	# sending a GET request to '/' will execute SomeController#some_action which prints 'got it'

Just like routes that receive a block of application logic, routes that call a controller can be grouped, nested, and can use hooks (TODO reference).

There are several convenience methods (such as `app`, `request`, `response`, and `presenter`) that you will probably want easy access to from your controller. Just include 'Pakyow::Helpers' into your controller class (TODO reference helpers).