import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["carrossel"]

  connect() {
    this.carrossel = this.carrosselTarget.controller
  }

  prev() {
    if (this.carrossel?.prevImage) {
      this.carrossel.prevImage()
    }
  }

  next() {
    if (this.carrossel?.nextImage) {
      this.carrossel.nextImage()
    }
  }
}
