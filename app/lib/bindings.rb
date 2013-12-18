Pakyow::App.bindings do
  
  scope :category do
    binding :name_link do
      {
        href: router.path(:doc, { name: bindable[:nice_name] }),
        content: bindable[:name]
      }
    end

    binding :formatted_body do
      Formatter.format(bindable[:body])
    end
  end

  scope :topic do
    binding :name_link do
      {
        href: router.path(:doc, { name: bindable[:category_nice_name] }) + "##{bindable[:nice_name]}",
        content: bindable[:name]
      }
    end

    binding :formatted_body do
      Formatter.format(bindable[:body])
    end
  end

end
