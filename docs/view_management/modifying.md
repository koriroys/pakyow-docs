---
name: View Modification
---

Views can be modified from back-end code in a number of ways, including:

    ruby:
    # remove the view
    view.remove

    # clear the contents
    view.clear

    # get the text content
    view.text

    # set the text content
    view.text = ...

    # get the html content
    view.html

    # set the html content
    view.html = ...

    # append a view or content
    view.append(...)

    # prepend a view or content
    view.prepend(...)

    # insert a view or content after the view
    view.after(...)

    # insert a view or content before the view
    view.before(...)

    # replace the view with a view or content
    view.replace(...)

Pakyow also provides a way of dealing with view contexts:

    ruby:
    view.scope(:post).with do
      prop(:title).remove

      # do more to the context here
    end

These contexts are available to the following methods:

- with
- for
- repeat
- bind
- apply

Read more [here](/view_management#traversing).
