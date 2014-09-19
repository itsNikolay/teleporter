module Initial
  class RspecGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem_group :development, :test do
        gem "rspec-rails"
        gem 'spring'
        gem 'spring-commands-rspec'
      end

      gem_group :test do
        gem 'factory_girl_rails'
        gem 'capybara'
        gem 'database_cleaner'
        gem 'shoulda-matchers'
        gem 'poltergeist'
        gem 'phantomjs', require: 'phantomjs/poltergeist'
        gem 'vcr'
        gem 'webmock'
      end

      Bundler.with_clean_env do
        run "bundle install"
        run 'bundle exec spring binstub rspec'
      end

      generate 'rspec:install'

      directory 'rspec/configs', 'spec/support/configs'
      directory 'rspec/factories', 'spec/factories'
      directory 'rspec/shared_examples', 'spec/support/shared_examples'
    end

  end
end
