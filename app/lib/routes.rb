Pakyow::App.routes do
  fn :navigation do
    categories = Docs.all
    partial(:nav).scope(:category).apply(categories) do |category|
      topics = Docs.find_topics(category[:nice_name])[1..-1]
      scope(:topic).apply(topics)
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

  get 'f' do
    f
  end

  default do
    reroute('/getting_started')
  end

  get '/:name', :doc, after: [:navigation] do
    name = params[:name]

    if name && !name.empty?
      presenter.path = 'doc'

      res = Docs.find(params[:name])
      if res && category = res.first
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
      presenter.path = '/'
    end
  end

end
