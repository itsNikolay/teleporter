namespace :deploy do
  desc 'Run rake task'
  task :run_rake_task do
    on roles(:app) do
      ask(:rake_task, 'Type a rake task (db:seed)')

      within release_path do
        execute :rake, "#{fetch(:rake_task)}", "RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end
end
