require 'rails_helper'

RSpec.describe Budget do
  context 'create' do
    let(:user) { create(:user) }

    context 'with valid data' do
      it 'success' do
        budget = create(:budget)
  
        expect(Budget.last.user.name).to eq('Eduardo')
      end
    end

    context 'with invalid data' do
      it 'with invalid event_date' do
        budget = build(:budget, :with_invalid_event_date)
  
        expect{ budget.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
  
      it 'with invalid guest_count' do
        budget = build(:budget, :with_invalid_guest_count)
  
        expect{ budget.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
  
      it 'with invalid data' do
        budget = build(:budget, :with_invalid_data)
  
        expect{ budget.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
