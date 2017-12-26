# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe "GET index" do
    let(:user) { create(:user) }
    let!(:movie) { create(:movie_with_images, user: user) }

    context 'for not authenticated user' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'for authenticated user' do
      it 'returns http success' do
        login_as user, scope: :user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
