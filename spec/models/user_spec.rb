require 'rails_helper'

RSpec.describe User do
	context '#create' do
		context 'with valid data' do
			it 'return success' do
				user = create(:user)

				expect(user.name).to eq('Eduardo')
			end

			it 'attach photo successful' do
				user = create(:user, :with_photo)

				expect(user.photo).to be_attached
			end
		end

		context 'with invalid data' do
			it 'invalid user' do
				user = build(:user, email: nil)

				expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
			end
		end
	end
end
