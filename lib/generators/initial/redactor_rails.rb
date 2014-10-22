module Initial
  class RedactorRailsGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem 'redactor-rails'
      gem "carrierwave"
      gem "mini_magick"

      Bundler.with_clean_env do
        run "bundle install"
      end

      @with_devise = ask 'Generate for devise? (y/n)'
      if @with_devise =~ /y/
        generate 'redactor:install --devise'
      else
        generate 'redactor:install'
      end

      rake 'db:migrate'

      append_to_file "app/assets/javascripts/application.js",
%Q{
//= require redactor-rails
//= require redactor-rails/config
//= require redactor-rails/langs/ru
}

      insert_into_file "app/assets/stylesheets/application.css",
%Q{
 *= require redactor-rails
}, after: "/*\n"


      generate 'redactor:config'

      insert_into_file "app/assets/javascripts/redactor-rails/config.js",
%Q{
       "lang":'ru',
}, after:
%Q{
      "path":"/assets/redactor-rails",
}
    end
  end
end
