import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { Portuguese } from "flatpickr/dist/l10n/pt.js";

// Connects to data-controller="date-picker"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      dateFormat: "d/m/Y",
      minDate: "today",
      locale: Portuguese
    });
  }
}
