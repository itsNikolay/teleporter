namespace :deploy do
  task :prepare_nginx do
    on roles(:app) do
    begin
      execute :sudo, :rm, '/etc/nginx/sites-enabled/default'
    rescue Exception
    end
      execute :sudo, '/etc/init.d/nginx restart'
    end
  end
end
