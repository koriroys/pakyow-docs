---
name: Params
---

Query string parameters, POST data, and values from routes arguments are available in the `params` helper.

    ruby:
    get ':foo' do
      p params[:foo]
    end
