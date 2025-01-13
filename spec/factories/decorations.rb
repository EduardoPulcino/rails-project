FactoryBot.define do
  factory :decoration do
    name { 'Halloween' }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'decoration.jpeg'), 'image/jpg') }
    event_type
  end
end