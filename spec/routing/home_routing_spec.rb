# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::HomeController, type: :routing do
  describe 'routing' do
    it 'routes get /' do
      expect(get: '/').to route_to(controller: 'home', action: 'index')
    end
  end
end
