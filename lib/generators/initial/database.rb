module Initial
  class DatabaseGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      copy_file 'database/database.yml', 'config/database.yml'
      copy_file 'database/database.yml', 'config/database.yml.example'
    end
  end
end
