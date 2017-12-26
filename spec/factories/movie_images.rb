# frozen_string_literal: true

FactoryGirl.define do
  factory :movie_image do
    movie
    attachment {
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'attachments', 'sample_image.png'), 'image/png')
    }
  end
end
