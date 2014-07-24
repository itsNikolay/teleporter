require 'rspec'
require 'rails'
require 'rails/generators'
require 'rails/generators/rails/app/app_generator'
require 'rails/application'
require 'fileutils'

rails4_original_app_path = (Pathname.pwd + 'spec/tmp/original_apps/rails4').to_s
rails4_app_path = (Pathname.pwd + 'spec/tmp/test_apps/rails4').to_s


#original_wd = File.expand_path(Dir.pwd)
#
RSpec.configure do |c|

  c.mock_with :rspec

  c.before do
    FileUtils.rm_rf([rails4_app_path])
    FileUtils.cp_r rails4_original_app_path, rails4_app_path

    ENV["RAILS_ENV"] ||= "test"
    ENV["RAILS_ROOT"] ||= rails4_app_path
    require File.expand_path(rails4_app_path + "/config/environment.rb",  __FILE__)
    Dir.chdir(rails4_app_path)
  end
end

