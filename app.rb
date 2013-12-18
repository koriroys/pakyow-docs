require 'rubygems'
require 'bundler/setup'

require 'pakyow'
require 'rdiscount'
require 'pygments'

require 'sass/plugin/rack'
Sass::Plugin.options[:template_location] = './resources/sass'
Sass::Plugin.options[:css_location] = './public/css'

require 'pp'

Pakyow::App.define do
  config.app.default_environment = :development

  configure(:development) do
    $stdout.sync = true
    $docs_path = 'docs'
  end

  configure(:test) do
    $docs_path = 'test/docs'
  end

  configure(:production) do
    $stdout.sync = true
    $docs_path = 'docs'
  end

  configure(:prototype) do
    app.ignore_routes = true
  end

  processor :md do |content|
    Formatter.format(content)
  end

  middleware do
    use Sass::Plugin::Rack
  end
end
