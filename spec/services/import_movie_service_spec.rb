# frozen_string_literal: true

require 'rails_helper'
require 'support/vcr'

RSpec.describe ImportMovieService do
  let(:user) { create(:user) }
  let(:movie_name) { 'The Lord of The Rings' }

  describe 'call' do
    context 'valid omdb api response' do
      it 'imports movie and returns persisted record' do
        movie = VCR.use_cassette(:omdb_search_by_name) do
          ImportMovieService.new(name: movie_name, user: user).call
        end

        expect(movie).to be_persisted
      end
    end

    context 'not valid omdb api response' do
      it 'returns nil' do
        movie = VCR.use_cassette(:omdb_search_by_invalid_name) do
          ImportMovieService.new(name: "This name doesn't exist in omdb db", user: user).call
        end

        expect(movie).to be_nil
      end
    end
  end
end
