import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["togglableElement", "toggleButton"]

  connect() {
    console.log("Hello from toggle_controller.js")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
    this.toggleButtonTarget.classList.toggle("btn-primary");
    this.toggleButtonTarget.classList.toggle("btn-success");

  }
}
