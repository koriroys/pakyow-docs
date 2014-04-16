Pakyow::App.bindings do

  scope :category do
    binding :name_link do
      {
        href: File.join($uri_prefix, router.path(:doc, { slug: bindable.slug })),
        content: bindable.name
      }
    end

    binding :formatted_body do
      Formatter.format(bindable.overview)
    end
  end

  scope :topic do
    binding :name_link do
      {
        href: File.join($uri_prefix, router.path(:doc, { slug: bindable[:category_slug] }) + "##{bindable[:slug]}"),
        content: bindable[:name]
      }
    end

    binding :formatted_body do
      Formatter.format(bindable[:body])
    end
  end
end
