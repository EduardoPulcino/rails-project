FactoryBot.define do
  factory :budget do
    event_date { Date.today + 7 }
    guest_count { 150 }
    start_time { Time.parse('14:00:00').strftime('%H:%M') }
    suggestion { 'Test' }
    event_type
    decoration
    user

    trait :with_invalid_event_date do
      event_date { Date.today - 7 }
    end

    trait :with_invalid_guest_count do
      guest_count { 200 }
    end

    trait :with_invalid_data do
      start_time { nil }
    end
  end
end
