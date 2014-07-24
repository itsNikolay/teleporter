require "bundler/gem_tasks"
require File.expand_path("../load_paths", __FILE__)

require 'rails'
require 'rails/generators'
require 'rails/generators/rails/app/app_generator'
require 'rails/application'
require 'fileutils'


task :default => :test

desc "Run all unit tests"
task :test => 'test:isolated'

namespace :test do
  task :isolated do
    dirs = (ENV["TEST_DIR"] || ENV["TEST_DIRS"] || "**").split(",")
    test_files = dirs.map { |dir| "test/#{dir}/*_test.rb" }
    Dir[*test_files].each do |file|
      next true if file.include?("fixtures")
      dash_i = [
        'test',
        'lib'
      ]
      ruby "-w", "-I#{dash_i.join ':'}", file
    end
  end
end


namespace :spec do
  task :prepare_app do
    ENV["RAILS_ENV"] = "test"

    rails4_original_app_path = (Pathname.pwd + 'spec/tmp/original_apps/rails4').to_s
    FileUtils.rm_rf([rails4_original_app_path])

    argv = ['new', rails4_original_app_path, '--skip-spring', '--skip-bundle']
    args = Rails::Generators::ARGVScrubber.new(argv).prepare!
    Rails::Generators::AppGenerator.start args
    Dir.chdir rails4_original_app_path

    IO.popen('bundle exec rake db:migrate').read
  end
end
