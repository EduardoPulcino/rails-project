import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["main", "lightbox", "lightboxImage", "thumbnail"]
  static values = { images: Array }
  
  connect() {
    this.currentIndex = 0
    this.highlightThumbnail(this.thumbnailTargets[this.currentIndex])
  }

  nextImg() {
    if (!this.imagesValue.length) return

    this.currentIndex++
    if (this.currentIndex >= this.imagesValue.length) {
      this.currentIndex = 0
    }

    var currentSrc = this.imagesValue[this.currentIndex]
    this.mainTarget.src = currentSrc

    this.highlight(currentSrc)
  }

  previousImg() {
    if (!this.imagesValue.length) return

    this.currentIndex--
    if (this.currentIndex < 0) {
      this.currentIndex = this.imagesValue.length - 1
    }

    var currentSrc = this.imagesValue[this.currentIndex]
    this.mainTarget.src = currentSrc

    this.highlight(currentSrc)
  }

  highlight(currentSrc) {
    const matchingThumb = this.thumbnailTargets.find(
      thumb => thumb.src.includes(currentSrc.split("/").pop())
    )

    if (matchingThumb) this.highlightThumbnail(matchingThumb)
  }

  swap(event) {

    const clickedThumbnail = event.target
    const newSrc = clickedThumbnail.src

    this.mainTarget.src = newSrc

    this.currentIndex = this.thumbnailTargets.indexOf(clickedThumbnail)

    this.highlightThumbnail(clickedThumbnail)
  }

  highlightThumbnail(selectedThumbnail) {
    this.thumbnailTargets.forEach
      (thumb => thumb.classList.remove("active")
    )
    selectedThumbnail.classList.add("active")
  }

  openLightbox(event) {
    const src = event.target.src
    this.lightboxImageTarget.src = src
    this.lightboxTarget.classList.remove("hidden")

    document.addEventListener("keydown", this.closeOnEscape)
  }

  closeLightbox() {
    this.lightboxTarget.classList.add("hidden")
    this.lightboxImageTarget.src = ""
    document.removeEventListener("keydown", this.closeOnEscape)
  }

  closeOnEscape = (event) => {
    if (event.key === "Escape") this.closeLightbox()
  }
}
