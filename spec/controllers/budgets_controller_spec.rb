require 'rails_helper'

RSpec.describe BudgetsController do
  let(:user) { create(:user) }
  let(:event_type) { create(:event_type) }
  let(:decoration) { create(:decoration) }

  describe '#create' do
    context 'with valid data' do
      let(:budget) { FactoryBot.attributes_for(:budget,
                                                user_id: user.id,
                                                event_type_id: event_type.id,
                                                decoration_id: decoration.id) }

      context 'authorized' do
        it 'creates a budget successfully' do
          sign_in user

          expect{ post :create, params: { budget: budget } }.to change(Budget, :count).by(1)
          expect(response).to have_http_status(302)
        end
      end

      context 'unauthorized' do
        it 'does not create a budget' do
          expect{ post :create, params: { budget: budget } }.not_to change(Budget, :count)
        end
      end
    end

    context 'with invalid data' do
      let(:budget) { FactoryBot.attributes_for(:budget, event_type_id: '', decoration_id: decoration.id) }

      it 'does not create a budget' do
        sign_in user
        
        expect { post :create, params: { budget: budget } }.not_to change(Budget, :count)
      end
    end
  end

  describe '#update' do
    let!(:budget) { create(:budget, user_id: user.id,
                          event_type_id: event_type.id,
                          decoration_id: decoration.id) }

    let!(:budget_params) { FactoryBot.attributes_for(:budget,
                                                      user_id: user.id,
                                                      event_type_id: event_type.id,
                                                      decoration_id: decoration.id,
                                                      suggestion: 'Updated test') }

    context 'with valid data' do
      context 'when the current_user is the budget owner' do
        it 'update successfully' do
          sign_in user
  
          put :update, params: { id: budget.id, budget: budget_params }
  
          budget.reload
          expect(budget.suggestion).to eq('Updated test')
        end
      end

      context 'when current_user is not the budget owner' do  
        it 'does not delete budget' do
          user_not_allowed = create(:user, email: 'not-allowed@test.com', phone: '1109876543')
          sign_in user_not_allowed
  
          expect{ put :update, params: { id: budget.id, budget: } }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#destroy' do
    context 'when current_user is the budget owner' do
      let!(:budget) { create(:budget,
                            user_id: user.id,
                            event_type_id: event_type.id,
                            decoration_id: decoration.id) }

      it 'delete successfully' do
        sign_in user
  
        expect{ delete :destroy, params: { id: budget.id } }.to change(Budget, :count).by(-1)
      end
    end

    context 'when current_user is not the budget owner' do
      let!(:budget) { create(:budget,
                            user_id: user.id,
                            event_type_id: event_type.id,
                            decoration_id: decoration.id) }

      it 'raise not found error' do
        user_not_allowed = create(:user, email: 'not-allowed@test.com', phone: '1109876543')
        sign_in user_not_allowed

        expect{ delete :destroy, params: { id: budget.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#show' do
    let!(:budget) { create(:budget,
                            user_id: user.id,
                            event_type_id: event_type.id,
                            decoration_id: decoration.id) }

    context 'when current_user is budget owner' do
      it 'return 200' do
        sign_in user

        get :show, params: { id: budget.id }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when current_user is not the budget owner' do
      it 'does not show budget' do
        user_not_allowed = create(:user, email: 'not-allowed@test.com', phone: '1109876543')
        sign_in user_not_allowed

        expect{ get :show, params: { id: budget.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'index' do
    let!(:budget) { create(:budget,
                          user_id: user.id,
                          event_type_id: event_type.id,
                          decoration_id: decoration.id) }

    context 'when current user has budgets' do
      it 'return budgets' do
        sign_in user
        get :index

        expect(JSON.parse(response.body)).to match_array([budget.as_json])
      end
    end

    context 'when current user does not have budgets' do
      it 'returns an empty array' do
        user_test = create(:user, email: 'nobudget@test.com', phone: '1178918231')
        sign_in user_test

        get :index

        expect(JSON.parse(response.body)).to match_array([])
      end
    end
  end
end
