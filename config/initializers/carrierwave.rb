# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.secrets.s3_access_key_id,
      aws_secret_access_key: Rails.application.secrets.s3_access_key_secret,
      region:                Rails.application.secrets.s3_region,
      host:                  Rails.application.secrets.s3_host
    }
    config.storage = :fog
    config.fog_directory = Rails.application.secrets.s3_bucket_name
    config.fog_public = false
    config.fog_attributes = {
      expires: 1.year.from_now.httpdate,
      cache_control: 'max-age=31536000'
    }
  end
end
