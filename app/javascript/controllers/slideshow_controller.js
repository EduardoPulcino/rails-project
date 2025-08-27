import { Controller } from "@hotwired/stimulus"
import Swiper from "swiper/bundle"
import "swiper/swiper-bundle.css"

export default class extends Controller {
  static targets = ["container", "prev", "next"]

  connect() {
    // Só pra depurar:
    console.log("Carousel connect", this.containerTarget, this.prevTarget, this.nextTarget)

    this.swiper = new Swiper(this.containerTarget, {
      slidesPerView: this.slidesPerView(),
      spaceBetween: 10,
      navigation: {
        prevEl: this.prevTarget,
        nextEl: this.nextTarget
      },
      breakpoints: {
        640:  { slidesPerView: 1 },
        1024: { slidesPerView: 2 },
        1440: { slidesPerView: 5 }
      },
      observer: true,
      observeParents: true
    })
  }

  slidesPerView() {
    return Math.max(1, Math.floor(window.innerWidth / 380))
  }
}
