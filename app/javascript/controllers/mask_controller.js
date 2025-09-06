import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mask"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.mask.bind(this))
  }

  mask(event) {
    const input = event.target
    let cursor = input.selectionStart

    let value = input.value.replace(/\D/g, "")
    value = value.slice(0, 11)

    if (value.length > 2 && value.length <= 6) {
      value = `(${value.slice(0, 2)}) ${value.slice(2)}`
    } else if (value.length > 6 && value.length <= 10) {
      value = `(${value.slice(0, 2)}) ${value.slice(2, 6)}-${value.slice(6)}`
    } else if (value.length > 10) {
      value = `(${value.slice(0, 2)}) ${value.slice(2, 7)}-${value.slice(7)}`
    }

    input.value = value

    input.setSelectionRange(value.length, value.length)
  }
}
