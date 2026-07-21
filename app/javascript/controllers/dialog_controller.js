import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  open(event) {
    event.currentTarget?.focus({ preventScroll: true })
    this.dialogTarget.open = true
  }

  close() {
    this.dialogTarget.open = false
  }
}
