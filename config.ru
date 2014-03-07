require File.expand_path('../app', __FILE__)
Pakyow::App.builder.run(Pakyow::App.stage(ENV['RACK_ENV'] || :production))
run Pakyow::App.builder.to_app
