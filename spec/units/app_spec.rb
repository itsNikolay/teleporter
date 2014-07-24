require "spec_helper"

describe "Test" do
  before {  }

  it "tests" do
    p Dir.pwd
    IO.popen('bundle exec rails g model Test').read
    IO.popen('bundle exec rake db:migrate').read

    expect('test').to eq 'test'
    expect(Test.new).to eq ''
  end
end
