---
name: View Processors
---

TODO mention available processors (haml / markdown)

Processors allow views to be processed prior to being handed to Presenter. The most common use for view processors is to allow views to be written in languages other than HTML (e.g. Markdown or HAML). Since Presenter always expects HTML, a processor is passed the contents of the view and should always return HTML. Below is an example that uses RDiscount to process views written in Markdown:

    ruby:
    processor :md, :markdown do |content|
      RDiscount.new(content).to_html
    end

This processor will handle any view with a `md` or `markdown` extension. An application using this processor can define views in both Markdown and HTML. Presenter works as if all views were written in HTML.

    views/
      main.md
      pakyow.html

Processors are defined in an application's `presenter` block (TODO reference architecture).
