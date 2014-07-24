require "rails"
require 'rails/generators'

class InitGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/initializer.rb"
  end
end
