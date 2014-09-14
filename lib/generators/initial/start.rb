module Initial
  class StartGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    argument :template, type: :string, default: "default"

    def add
      generate 'initial:gemfile'
      generate 'initial:gitignore'
      generate 'initial:database'
      generate 'initial:welcome'
      generate 'initial:rspec'
      generate 'initial:capistrano'
      generate 'initial:bootstrap'
      generate 'initial:devise'
    end
  end
end
