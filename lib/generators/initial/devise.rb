module Initial
  class DeviseGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem 'devise'
      gem 'cancancan'

      gem_group :development do
        gem 'letter_opener'
      end

      Bundler.with_clean_env do
        run "bundle install"
      end

      generate 'cancan:ability'
      generate 'devise:install'
      generate 'devise:views'

      insert_into_file "config/environments/development.rb", before: "end\n" do
%Q{
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :letter_opener

}
      end

      insert_into_file 'app/controllers/application_controller.rb', after: "protect_from_forgery with: :exception\n" do
%Q{
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

}
      end

      copy_file 'devise/devise.ru.yml', 'config/locales/devise.ru.yml'

      model = ask "Type MODEL to bootstrap devise:"
      generate "devise #{model}"
    end
  end
end
