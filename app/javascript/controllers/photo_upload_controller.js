import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-upload"
export default class extends Controller {
  static targets = [ "input", "list", "preview" ]

  connect() {
    this.updateList()
  }

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
        files.forEach((file, index) => this.appendImages(file, index))
        this.showPreview(files)
    } else {
        for (let i = 0; i < maxVisibleItems; i++) {
          this.appendImages(files[i], i)
        }

        const remainingCount = files.length - maxVisibleItems
        const li = document.createElement("li")
        li.textContent = `+${remainingCount} arquivo${remainingCount > 1 ? "s" : ""}`
        this.listTarget.appendChild(li)
        this.showPreview(files)
    }
  }

   removeFileAtIndex(indexToRemove) {
    const dt = new DataTransfer()
    const files = Array.from(this.inputTarget.files)

    files.forEach((file, index) => {
      if (index !== indexToRemove) {
        dt.items.add(file)
      }
    })

    this.inputTarget.files = dt.files

    this.updateList()
  }

  appendImages(file, index) {
    const li = document.createElement("li")
    const img = document.createElement("img")

    img.src = URL.createObjectURL(file)
    img.classList.add("thumb")

    const remover = document.createElement('button');

    remover.textContent = 'Remover';
     
    remover.addEventListener("click", () => {
      this.removeFileAtIndex(index)
    })

    li.append(img, ` ${file.name}`, remover)
    li.classList.add('item-li');

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
