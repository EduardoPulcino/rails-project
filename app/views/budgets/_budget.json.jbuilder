json.extract! budget, :id, :event_date, :guest_count, :status, :canceled, :start_time, :end_time, :cake_flavor, :main_course, :profit, :revenue, :expense, :suggestion, :google_event_id, :event_type_id, :user_id, :decoration_id, :created_at, :updated_at
json.url budget_url(budget, format: :json)
