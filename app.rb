require 'rubygems'
require 'bundler/setup'

require 'pakyow'
require 'rdiscount'
require 'pygments'

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
        view.container(:nav).scope(:category).apply(categories) {|context, category|
          topics = Docs.find_topics(category[:category])

          # add default overview topic
          topics.unshift({
            category: category[:category],
            category_nice_name: category[:nice_name],
            topic: '0000',
            nice_name: 'overview',
            name: 'Overview'
          })

          context.scope(:topic).apply(topics)
        }
      }

      get('/:name', :doc, after: fn(:navigation)) {
        name = params[:name]
        
        if name && !name.empty?
          presenter.view_path = '/doc'

          if category = Docs.find(params[:name]).first
            topics = Docs.find_topics(category[:category])

            view.container(:main).with { |view|
              view.scope(:category).bind(category)
              
              view.scope(:topic).apply(topics) {|context, topic|
                context.prop('name').attributes.id = topic[:nice_name]
              }
            }
          else
            app.handle 404
          end
        else
          # show index
          presenter.view_path = '/'
        end
      }
    end

    presenter do
      scope(:category) {
        binding(:name_link) {
          {
            href: router.path(:doc, { name: bindable[:nice_name] }),
            content: bindable[:name]
          }
        }

        binding(:formatted_body) {
          Formatter.format(bindable[:body])
        }
      }

      scope(:topic) {
        binding(:name_link) {
          {
            href: router.path(:doc, { name: bindable[:category_nice_name] }) + "##{bindable[:nice_name]}",
            content: bindable[:name]
          }
        }

        binding(:formatted_body) {
          Formatter.format(bindable[:body])
        }
      }
    end

    middleware {
      use Sass::Plugin::Rack
    }
  end
end
