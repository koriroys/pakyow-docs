---
name: DOM Attributes
---

There are three types of attributes in Pakyow:

- string (e.g. href)
- enumerable (e.g. class)
- boolean (e.g. selected)

Pakyow handles each in a smart way. Attributes can be access or modified using the hash key syntax:

    ruby:
    view.attrs[:href] = '/foo'
    view.attrs[:class] << 'class_to_add'
    view.attrs[:selected] = true

Attributes can be massed assigned by setting attrs to a hash:

    ruby:
    view.attrs = { href: '/foo', class: ['some_class'] }

Values can be modified rather than overridden by passing a lamda as a value:

    ruby:
    view.attrs[:class] = lambda { |klass| klass << 'foo' if some_condition }

Attribute values can also be ensured or denied, meaning Pakyow will make sure the given value is or is not present for the attribute:

    ruby:
    view.attrs[:class].ensure(:foo)
    view.attrs[:class].deny(:bar)
