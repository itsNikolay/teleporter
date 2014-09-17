require "rails"
require 'rails/generators'
require 'bundler'
require "teleporter/version"

require "generators/initial/start"
require "generators/initial/gemfile"
require "generators/initial/rspec"
require "generators/initial/welcome"
require "generators/initial/capistrano"
require "generators/initial/bootstrap"
require "generators/initial/devise"
require "generators/initial/devise_oauth"
require "generators/initial/gitignore"
require "generators/initial/database"

require "generators/admin/start"
