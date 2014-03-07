require 'rubygems'
require 'bundler/setup'

require 'pakyow'
require 'rdiscount'
require 'pygments'

require 'sass/plugin/rack'
Sass::Plugin.options[:template_location] = './resources/sass'
Sass::Plugin.options[:css_location] = './public/css'

require 'pp'
require 'json'

Pakyow::App.after(:load) {
  Docs.load
}

Pakyow::App.define do
  config.app.default_environment = :development

  configure(:development) do
    $stdout.sync = true
    $docs_path = 'docs'

    $uri_prefix = ''
  end

  configure(:test) do
    $docs_path = 'test/docs'
  end

  configure(:production) do
    $stdout.sync = true
    $docs_path = 'docs'
    $uri_prefix = '/docs'

    app.auto_reload = false
    app.static = false
    app.errors_in_browser = false

    logger.path = '../../shared/log'

    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
  end

  configure(:prototype) do
    app.ignore_routes = true
  end

  processor :md do |content|
    Formatter.format(content)
  end

  middleware do |builder|
    builder.use Sass::Plugin::Rack
  end
end
