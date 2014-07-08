Pakyow::App.routes do
  fn :navigation do
    categories = Category.all
    partial(:nav).scope(:category).apply(categories) do |category|
      scope(:topic).apply(category.topics)
    end
  end

  handler 404, after: [:navigation] do
    presenter.path = 'errors/404'
  end

  handler 500, after: [:navigation] do
    unless Pakyow.app.env == :development
      subject = 'pakyow-web fail'

      body = []
      body << request.path
      body << ""
      body << request.error.message
      body << ""
      body.concat(request.error.backtrace)

      mail = Mail.new do
        from    'fail@pakyow.com'
        to      ENV['FAIL_MAIL']
        subject subject
        body    body.join("\n")
      end

      mail.delivery_method :sendmail
      mail.deliver
    end

    presenter.path = 'errors/500'
  end

  default do
    reroute('/getting_started')
  end

  get '/:slug', :doc, after: [:navigation] do
    if slug = params[:slug]
      presenter.path = 'doc'

      if category = Category.find(params[:slug])
        view.title = "Pakyow Docs | #{category.name}"

        container(:default).scope(:category).with do
          bind(category)

          scope(:topic).apply(category.topics) do |topic|
            prop(:name).attrs.id = topic.slug
          end
        end
      else
        app.handle 404
      end
    else
      presenter.path = '/'
    end
  end

end
