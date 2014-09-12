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

      Bundler.with_clean_env do
        run "bundle install"
      end

      directory 'capistrano/tasks', 'lib/capistrano/tasks'
      directory 'capistrano/shared', 'config/deploy/shared'

      template "capistrano/lib/substitute_strings.rb", "lib/capistrano/substitute_strings.rb"
      template "capistrano/lib/template.rb", "lib/capistrano/template.rb"

      run 'cap install'

      uncomment_lines 'Capfile', /require 'capistrano\/rbenv'/
      uncomment_lines 'Capfile', /require 'capistrano\/bundler'/
      uncomment_lines 'Capfile', /require 'capistrano\/rails\/assets'/
      uncomment_lines 'Capfile', /require 'capistrano\/rails\/migrations'/
      insert_into_file "Capfile", "require 'capistrano/sidekiq'\n",
                       after: "require 'capistrano/rails/migrations'\n"


      append_to_file 'config/deploy.rb' do
        <<-EOT
set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=\#{fetch(:rbenv_path)} RBENV_VERSION=\#{fetch(:rbenv_ruby)} \#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set(:config_files, %w(
  nginx.conf
  application.yml
  database.example.yml
  log_rotation
  monit
  monit_sidekiq
  unicorn.rb
  unicorn_init.sh
  sidekiq_init.sh
))
set(:executable_config_files, %w(
  unicorn_init.sh
  sidekiq_init.sh
))
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{full_app_name}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_{{full_app_name}}"
  },
  {
    source: "log_rotation",
    link: "/etc/logrotate.d/{{full_app_name}}"
  },
  {
    source: "monit",
    link: "/etc/monit/conf.d/{{full_app_name}}.conf"
  },
  {
    source: "monit_sidekiq",
    link: "/etc/monit/conf.d/sidekiq_{{full_app_name}}.conf"
  },
  {
    source: "sidekiq_init.sh",
    link: "/etc/init.d/sidekiq_{{full_app_name}}"
  }
])
namespace :deploy do
  desc 'Normalize asset timestamps'
  task migr: fetch(:stage)  do
    on roles(:app) do
      within release_path do
        execute :rake, "migrate:users", "RAILS_ENV=\#{fetch(:stage)}"
      end
    end
  end
end

namespace :deploy do
  task clear_cache: fetch(:stage) do
    on roles(:app) do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end
end

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  # compile assets locally then rsync
  #after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
  after :finishing, 'deploy:clear_cache'
  #after :finishing, 'sidekiq:restart'
  #after :finishing, 'deploy:migr'
end

        EOT
      end

      append_to_file 'config/deploy/production.rb' do
      <<-EOT
set :stage, :production
set :branch, "master"

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths
set :full_app_name, "\#{fetch(:application)}_\#{fetch(:stage)}"

server '95.85.33.125', user: 'deploy', roles: %w{web app db}, primary: true

set :deploy_to, "/home/\#{fetch(:deploy_user)}/apps/\#{fetch(:full_app_name)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :production

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 2

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false
      EOT
      end

      p '*****'
      p 'config application name in config/deploy.rb'
      p 'config git repo path in config/deploy.rb'
      p 'remove default deploy:start task in config/deploy.rb'
      p 'remove default examples in config/production/deploy.rb'
    end
  end
end
