module Initial
  class RspecGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem_group :development, :test do
        gem "rspec-rails"
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
      end

      generate 'rspec:install'

      template 'rspec/configs/capybara.rb',         'spec/support/configs/capybara.rb'
      template 'rspec/configs/database_cleaner.rb', 'spec/support/configs/database_cleaner.rb'
      template 'rspec/configs/factory_girl.rb',     'spec/support/configs/factory_girl.rb'
      template 'rspec/configs/devise.rb',           'spec/support/configs/devise.rb'
      template 'rspec/configs/vcr.rb',              'spec/support/configs/vcr.rb'

      template 'rspec/shared_examples/sample_shared.rb', 'spec/support/shared_examples/sample_shared.rb'

      run 'bundle exec spring binstub rspec'

    end

  end
end
