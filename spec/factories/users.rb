FactoryBot.define do
	factory :user do
		name { 'Eduardo' }
		email { 'eduardo@gmail.com' }
		password { '123456' }
		phone { '11997828712' }
		role { :user }

		trait :with_photo do
			after(:create) do |user|
				user.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'avatar.png')), filename: 'avatar.png', content_type: 'image/png')
			end
		end
	end
end