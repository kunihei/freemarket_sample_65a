Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.recapcha[:recapcha_public_key]
  config.secret_key = Rails.application.credentials.recapcha[:recapcha_private_key]
end