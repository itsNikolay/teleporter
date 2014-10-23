namespace :deploy do
  task :prepare_nginx do
    on roles(:app) do
      execute :sudo, :rm, '/etc/nginx/sites-enabled/default'
      execute :sudo, '/etc/init.d/nginx restart'
    end
  end
end
