require_relative 'rspec_helpers'

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
  c.include RspecHelpers
end
