module Calendar
  module Utils
    SHARED_CALENDAR_ID = ENV['GOOGLE_CALENDAR_ID']

    def build_event(budget_id)
      budget = budget(budget_id)
      event_time = build_event_time(budget_id)
  
      event = Google::Apis::CalendarV3::Event.new(
        summary: budget.event_type.name,
        description: build_description(budget_id),
        start: event_time[:start],
        end: event_time[:end]
      )
  
      event
    end
  
    def budget(budget_id)
      Budget.find(budget_id)
    end
  
    def build_description(budget_id)
      budget = budget(budget_id)
  
      description = <<~DESC
        Cliente: #{budget.user.name}
        Telefone do cliente: #{budget.user.phone}
        Número de convidados: #{budget.guest_count}
        Status: #{budget.status}
        Sugestões: #{budget.suggestion}
      DESC
  
      description.strip
    end
  
    def build_event_time(budget_id)
      budget = budget(budget_id)
  
      start_datetime = DateTime.new(
        budget.event_date.year, budget.event_date.month, budget.event_date.day,
        budget.start_time.hour, budget.start_time.min, budget.start_time.sec,
        "-03:00"
      )
    
      end_datetime = DateTime.new(
        budget.event_date.year, budget.event_date.month, budget.event_date.day,
        budget.end_time.hour, budget.end_time.min, budget.end_time.sec,
        "-03:00"
      )
    
      start_event = Google::Apis::CalendarV3::EventDateTime.new(
        date_time: start_datetime,
        time_zone: "America/Sao_Paulo"
      )
    
      end_event = Google::Apis::CalendarV3::EventDateTime.new(
        date_time: end_datetime,
        time_zone: "America/Sao_Paulo"
      )
    
      { start: start_event, end: end_event }
    end
  end
end
