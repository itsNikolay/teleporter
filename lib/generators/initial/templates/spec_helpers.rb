Rspec.confiure do |config|
  config.include SpecHelper
end

module SpecHelpers
  def screen
    page.save_screenshot('/tmp/file.png')
  end
end
