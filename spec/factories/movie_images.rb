# frozen_string_literal: true
# == Schema Information
#
# Table name: movie_images
#
#  id                      :integer          not null, primary key
#  movie_id                :integer
#  attachment              :string
#  attachment_content_type :string
#  attachment_file_name    :string
#  attachment_file_size    :string
#  primary                 :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#


FactoryGirl.define do
  factory :movie_image do
    movie
    attachment {
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'attachments', 'sample_image.png'), 'image/png')
    }
  end
end
