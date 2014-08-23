module Initial
  class StartGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    argument :template, type: :string, default: "default"

    def add
      generate 'initial:gemfile'
      generate 'initial:rspec_base'
    end
  end
end
