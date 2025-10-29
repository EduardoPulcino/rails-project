import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-upload"
export default class extends Controller {
  static targets = [ "input", "list", "preview" ]

  updateList() {
    const files = Array.from(this.inputTarget.files)
    this.listTarget.innerHTML = ""
    const maxVisibleItems = 5

    if (files.length === 0) {
      const li = document.createElement("li")
      this.previewTarget.innerHTML = ""
      li.textContent = "Nenhum arquivo selecionado"
      this.listTarget.appendChild(li)
    } else if ( files.length <= maxVisibleItems) {
        files.forEach(file => {
          this.appendImages(file)
      })

      this.showPreview(files)
    } else {
        for (let i = 0; i < maxVisibleItems; i++) {
          var file = files[i]
          this.appendImages(file)
        }

        const remainingCount = files.length - maxVisibleItems
        const li = document.createElement("li")
        li.textContent = `+${remainingCount} arquivo${remainingCount > 1 ? "s" : ""}`
        this.listTarget.appendChild(li)
        this.showPreview(files)
    }
  }

  appendImages(file) {
    const li = document.createElement("li")
    const img = document.createElement("img")
    img.src = URL.createObjectURL(file)
    img.classList.add("thumb")
    li.append(img, ` ${file.name}`)
    this.listTarget.appendChild(li)
  }

  showPreview(files) {
    const file = files[0]
    if (!file) return

    this.previewTarget.innerHTML = ""

    const img = document.createElement("img")
    img.src = URL.createObjectURL(file)
    img.alt = "Preview"
    img.classList.add("previewImage")

    this.previewTarget.appendChild(img)
  }
}
