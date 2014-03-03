---
name: Bindings
---

Data bindings can be thought of conceptually as functions that route data to the view. They can be used for setting view attributes, formatting data, etc. By default, bindings should be defined in `app/lib/bindings.rb`.

Bindings are defined for a particular scope and prop. As an example, let's define a binding that randomly sets the text color for some prop:

    ruby:
    scope :post do
      binding :title do
        {
          style: {
            color: %w(red blue green).sample
          },

          content: bindable[:body]
        }
      end
    end

This binding is called anytime data is bound to `title` prop for a `post` scope, like this:

    ruby:
    data = {
      title: 'First Post'
    }

    view.scope(:post).bind(data)

Here's the result:

    html:
    <div data-scope="post">
      <h1 data-prop="title" style="color:blue">
        First post
      </h1>
    </div>

Of course, the color will be randomly assigned each time bind is called.
