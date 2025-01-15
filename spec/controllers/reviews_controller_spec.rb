require 'rails_helper'

RSpec.describe ReviewsController do
  let(:event_type) { create(:event_type) }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:review_params) { attributes_for(:review, event_type_id: event_type.id) }

  describe '#create' do
    context 'when current user is admin' do
      it 'creates a review successfully' do
        sign_in admin
        
        expect {
          post :create, params: { review: review_params }
        }.to change(Review, :count).by(1)
      end
    end

    context 'when current user is not admin' do
      it 'does not create a review' do
        sign_in user

        expect {
          post :create, params: { review: review_params }
        }.not_to change(Review, :count)
      end
    end
  end

  describe '#update' do
    let(:review) { create(:review) }
    let(:review_update_params) { attributes_for(:review, customer_name: 'John', event_type_id: event_type.id) }

    it 'updates a review successfully' do
      sign_in admin

      put :update, params: { id: review.id, review: review_update_params }
      review.reload

      expect(review.customer_name).to eq('John')
    end

    context 'when current user is not admin' do
      it 'does not allow update' do
        sign_in user

        put :update, params: { id: review.id, review: review_update_params }
        review.reload

        expect(review.customer_name).not_to eq('John')
      end
    end
  end

  describe '#destroy' do
    let!(:review) { create(:review) }

    it 'deletes a review successfully' do
      sign_in admin

      expect {
        delete :destroy, params: { id: review.id }
      }.to change(Review, :count).by(-1)
    end

    context 'when current user is not admin' do
      it 'does not delete a review' do
        sign_in user

        expect {
          delete :destroy, params: { id: review.id }
        }.not_to change(Review, :count)
      end
    end
  end

  describe '#show' do
    let!(:review) { create(:review) }

    it 'returns the review' do
      get :show, params: { id: review.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe '#index' do
    let!(:review) { create(:review) }

    it 'returns reviews' do
      get :index, format: :json

      expect(JSON.parse(response.body)).to include(review.as_json)
    end
  end
end
