---
name: Sending Mail
---

Pakyow has a separate library, pakyow-mailer, for sending mail. It's built on the <a href="https://github.com/mikel/mail" target="_blank">mail</a> gem and adds the ability for views to be delivered through email. Here's a basic example:

	ruby:
	Pakyow::Mailer.new(view_path).deliver_to("test@pakyow.com")  # also accepts an array of addresses

The view will be constructed just like it would be if it was being presented in a browser. Access to the view is also available for manipulation and binding:

	ruby:
	mailer = Pakyow::Mailer.new(view_path)
	mailer.view.scope(:foo).apply(some_data)
	mailer.deliver_to(["test@pakyow.com", "example@pakyow.com"])

Access to the <a href="https://github.com/mikel/mail" target="_blank">mail</a> gem's message object is also available:

	ruby:
	mailer = Pakyow::Mailer.new(view_path)
	mailer.message.subject = 'Pakyow Rocks!'
	mailer.message.add_file("/path/to/file.jpg")
	mailer.deliver_to("test@pakyow.com")

There are several configuration settings for Mailer. See [configuration](/docs/configuration) for more information.