# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  description  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  release_year :string
#

FactoryGirl.define do
  factory :movie do
    user
    name        { Faker::Movie.quote }
    description { Faker::Lorem.paragraph }

    to_create { |instance| instance.save(validate: false) }
  end

  factory :movie_with_images, parent: :movie do
    images { build_list :movie_image, 3 }
  end
end
