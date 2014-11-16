module Teleport
  class CapistranoGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem_group :development do
        gem 'capistrano'
        gem 'capistrano-rbenv'
        gem 'capistrano-bundler'
        gem 'capistrano-rails'
        gem 'capistrano-sidekiq'
        gem 'capistrano3-puma', github: 'itsNikolay/capistrano-puma', branch: 'puma_monit_namespace'
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
                       %Q{
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/jungle'
require 'capistrano/puma/monit'
require 'capistrano/puma/nginx'
                       },
                       after: "require 'capistrano/sidekiq'\n"

      @app_name = ask 'App name', :bold, default: 'blog'
      @git_repo_url = ask 'Git repo', :bold, default: 'git@github.com:itsNikolay/puma-testing.git'
      @deploy_user = ask 'Deploy username default', :bold, default: 'deploy'
      @ruby_version = ask 'Ruby version', :bold, limited_to: ['2.1.5', '2.1.4', '2.1.3', '2.1.2', '1.9.3']
      @production_server_address = ask 'Production server', :bold, default: '192.X.X.X'

      template 'capistrano/deploy/deploy.rb', 'config/deploy.rb'
      template 'capistrano/deploy/production.rb', 'config/deploy/production.rb'
      if yes?('Add staging? (y/n)')
        @staging_server_address = ask 'Staging server', :bold, default: '192.X.X.X'
        template 'capistrano/deploy/staging.rb', 'config/deploy/staging.rb'
      end

      say 'to setup server run: $ cap staging deploy:setup_config', :bold
    end
  end
end
