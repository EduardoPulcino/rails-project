require 'rails_helper'

RSpec.describe Review do
  context '#create' do
    it 'with valid data' do
      review = create(:review)

      expect(Review.last.customer_name).to eq('Eduardo')
    end

    it 'with invalid data' do
      review = build(:review, customer_name: nil)

      expect{ review.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end