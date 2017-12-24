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
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
end
