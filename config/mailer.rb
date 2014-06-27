ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.view_paths = File.expand_path('../../app/views/', __FILE__)
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  authentication: :login,
  address: "email-smtp.us-east-1.amazonaws.com",
  user_name: ENV["AWS_USER"],
  password:  ENV["AWS_PSWD"],
  enable_starttls_auto: true,
  port: 587,
  domain: "master-bolsa.com.br"
}
