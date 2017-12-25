# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  description :string
#


class Movie < ApplicationRecord
  MINIMUM_NUMBER_OF_IMAGES = 1

  belongs_to :user
  has_many :images, class_name: 'MovieImage', dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validate :minimum_number_of_images_validation

  private

  def minimum_number_of_images_validation
    return unless images.size < MINIMUM_NUMBER_OF_IMAGES

    errors.add(
      :images,
      I18n.translate('errors.messages.at_least_count_images', count: MINIMUM_NUMBER_OF_IMAGES)
    )
  end
end
