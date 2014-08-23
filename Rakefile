require "bundler/gem_tasks"
require 'open-uri'

task :release do
  sh "gem push teleporter-#{Teleporter::VERSION}.gem"
end
