import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mask"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.mask.bind(this))
  }

  mask(event) {
    let value = event.target.value.replace(/\D/g, "") // só números
    value = value.slice(0, 11) // máximo 11 dígitos

    if (value.length > 2 && value.length <= 6) {
      value = `(${value.slice(0, 2)}) ${value.slice(2)}`
    } else if (value.length > 6) {
      value = `(${value.slice(0, 2)}) ${value.slice(2, 7)}-${value.slice(7)}`
    }

    event.target.value = value
  }
}
