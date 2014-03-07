---
name: View Access
---

A binder can also obtain access to the view that is being bound to.

    ruby:
    binding :foo do
      { 
        view: lambda { |view|
          view.prepend('some html')
        }
      }
    end
