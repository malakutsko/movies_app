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

class MovieImage < ApplicationRecord
  belongs_to :movie, optional: true

  mount_uploader :attachment, MovieImageUploader, mount_on: :attachment_file_name

  def key
    attachment.store_path.to_s + attachment_file_name.to_s
  end
end
