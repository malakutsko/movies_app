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
#

class MovieImage < ApplicationRecord
  belongs_to :movie

  mount_uploader :attachment, MovieImageUploader
end
