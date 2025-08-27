import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["box", "resposta", "iconeAberto", "iconeFechado"]

  connect() {
    this.aberto = false
    this.close()
  }

  toggle() {
    this.aberto ? this.close() : this.open()
  }

  open() {
    this.aberto = true
    // altera box (pergunta)
    this.boxTarget.classList.remove("naoAtivo")
    this.boxTarget.classList.add("ativo-question")

    // altera resposta
    this.respostaTarget.classList.remove("hidden")
    this.respostaTarget.classList.add("ativoResposta")

    // icones
    this.iconeFechadoTarget.classList.add("hidden")
    this.iconeAbertoTarget.classList.remove("hidden")
  }

  close() {
    this.aberto = false

    // altera box (pergunta)
    this.boxTarget.classList.remove("ativo-question")
    this.boxTarget.classList.add("naoAtivo")

    // altera resposta
    this.respostaTarget.classList.add("hidden")
    this.respostaTarget.classList.remove("ativoResposta")

    // icones
    this.iconeFechadoTarget.classList.remove("hidden")
    this.iconeAbertoTarget.classList.add("hidden")
  }
}
