module Initial
  class ApiGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      begin
        gem 'jbuilder'
      rescue
        nil
      end

      Bundler.with_clean_env do
        run "bundle install"
      end

      copy_file 'api/v1/base_controller.rb', 'app/controllers/api/v1/base_controller.rb'

      @model_name = ask 'Type model name (ex.: Post)'
      template 'api/v1/posts_controller.rb', "app/controllers/api/v1/#{@model_name.pluralize.underscore}_controller.rb"

      route %Q{
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      resources :#{@model_name.pluralize.underscore}, only: :index
    end
  end
      }

      copy_file 'api/views/index.json.jbuilder', "app/views/api/v1/#{@model_name.underscore}/index.json.jbuilder"

      p 'for rspec use'
      p 'before(:each) { request.host = "api.example.com" }'
    end
  end
end
