---
name: View Binding API
---

Pakyow defines several methods useful when binding data to a view.

##### for

The `for` method yields each view and matching datum. This is driven by the
view, meaning datums are yielded until no more views are available. In the
single view case, only one view/datum pair is yielded.

    ruby:
    view.for(data) { |view, datum|
      ...
    }

#### match

The `match` method returns a `ViewCollection` that has been transformed to match
the data.

    ruby:
    view.match(data)

#### repeat

The `repeat` method calls `match`, then yields each view/datum pair.

    ruby:
    view.repeat(data) { |view, datum|
      ...
    }

This is the same as chaining `match` and `for`:

    ruby:
    view.match(data).for(data) { |view, datum|
      ...
    }

#### bind

The `bind` method binds data across props contained in the scoped view, without applying any transformation to the view. An example can be found above (TODO link).

If a block is passed, each view/datum pair is yielded to it (where the view is fully bound with the data).

#### apply

The `apply` method transforms the view to match the data being applied, then binds the data to the transformed view. An example can be found in the next section (TODO link).

If a block is passed, each view/datum pair is yielded to it (where the view is fully bound with the data). See "Binding to Nested Scopes" for an example of where this is useful.
