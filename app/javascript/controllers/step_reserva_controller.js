import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="step-reserva"
export default class extends Controller {

  static targets = ["container", "mensagem"]
  static values = { num: Number }

  connect() {
    console.log("aqqq")


    this.passoAtivo = 1
    this.update()
  }

  change(event) {
    this.passoAtivo = parseInt(event.currentTarget.dataset.stepReservaNumValue)
    this.update()
  }

  update() {
    this.containerTarget.querySelectorAll(".passo").forEach((el, idx) => {
      let num = idx + 1
      el.classList.toggle("ativo", this.passoAtivo >= num)
    })

    this.containerTarget.querySelectorAll(".linha").forEach((el, idx) => {
      let num = idx + 1
      el.classList.toggle("linha-ativa", this.passoAtivo > num)
    })

    const mensagens = [
      `Para iniciar o atendimento, clique em <a href='/budgets/new' class='destaque-texto-step'>Solicitar Orçamento</a><br>Você será levado <span class='destaque-texto-step'>automaticamente</span> à página de Reservas`,
      `Preencha os dados <span class='destaque-texto-step'>solicidados</span> para concluir a <br/> solicitação de reserva do local.`,
      `Aguarde nossa <span class='destaque-texto-step'>resposta</span> e <span class='destaque-texto-step'>confirmação</span> da reserva em breve.`
    ]
    this.mensagemTarget.innerHTML = `<p>${mensagens[this.passoAtivo - 1]}</p>`
  }
}
