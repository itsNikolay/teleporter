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

      copy_file 'capistrano/deploy/deploy.rb', 'config/deploy.rb'
      copy_file 'capistrano/deploy/production.rb', 'config/deploy/production.rb'

    end
  end
end
