require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  describe '#create' do
    before { @request.env["devise.mapping"] = Devise.mappings[:user] }

    context 'with valid params' do
      it 'return created' do
        user_params = FactoryBot.attributes_for(:user)
        
        expect{ post :create, params: { user: user_params } }.to change(User, :count).by(1)
        expect(response).to have_http_status(303)
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        user_params = FactoryBot.attributes_for(:user, email: '')

        expect{ post :create, params: { user: user_params } }.not_to change(User, :count)
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }

    before do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    context 'with valid params' do
      it 'return created' do
        user_params = FactoryBot.attributes_for(:user, 
                                                email: 'updated_eduardo@teste.com',
                                                password: 'newpassword',
                                                password_confirmation: 'newpassword',
                                                current_password: user.password)

        patch :update, params: { id: user.id, user: user_params }

        user.reload
        expect(user.email).to eq('updated_eduardo@teste.com')        
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        user_params = FactoryBot.attributes_for(:user,
                                                 email: 'updated_eduardo@teste.com',
                                                 password: 'newpassword',
                                                 password_confirmation: 'newpassword')

        patch :update, params: { id: user.id, user: user_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it 'teste' do  
      expect { delete :destroy }.to change(User, :count).by(-1)
    end
  end
end
