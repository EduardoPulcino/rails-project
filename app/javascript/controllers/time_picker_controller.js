import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { Portuguese } from "flatpickr/dist/l10n/pt"

// Connects to data-controller="time-picker"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true,
      locale: Portuguese
    })
  }
}
