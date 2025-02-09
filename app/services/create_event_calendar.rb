require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class CreateEventCalendar
  include Calendar::Utils

  def create_event(budget_id)
    event = build_event(budget_id)

    begin
      CALENDAR.insert_event(Calendar::Utils::SHARED_CALENDAR_ID, event)
    rescue Google::Apis::ClientError => e
      puts "Erro ao criar evento: #{e.message}"
    end    
  end

  private

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
