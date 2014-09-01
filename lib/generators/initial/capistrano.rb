module Initial
  class CapistranoGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem_group :development do
        gem 'capistrano'
        gem 'capistrano-rbenv'
        gem 'capistrano-bundler'
        gem 'capistrano-rails'
        gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq'
      end

      run "bundle install"

      directory 'capistrano/tasks', 'lib/capistrano/tasks'
      directory 'capistrano/shared', 'config/deploy/shared'

    end
  end
end
