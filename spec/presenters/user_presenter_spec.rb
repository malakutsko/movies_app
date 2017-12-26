# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPresenter do
  let(:user) { create(:user) }
  subject { described_class.new(user) }

  describe '#full_name' do
    it 'returns full name of the user' do
      expect(subject.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
