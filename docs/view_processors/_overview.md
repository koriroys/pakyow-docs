---
name: View Processors
---

Processors allow views to be processed prior to being handed to Presenter. Their most common useis to allow views to be written in languages other than HTML (e.g. Markdown or HAML). Since Presenter always expects HTML, a processor is passed the contents of the view and should always return HTML. Below is an example that uses RDiscount to process views written in Markdown:

    ruby:
    processor :md, :markdown do |content|
      RDiscount.new(content).to_html
    end

This processor will handle any view with a `md` or `markdown` extension. An application using this processor can define views in both Markdown and HTML. Presenter works as if all views were written in HTML.

    views/
      index.md

Processors are defined in `app.rb`.

Two processors have been created as gems that you can include into your app:

- [HAML](http://github.com/metabahn/pakyow-haml)
- [Markdown](http://github.com/metabahn/pakyow-markdown)
