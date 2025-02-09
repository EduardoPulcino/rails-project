require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

google_json_key = ENV['GOOGLE_CALENDAR_JSON_KEY']

credentials = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: StringIO.new(google_json_key), 
  scope: 'https://www.googleapis.com/auth/calendar'
)

CALENDAR = Google::Apis::CalendarV3::CalendarService.new
CALENDAR.authorization = credentials
