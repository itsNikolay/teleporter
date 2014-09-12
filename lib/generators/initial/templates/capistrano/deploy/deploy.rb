lock '3.2.1'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:itsNikolay/puma-testing.git'
set :deploy_user, 'deploy'

set :puma_init_active_record, true

set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set(:config_files, %w(
  nginx.conf
  application.yml
  database.example.yml
  log_rotation
  monit
  monit_sidekiq
  puma.conf
  puma
  run-puma
  sidekiq_init.sh
  secrets.yml
))
set(:executable_config_files, %w(
  puma
  run-puma
  sidekiq_init.sh
))
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{full_app_name}}"
  },
  {
    source: "puma",
    link: "/etc/init.d/puma"
  },
  {
    source: "run-puma",
    link: "/usr/local/bin/run-puma"
  },
  {
    source: "puma.conf",
    link: "/etc/puma.conf"
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
  },
])
namespace :deploy do
  desc 'Normalize asset timestamps'
  task migr: fetch(:stage)  do
    on roles(:app) do
      within release_path do
        execute :rake, "migrate:users", "RAILS_ENV=#{fetch(:stage)}"
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

