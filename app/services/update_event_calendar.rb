require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class UpdateEventCalendar
  include Calendar::Utils

  def update_event(budget_id)
    event_id = budget(budget_id).google_event_id
    event = build_event(budget_id)

    CALENDAR.update_event(Calendar::Utils::SHARED_CALENDAR_ID, event_id, event)
  end
end
