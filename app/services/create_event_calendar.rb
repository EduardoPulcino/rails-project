require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class CreateEventCalendar
  SHARED_CALENDAR_ID = 'rubyonrails532@gmail.com'

  def self.create_event(event_details)
    # Criando o evento no calendário compartilhado
    event = Google::Apis::CalendarV3::Event.new(
      summary: event_details[:summary],
      location: event_details[:location],
      description: event_details[:description],
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_details[:start_time],
        time_zone: event_details[:timezone]
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_details[:end_time],
        time_zone: event_details[:timezone]
      )
    )

    begin
      CALENDAR.insert_event(SHARED_CALENDAR_ID, event)
    rescue Google::Apis::ClientError => e
      puts "Erro ao criar evento: #{e.message}"
    end    
  end

  private

  def authorize
    # Usar o access_token e refresh_token do usuário
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      scope: SCOPE,
      access_token: @user.access_token,
      refresh_token: @user.refresh_token
    )

    # Verifica se o token expirou e renova com o refresh_token
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
