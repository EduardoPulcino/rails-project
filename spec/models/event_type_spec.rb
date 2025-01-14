require 'rails_helper'

RSpec.describe EventType do
  context 'create' do
    it 'success' do
      event_type = create(:event_type)

      expect(EventType.last.name).to eq('Rave')
    end
  end
end
