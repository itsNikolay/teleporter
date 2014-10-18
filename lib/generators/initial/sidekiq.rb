module Initial
  class SidekiqGenerator < Rails::Generators::Base
    def add_gems
      gem 'sidekiq'
      gem 'sidetiq'

      Bundler.with_clean_env do
        run "bundle install"
      end

      copy_file 'sidekiq/_sidekiq_example_worker.rb',
                'app/workers/_sidekiq_example_worker.rb'
      copy_file 'sidekiq/_sidetiq_example_worker.rb',
                'app/workers/_sidetiq_example_worker.rb'


      prepend_to_file "app/config/routes.rb",
                       %q{
require 'sidekiq/web'
require 'sidetiq/web'
                         }

                         route %q{
  mount Sidekiq::Web => '/sidekiq'
                         }
    end
  end
end
