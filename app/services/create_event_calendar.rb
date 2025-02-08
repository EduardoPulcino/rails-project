require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class CreateEventCalendar
  SHARED_CALENDAR_ID = 'rubyonrails532@gmail.com'

  def self.create_event(budget_id)
    event = build_event(budget_id)

    begin
      CALENDAR.insert_event(SHARED_CALENDAR_ID, event)
    rescue Google::Apis::ClientError => e
      puts "Erro ao criar evento: #{e.message}"
    end    
  end

  private

  def self.build_event(budget_id)
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

  def self.budget(budget_id)
    budget = Budget.find(budget_id)

    budget
  end

  def self.build_description(budget_id)
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

  def self.build_event_time(budget_id)
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

  def authorize
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      scope: SCOPE,
      access_token: @user.access_token,
      refresh_token: @user.refresh_token
    )

    if credentials.expired?
      credentials = credentials.refresh!
      @user.update(
        access_token: credentials.token,
        refresh_token: credentials.refresh_token
      )
    end

    credentials
  end
end
