# frozen_string_literal: true

class S3PresignPost
  def initialize(key:, content_type:)
    @key = key
    @content_type = content_type
  end

  def call
    S3_BUCKET.presigned_post(
      key: @key,
      success_action_status: '201',
      acl: 'public-read',
      content_type: @content_type
    )
  end
end
