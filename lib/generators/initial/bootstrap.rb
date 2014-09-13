module Initial
  class BootstrapGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem 'bootstrap-sass'
      gem 'kaminari-bootstrap'
      gem 'bh'
      gem 'autoprefixer-rails'

      Bundler.with_clean_env do
        run "bundle install"
      end

      copy_file 'bootstrap/bootstrap-base.scss',
                'app/assets/stylesheets/shared/bootstrap-base.scss'
      insert_into_file "app/assets/stylesheets/application.css",
                       "*= require shared/bootstrap_base\n",
                       after: "/*\n"
      prepend_to_file "app/assets/javascripts/application.js",
                       "//= require bootstrap\n"

    end
  end
end
