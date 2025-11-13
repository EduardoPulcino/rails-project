import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["container", "content"]

  connect() {
    if (this.data.get("open") === "true") {
      this.open()
    }
  }

  openNew() {
    console.log("to no new")
    this.containerTarget.classList.remove("hidden")
  }

  openEdit(event) {
    event.preventDefault()
    const id = event.currentTarget.dataset.id

    this.containerTarget.classList.remove("hidden")

    fetch(`/decorations/${id}/edit`, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html
      })
      .catch(error => console.error("Erro ao carregar formulário de edição:", error))
  }

  close() {
    this.containerTarget.classList.add("hidden")
  }
}
