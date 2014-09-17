Devise.setup do |config|
  secrets = Rails.application.secrets
  config.omniauth :facebook,      secrets.fb_app, secrets.fb_key
  config.omniauth :vkontakte,     secrets.vk_app, secrets.vk_key
  config.omniauth :odnoklassniki, secrets.ok_app, secrets.ok_key, public_key: secrets.ok_pkey
end
