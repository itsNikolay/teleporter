module Teleport
  module Bootstrap
    class NavbarGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def add
        @path = ask 'Path for _navbar.haml', :bold, default: 'app/views/layouts/_navbar.haml'
        copy_file '_navbar.haml', @path
      end
    end
  end
end
