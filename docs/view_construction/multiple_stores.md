---
name: Multiple View Stores
---

TODO needs to be rewritten based on latest

Only a single view store is configured by default. However, multiple view stores are supported. Additional view stores can be defined by appending the name and path to the `view_stores` presenter config option (TODO reference):

    ruby:
    Pakyow::Configuration::Presenter.view_stores[:my_store] = "./my_store"

Now two stores are defined for the application:

    default:  ./views
    my_store: ./my_store

Switching to the second store in an application is easy:

    ruby:
    presenter.view_store = :my_store

The view store is be reset to `default` after every request.
