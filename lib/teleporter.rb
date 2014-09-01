require "rails"
require 'rails/generators'
require 'bundler'
require "teleporter/version"

require "generators/initial/start"
require "generators/initial/gemfile"
require "generators/initial/rspec_base"
require "generators/initial/welcome"
require "generators/initial/capistrano"

require "generators/admin/start"

