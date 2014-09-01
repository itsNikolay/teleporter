module Initial
  class RspecBaseGenerator < Rails::Generators::Base
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

      run "bundle install"

      generate 'rspec:install'

      template 'rspec_base/capybara.rb',         'spec/support/capybara.rb'
      template 'rspec_base/database_cleaner.rb', 'spec/support/database_cleaner.rb'
      template 'rspec_base/factory_girl.rb',     'spec/support/factory_girl.rb'
      template 'rspec_base/spec_helpers.rb',     'spec/support/spec_helpers.rb'
      template 'rspec_base/devise.rb',           'spec/support/devise.rb'

    end

  end
end
