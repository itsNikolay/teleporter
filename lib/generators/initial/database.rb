module Initial
  class DatabaseGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      @name = ask "Type the project's name"
      @username = ask 'Type database username'
      @password = ask 'Type database password'
      template 'database/database.yml', 'config/database.yml'
      template 'database/database.yml', 'config/database.yml.example'
      create_db = ask 'Create database?'
      rake('db:create') if create_db =~ /y/
    end
  end
end
