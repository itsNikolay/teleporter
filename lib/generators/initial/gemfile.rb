require "rails"
require 'rails/generators'
require 'bundler'

module Initial
  class GemfileGenerator < Rails::Generators::Base
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

      gem_group :production, :staging do
        gem 'unicorn'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end
    end
  end
end
