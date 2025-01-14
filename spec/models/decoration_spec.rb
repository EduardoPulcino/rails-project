require 'rails_helper'

RSpec.describe Decoration do
  context 'create' do
    let(:decoration) { create(:decoration) }

    it 'success' do
      expect(decoration.photo).to be_attached
    end

    it '.find_by_event_type_id' do     
      event_type_id = decoration.event_type.id

      result = Decoration.find_by_event_type_id(event_type_id)

      expect(result).to include(decoration) 
    end
  end
end
