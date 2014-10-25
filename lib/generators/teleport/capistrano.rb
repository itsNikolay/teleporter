module Teleport
  class CapistranoGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem_group :development do
        gem 'capistrano'
        gem 'capistrano-rbenv'
        gem 'capistrano-bundler'
        gem 'capistrano-rails'
        gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq'
        gem 'capistrano3-puma'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end

      directory 'capistrano/tasks', 'lib/capistrano/tasks'
      directory 'capistrano/shared', 'config/deploy/shared'

      run 'cap install'

      uncomment_lines 'Capfile', /require 'capistrano\/rbenv'/
      uncomment_lines 'Capfile', /require 'capistrano\/bundler'/
      uncomment_lines 'Capfile', /require 'capistrano\/rails\/assets'/
      uncomment_lines 'Capfile', /require 'capistrano\/rails\/migrations'/
      insert_into_file "Capfile",
                       "require 'capistrano/sidekiq'\n",
                       after: "require 'capistrano/rails/migrations'\n"
      insert_into_file "Capfile",
                       "require 'capistrano/puma'\n",
                       after: "require 'capistrano/sidekiq'\n"
      insert_into_file "Capfile",
                       "require 'capistrano/puma/monit'\n",
                       after: "require 'capistrano/sidekiq'\n"

      @app_name = ask 'App name:'
      @git_repo_url = ask 'Git repo (git@github.com:itsNikolay/puma-testing.git):'
      @deploy_user = ask 'Deploy username (deploy):'
      @ruby_version = ask 'Ruby version (2.1.2)'
      @production_server_address = ask 'Production server (192.168.33.10):'
      @add_staging = ask 'Add staging (y/n):'

      template 'capistrano/deploy/deploy.rb', 'config/deploy.rb'
      template 'capistrano/deploy/production.rb', 'config/deploy/production.rb'
      if @add_staging =~ /y/
        @staging_server_address = ask 'Staging server (192.168.33.10):'
        template 'capistrano/deploy/staging.rb', 'config/deploy/staging.rb'
      end

      p 'to setup server run: $ cap staging deploy:setup_config'
    end
  end
end
