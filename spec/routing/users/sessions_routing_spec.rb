# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :routing do
  describe 'routing' do
    it 'routes get /users/sign_in' do
      expect(get: '/users/sign_in').to route_to(controller: 'users/sessions', action: 'new')
    end

    it 'routes post /users/sign_in' do
      expect(post: '/users/sign_in').to route_to(controller: 'users/sessions', action: 'create')
    end

    it 'routes delete /users/sign_out' do
      expect(delete: '/users/sign_out').to route_to(controller: 'users/sessions', action: 'destroy')
    end
  end
end
