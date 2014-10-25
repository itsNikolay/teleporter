module Teleport
  class WelcomeGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      template 'welcome/welcome_controller.rb', 'app/controllers/welcome_controller.rb'
      template 'welcome/index.haml', 'app/views/welcome/index.haml'
      remove_comments 'config/routes.rb'
      route "root 'welcome#index'"
    end

    private
      def remove_comments(filename)
        gsub_file(filename, /^\s*#.*\n/, '')
      end
  end
end
