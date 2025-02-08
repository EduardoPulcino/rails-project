class CreateEventGoogleCalendarWorker
  # include Sidekiq::Worker

  def perform(budget_id)
    budget = Budget.find(budget_id)

    calendar = Google::Apis::CalendarV3::CalendarService.new

    start_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: budget.start_date.iso8601, 
      time_zone: 'America/Sao_Paulo'
    )
    end_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: budget.end_date.iso8601, 
      time_zone: 'America/Sao_Paulo'
    )
    
    event = Google::Apis::CalendarV3::Event.new(
      summary: budget.title,
      description: budget.description,
      start: start_time,
      end: end_time
    )

    calendar.insert_event(event)
  end
end
