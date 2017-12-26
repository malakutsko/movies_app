# frozen_string_literal: true
# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Movie < ApplicationRecord
  MINIMUM_NUMBER_OF_IMAGES = 1

  belongs_to :user
  has_many :images, class_name: 'MovieImage', dependent: :destroy
  has_one :primary_image, -> { limit(1).order(created_at: :asc) }, class_name: 'MovieImage'

  validates :name, presence: true
  validates :description, presence: true
  validate :minimum_number_of_images_validation

  scope :recent, -> { order(created_at: :desc).limit(10) }

  private

  def minimum_number_of_images_validation
    return unless images.size < MINIMUM_NUMBER_OF_IMAGES

    errors.add(
      :images,
      I18n.translate('errors.messages.at_least_count_images', count: MINIMUM_NUMBER_OF_IMAGES)
    )
  end
end
