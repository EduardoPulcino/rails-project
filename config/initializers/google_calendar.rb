require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

Google::Apis::ClientOptions.default.application_name = "MyRailsApp"
Google::Apis::ClientOptions.default.application_version = "1.0"

KEY_PATH = Rails.root.join('config', 'calendar_credentials.json')

credentials = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(KEY_PATH), 
  scope: 'https://www.googleapis.com/auth/calendar'
)

CALENDAR = Google::Apis::CalendarV3::CalendarService.new
CALENDAR.authorization = credentials
