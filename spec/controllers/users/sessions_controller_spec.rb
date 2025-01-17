require 'rails_helper'

RSpec.describe Users::SessionsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  let(:user) { create(:user, email: 'user@example.com', password: 'password') }

  describe '#create' do
    context 'when user is persisted' do
      it 'login successfully' do
        post :create, params: { user: { email: user.email, password: 'password' } }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when credentials is invalid' do
      it 'does not login' do
        post :create, params: { user: { email: user.email, password: 'wrongpassword' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    context 'when user is logged in' do
      it 'session is destroyed' do
        sign_in user

        delete :destroy

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
