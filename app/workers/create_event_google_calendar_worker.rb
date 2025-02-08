class CreateEventGoogleCalendarWorker
  include Sidekiq::Worker

  def perform(budget_id)
    event = CreateEventCalendar.create_event(budget_id)

    budget = Budget.find(budget_id)
    budget.update(google_event_id: event.id) if budget && event
  end
end
