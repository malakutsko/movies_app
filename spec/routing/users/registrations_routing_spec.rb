# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :routing do
  describe 'routing' do
    it 'routes get /users/sign_up' do
      expect(get: '/users/sign_up').to route_to(controller: 'users/registrations', action: 'new')
    end

    it 'routes post /users' do
      expect(post: '/users').to route_to(controller: 'users/registrations', action: 'create')
    end

    it 'routes get /users/edit' do
      expect(get: '/users/edit').to route_to(controller: 'users/registrations', action: 'edit')
    end

    it 'routes put /users' do
      expect(put: '/users').to route_to(controller: 'users/registrations', action: 'update')
    end

    it 'routes delete /users' do
      expect(delete: '/users').to route_to(controller: 'users/registrations', action: 'destroy')
    end
  end
end
