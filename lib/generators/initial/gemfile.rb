module Initial
  class GemfileGenerator < Rails::Generators::Base
    def add_gems
      gem 'russian'
      gem 'sidekiq'
      gem 'puma'
      gem 'haml-rails'
      gem 'therubyracer'

      gem_group :development do
        gem 'quiet_assets'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end
    end
  end
end
