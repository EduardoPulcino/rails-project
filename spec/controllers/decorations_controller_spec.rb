require 'rails_helper'

RSpec.describe DecorationsController do
  let(:event_type) { create(:event_type) }
  let(:decoration_params) { attributes_for(:decoration, event_type_id: event_type.id) }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }


  describe '#create' do
    context 'when current user is admin' do
      it 'create successfully' do
        sign_in admin
        
        expect{ post :create, params: { decoration: decoration_params }  }.to change(Decoration, :count).by(1)
      end
    end

    context 'when current user is not admin' do
      it 'does not create' do
        sign_in user

        expect{ post :create, params: { decoration: decoration_params }  }.not_to change(Decoration, :count)
      end
    end
  end

  describe '#update' do
    let(:decoration) { create(:decoration) }
    let(:decoration_update_params) { attributes_for(:decoration, name: 'Christmas', event_type_id: event_type.id) }

    it 'updates successfully' do
      sign_in admin

      put :update, params: { id: decoration.id, decoration: decoration_update_params  }
      decoration.reload

      expect(decoration.name).to eq('Christmas')
    end
  end

  describe '#destroy' do
    let!(:decoration) { create(:decoration) }

    it 'delete successfully' do
      sign_in admin

      expect{ delete :destroy, params: { id: decoration.id } }.to change(Decoration, :count).by(-1)
    end
  end

  describe '#show' do
    let!(:decoration) { create(:decoration) }

    it 'delete successfully' do
      get :show, params: { id: decoration.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe '#index' do
    let!(:decoration) { create(:decoration) }

    it 'return decoration' do
      get :index, format: :json

      expect(JSON.parse(response.body)).to include(decoration.as_json)
    end
  end

  describe '#by_event_type_id' do
    let!(:decoration) { create(:decoration, event_type_id: event_type.id) }
    let!(:second_decoration) { create(:decoration, event_type_id: event_type.id) }
    let!(:third_decoration) { create(:decoration, event_type_id: event_type.id) }

    it 'returns decorations by event type id' do
      get :by_event_type_id, params: { event_type_id: event_type.id }
      binding.pry
      expect(JSON.parse(response.body)).to match_array([
                                                        decoration.as_json,
                                                        second_decoration.as_json,
                                                        third_decoration.as_json
                                                        ])
    end
  end
end
