require "spec_helper"
require "generators/initial"

describe InitializerGenerator do
  before { p IO.popen('bundle exec rails generate initializer').read }

  it "tests" do
    is_file = File.exist?('config/initializers/initializer.rb')
    expect(is_file).to be_truthy
  end
end
