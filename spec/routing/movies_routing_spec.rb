# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::MoviesController, type: :routing do
  describe 'routing' do
    it 'routes get /movies' do
      expect(get: '/movies').to route_to(controller: 'movies', action: 'index')
    end

    it 'routes get /movies/id' do
      expect(get: '/movies/id').to route_to(controller: 'movies', action: 'show', id: 'id')
    end

    it 'routes post /movies' do
      expect(post: '/movies').to route_to(controller: 'movies', action: 'create')
    end

    it 'routes get /movies/id/edit' do
      expect(get: '/movies/id/edit').to route_to(controller: 'movies', action: 'edit', id: 'id')
    end

    it 'routes patch /movies/id' do
      expect(patch: '/movies/id').to route_to(controller: 'movies', action: 'update', id: 'id')
    end

    it 'routes delete /movies/id' do
      expect(delete: '/movies/id').to route_to(controller: 'movies', action: 'destroy', id: 'id')
    end
  end
end
