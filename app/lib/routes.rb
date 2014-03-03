Pakyow::App.routes do

  fn :navigation do
    categories = Docs.find_categories
    partial(:nav).scope(:category).apply(categories) do |category|
      topics = Docs.find_topics(category[:nice_name])[1..-1]

      # # add default overview topic
      # topics.unshift({
      #   # category: category[:category],
      #   category_nice_name: category[:nice_name],
      #   # topic: '0000',
      #   nice_name: 'overview',
      #   name: 'Overview'
      # })

      scope(:topic).apply(topics)
    end
  end

  default do
    reroute('/getting_started')
  end

  get '/:name', :doc, after: [:navigation] do
    name = params[:name]

    if name && !name.empty?
      presenter.path = 'doc'

      if category = Docs.find(params[:name]).first
        view.title = "Pakyow Docs | #{category[:name]}"

        topics = Docs.find_topics(params[:name])[1..-1]

        container(:default).scope(:category).with do
          bind(category)

          scope(:topic).apply(topics) do |topic|
            prop(:name).attrs.id = topic[:nice_name]
          end
        end
      else
        app.handle 404
      end
    else
      # show index
      presenter.path = '/'
    end
  end

end
