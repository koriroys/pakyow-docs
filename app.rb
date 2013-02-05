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
    end
    
    configure(:prototype) do
      app.ignore_routes = true
    end

    core do
    end

    middleware {
      use Sass::Plugin::Rack
    }
  end
end
