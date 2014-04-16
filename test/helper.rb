require 'rubygems'
gem 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'turn/autorun'
require 'pp'

require File.join(File.dirname(__FILE__), '../app')
Pakyow::App.stage(ENV['ENV'])
