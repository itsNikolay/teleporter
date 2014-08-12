require "rails"
require 'rails/generators'
require 'bundler'

module Admin
  class MainGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    argument :template, type: :string, default: "default"

    def add_gems
      gem 'devise'
      gem 'cancancan'
      gem 'russian'
      gem 'sidekiq'
      gem 'haml-rails'

      gem_group :development do
        gem 'capistrano'
        gem 'capistrano-rbenv'
        gem 'capistrano-bundler'
        gem 'capistrano-rails'
        gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq'
        gem 'quiet_assets'
        gem "letter_opener"
      end

      gem_group :development, :test do
        gem "rspec-rails"
      end

      gem_group :test do
        gem 'factory_girl_rails'
        gem 'capybara'
        gem 'database_cleaner'
        gem 'shoulda-matchers'
        gem 'poltergeist'
        gem 'phantomjs', require: 'phantomjs/poltergeist'
        gem 'vcr'
        gem 'webmock'
      end

      gem_group :production, :staging do
        gem 'unicorn'
      end
      Bundler.with_clean_env do
        run "bundle install"
      end
    end
  end
end
