Pakyow::App.bindings do
  
  scope :category do
    binding :name_link do
      {
        href: File.join($uri_prefix, router.path(:doc, { name: bindable[:nice_name] })),
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
        href: File.join($uri_prefix, router.path(:doc, { name: bindable[:category_nice_name] }) + "##{bindable[:nice_name]}"),
        content: bindable[:name]
      }
    end

    binding :formatted_body do
      Formatter.format(bindable[:body])
    end
  end

  scope :contributor do
    binding :avatar do
      {:src => "#{bindable['avatar_url']}"}
    end

    binding :login do
      {
        :href => "#{bindable['html_url']}",
        :content => "#{bindable['login']}"
      }
    end

    binding :count do
      {:content => "#{bindable['contributions']}"}
    end

    binding :grammatical_num do
      {:content => bindable['contributions'] > 1 ? 'contributions' : 'contribution'}
    end
  end
end
