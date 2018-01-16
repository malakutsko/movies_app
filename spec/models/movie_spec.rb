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

require 'rails_helper'

RSpec.describe Movie, :type => :model do
  subject { create(:movie_with_images) }

  describe "Validations" do
    let(:movie_without_images) { create(:movie) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    it 'validates at least one attachment' do
      expect(movie_without_images).to_not be_valid
      expect(movie_without_images.errors.messages[:images]).to eq(
        [I18n.translate('errors.messages.at_least_count_images', count: Movie::MINIMUM_NUMBER_OF_IMAGES)]
      )
    end
  end
end
