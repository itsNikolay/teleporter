require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir     = "spec/cassettes"
  c.hook_into                :webmock
  c.configure_rspec_metadata!
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end

# Usage:
# it 'sends request', :vcr do
#   . . .
# end
