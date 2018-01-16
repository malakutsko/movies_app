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

require 'rails_helper'

RSpec.describe MovieImage, :type => :model do
  subject { create(:movie_image) }
end
