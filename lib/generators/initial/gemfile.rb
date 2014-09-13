module Initial
  class GemfileGenerator < Rails::Generators::Base
    def add_gems
      gem 'devise'
      gem 'cancancan'
      gem 'russian'
      gem 'sidekiq'
      gem 'puma'
      gem 'haml-rails'
      gem 'therubyracer'

      gem_group :development do
        gem 'quiet_assets'
        gem 'letter_opener'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end
    end
  end
end
