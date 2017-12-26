# frozen_string_literal: true

class S3PresignPost
  def initialize(path:, content_type:)
    @path = path
    @content_type = content_type
  end

  def call
    S3_BUCKET.presigned_post(
      key: @path,
      success_action_status: '201',
      acl: 'public-read',
      content_type: @content_type
    )
  end
end
