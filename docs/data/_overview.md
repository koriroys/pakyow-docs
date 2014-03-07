---
name: Application Data
---

Pakyow will play nice with your objects so long as they support hash-style key lookup, like this:

    ruby:
    my_obj[:some_key]

Most object-relational mappers in Ruby support this syntax, including [Sequel](http://sequel.rubyforge.org/) and [ActiveRecord](http://api.rubyonrails.org/classes/ActiveRecord/Base.html).
