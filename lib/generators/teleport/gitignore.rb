module Teleport
  class GitignoreGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      copy_file 'gitignore/gitignore', '.gitignore'
    end
  end
end
