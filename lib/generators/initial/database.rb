module Initial
  class DatabaseGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      @name = ask "Type the project's name"
      template 'database/database.yml', 'config/database.yml'
      template 'database/database.yml', 'config/database.yml.example'
    end
  end
end
