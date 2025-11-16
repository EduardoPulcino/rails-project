import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="decoration-selector"
export default class extends Controller {
  static targets = ["containerDecoration", "contentDecoration", "selectButton", "decoration", "openModalButton"]
  static values = {noneImage: String}

  selectedDecorationId = null
  selectedDecorationName = null

  openModal() {
    this.containerDecorationTarget.classList.remove("hidden")
  }

  closeModal() {
    this.containerDecorationTarget.classList.add("hidden")
  }

  fetchDecoration(event) {
    const id = event.target.value

    this.enableButton()

    fetch(`/decorations/specific/${id}`, {
      headers: { "Accept": "application/json" }
    })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        this.populateModal(data)
      })
      .catch(error => console.error("Erro ao carregar decoração:", error));
  }

  populateModal(decorations) {
    this.populateNoneDecoration()

    if (decorations.length === 0) {
      this.contentDecorationTarget.innerHTML = ""

      const h4 = document.createElement("h4");
      h4.textContent = "Sem decoração";
      h4.classList.add("decorated-h4");

      this.contentDecorationTarget.appendChild(h4);
    } else {
      decorations.forEach(decoration => {
        const img = document.createElement("img")
        img.classList.add("decoracao-img")
        img.src = decoration.photo

        const div = document.createElement("div")
        const h3 = document.createElement("h3")
        div.classList.add("infoEvento-modal-budget")
        h3.textContent = decoration.name
        div.appendChild(h3)

        const divContainer = document.createElement("div")
        divContainer.appendChild(img)
        divContainer.appendChild(div)
        divContainer.classList.add("decoracao")

        divContainer.addEventListener("click", () => {
          this.selectDecoration(decoration.id, divContainer, decoration.name)
        })
        
        this.contentDecorationTarget.appendChild(divContainer)
      })
    }
  }

  populateNoneDecoration() {
    this.contentDecorationTarget.innerHTML = ""

    const img = document.createElement("img")
    img.src = this.noneImageValue
    img.classList.add("modal-none-image")


    const div = document.createElement("div")
    const h3 = document.createElement("h3")
    div.classList.add("infoEvento-modal-budget")
    h3.textContent = "Nenhuma"
    div.appendChild(h3)

    const noneContainer = document.createElement("div")
    noneContainer.appendChild(img)
    noneContainer.appendChild(div)
    noneContainer.classList.add("decoracao")

    noneContainer.addEventListener("click", () => {
      this.selectDecoration(null, noneContainer, "Selecionar decoração")
    })

    this.contentDecorationTarget.appendChild(noneContainer)
  }

  selectDecoration(id, selectedDecoration, name) {
    this.selectedDecorationId = id
    this.selectedDecorationName = name

    const allDecorations = this.contentDecorationTarget.querySelectorAll(".decoracao")
    allDecorations.forEach(decoration => {
      decoration.classList.remove("decoracaoSelecionada")
    })

    selectedDecoration.classList.add("decoracaoSelecionada")

    this.decorationTarget.value = this.selectedDecorationId

    if (this.selectedDecorationId) {
      this.selectButtonTarget.disabled = false
    }
  }

  confirmDecoration() {
    this.closeModal()
    this.changeButtonText()
    console.log("Decoração selecionada:", this.selectedDecorationId)
  }

  changeButtonText() {
    if(this.selectedDecorationName != null) {
      this.openModalButtonTarget.textContent = this.selectedDecorationName
    } else {
      this.selectedDecorationName = "Selecionar decoração"
    }
  }

  enableButton() {
    this.openModalButtonTarget.disabled = false
  }
}
