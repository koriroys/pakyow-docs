require 'rubygems'
require 'bundler/setup'

require 'pakyow'

require 'sass/plugin/rack'
Sass::Plugin.options[:template_location] = './resources/sass'
Sass::Plugin.options[:css_location] = './public/css'

require 'pp'

module PakyowApplication
  class Application < Pakyow::Application
    config.app.default_environment = :development

    configure(:development) do
      $stdout.sync = true

      $docs_path = 'docs'
    end

    configure(:test) do
      $docs_path = 'test/docs'
    end

    configure(:prototype) do
      app.ignore_routes = true
    end

    core do
      fn(:navigation) {
        categories = Docs.find_categories
        presenter.view.scope('nav-category').repeat(categories) {|context, category|
          context.bind(category)
          #TODO remove once binder is working
          context.prop('name_link').attributes.href = "/categories/#{category[:nice_name]}"
          context.prop('name_link').content = category[:name]

          topics = Docs.find_topics(category[:category])
          context.scope('nav-topic').repeat(topics) {|t_context, topic|
            t_context.bind(topic)
            #TODO remove once binder is working
            t_context.prop('name_link').attributes.href = "/categories/#{category[:nice_name]}##{topic[:nice_name]}"
            t_context.prop('name_link').content = topic[:name]
          }
        }
      }

      get('/', after: fn(:navigation)) {
        #TODO
      }

      get('/categories/:name', after: fn(:navigation)) {
        #TODO not really sure why I have to set this?
        presenter.view = View.new('pakyow.html').compile('categories')

        if category = Docs.find(request.params[:name]).first
          topics = Docs.find_topics(category[:category])

          presenter.view.scope('category').bind(category)
          presenter.view.scope('topic').repeat(topics) {|context, topic|
            context.prop('name').attributes.id = topic[:nice_name]
            context.bind(topic)
          }
        else
          #TODO not_found
        end
      }
    end

    #TODO can't get this to work. probably doing something dumb
    presenter do
      scope('nav-category') {
        binding(:name_link) {
          {
            href: "/categories/#{bindable[:nice_name]}",
            content: bindable[:name]
          }
        }
      }

      scope('nav-topic') {
        binding(:name_link) {
          {
            href: "##{bindable[:nice_name]}",
            content: bindable[:name]
          }
        }
      }
    end

    middleware {
      use Sass::Plugin::Rack
    }
  end
end
