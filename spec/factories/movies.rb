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
