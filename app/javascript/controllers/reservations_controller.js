import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservations"
export default class extends Controller {
  static targets = ["empty", "selected", "color"]

  hide() {
    this.emptyTarget.classList.add("hidden")
    this.selectedTarget.classList.remove("hidden")
    this.colorTarget.classList.add("color")
  }
}
