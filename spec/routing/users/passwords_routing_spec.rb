# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :routing do
  describe 'routing' do
    it 'routes get /users/password/new' do
      expect(get: '/users/password/new').to route_to(controller: 'users/passwords', action: 'new')
    end

    it 'routes post /users/password' do
      expect(post: '/users/password').to route_to(controller: 'users/passwords', action: 'create')
    end

    it 'routes put /users/password' do
      expect(put: '/users/password').to route_to(controller: 'users/passwords', action: 'update')
    end
  end
end
