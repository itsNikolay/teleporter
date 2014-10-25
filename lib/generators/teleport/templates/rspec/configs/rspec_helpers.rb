module RspecHelpers

  # Usage:
  # json(response.body)
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end
