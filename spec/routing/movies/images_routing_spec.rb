# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::ImagesController, type: :routing do
  describe 'routing' do
    it 'routes post /movies/movie_id/images' do
      expect(post: '/movies/movie_id/images').to route_to(
        controller: 'movies/images', action: 'create', movie_id: 'movie_id')
    end

    it 'routes delete /movies/movie_id/images/id' do
      expect(delete: '/movies/movie_id/images/id').to route_to(
        controller: 'movies/images', action: 'destroy', id: 'id', movie_id: 'movie_id')
    end
  end
end
