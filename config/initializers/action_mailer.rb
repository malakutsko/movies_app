# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  authentication: :plain,
  enable_starttls_auto: true,
  user_name: Rails.application.secrets.smtp_address,
  password: Rails.application.secrets.smtp_password
}

ActionMailer::Base.default from: "MoviesApp <#{Rails.application.secrets.smtp_address}>"
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.delivery_method = if Rails.env.test?
                                       :test
                                     elsif Rails.env.development?
                                       :letter_opener
                                     else
                                       :smtp
                                     end
