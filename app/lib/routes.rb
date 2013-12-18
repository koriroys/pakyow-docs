Pakyow::App.routes do

  fn :navigation do
    categories = Docs.find_categories
    view.scope(:nav).scope(:category).apply(categories) {|context, category|
      topics = Docs.find_topics(category[:nice_name])[1..-1]

      # # add default overview topic
      # topics.unshift({
      #   # category: category[:category],
      #   category_nice_name: category[:nice_name],
      #   # topic: '0000',
      #   nice_name: 'overview',
      #   name: 'Overview'
      # })

      context.scope(:topic).apply(topics)
    }
  end

  default do
    reroute('/getting_started')
  end

  get '/:name', :doc, after: [:navigation] do
    name = params[:name]

    if name && !name.empty?
      presenter.path = 'doc'

      if category = Docs.find(params[:name]).first
        topics = Docs.find_topics(params[:name])[1..-1]

        view.scope(:content).with { |view|
          view.scope(:category).with { |category_ctx|
            category_ctx.bind(category)

            category_ctx.scope(:topic).apply(topics) {|topic_ctx, topic|
              topic_ctx.prop('name').attributes.id = topic[:nice_name]
            }
          }
        }
      else
        app.handle 404
      end
    else
      # show index
      presenter.path = '/'
    end
  end

end
