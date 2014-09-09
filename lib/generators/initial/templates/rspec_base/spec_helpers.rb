module SpecHelpers
  def screen
    page.save_screenshot('/tmp/file.png')
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end
