require "rails"
require 'rails/generators'
require 'bundler'

module Admin
  class MainGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    argument :template, type: :string, default: "default"

    def add
      generate 'inital:gemfile'
      generate 'inital:rspec_base'
    end
  end
end
