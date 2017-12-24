# frozen_string_literal: true

Aws.config.update(region: Rails.application.secrets.s3_region,
                  credentials: Aws::Credentials.new(Rails.application.secrets.s3_access_key_id,
                                                    Rails.application.secrets.s3_access_key_secret))

S3_BUCKET = Aws::S3::Resource.new.bucket(Rails.application.secrets.s3_bucket_name)
