require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class DeleteEventCalendar
  include Calendar::Utils

  def delete_event(budget_id)
    event_id = budget(budget_id).google_event_id

    CALENDAR.delete_event(Calendar::Utils::SHARED_CALENDAR_ID, event_id)
  end
end
