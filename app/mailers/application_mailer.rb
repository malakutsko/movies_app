class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.smtp_address
  layout 'mailer'
end
