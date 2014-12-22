namespace :deploy do
  task :setup_db do

    on roles(:app) do
      db_adapter = ask1 %Q{ Choose database adapter:
1. postgresql
2. mysql2 }

      db_adapter = case db_adapter
                   when /1/
                     'postgresql'
                   when /2/
                     'mysql2'
                   end


      ask(:db_password, 'Type database password:')

      database_content = %Q{#{fetch(:rails_env)}:
  adapter: #{db_adapter}
  timeout: 5000
  encoding: utf8
  reconnect: false
  database: #{fetch(:application)}_#{fetch(:stage)}
  pool: 5
  username: #{fetch(:deploy_user)}
  password: #{fetch(:db_password)}
  host:
  port: 5432
  }


  database_content = StringIO.new(database_content)
  upload! database_content, "#{shared_path}/config/database.yml"

    begin
      execute :whoami
      execute %Q{echo "CREATE ROLE #{fetch(:deploy_user)} PASSWORD '#{fetch(:db_password)}' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;" | sudo -u postgres psql}
    rescue Exception
    end
    begin
      execute :sudo, '/etc/init.d/postgresql restart'
      sleep 3
    rescue Exception
    end
    begin
      execute %Q{echo "CREATE DATABASE #{fetch(:application)}_#{fetch(:stage)} WITH OWNER #{fetch(:deploy_user)} ENCODING 'UTF8';" | sudo -u postgres psql}
    rescue Exception
    end
    end
  end
end

def ask1(question)
  puts question
  $stdin.gets.chomp
end
