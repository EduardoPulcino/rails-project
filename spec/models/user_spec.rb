require 'rails_helper'

RSpec.describe User do
	context 'create user' do
		context 'with valid data' do
			it 'return user' do
				user = create(:user, :with_photo)

				expect(user.photo).to be_attached
			end
		end

		context 'with invalid data' do

		end
	end
end