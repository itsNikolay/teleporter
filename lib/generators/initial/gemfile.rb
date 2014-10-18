module Initial
  class GemfileGenerator < Rails::Generators::Base
    def add_gems
      gem 'russian'
      gem 'puma'
      gem 'haml-rails'
      gem 'therubyracer'

      gem_group :development do
        gem 'quiet_assets'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end
      insert_into_file "config/application.rb", before: "  end\nend\n" do
%Q{
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru

}
      end
    end
  end
end
