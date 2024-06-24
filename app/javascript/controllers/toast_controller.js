import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "countdown" ]

  initialize() {
    this.timer = 5
  }

  connect() {
    this.countdown()
  }

  close() {
    // fadeout
    this.element.classList.add("transition", "duration-1000", "ease-in-out", "opacity-0")
    setTimeout(() => this.element.remove(), 1000)
  }

  countdown() {
    if (this.timer == 0) {
      this.close()
    } else {
      this.countdownTarget.textContent = `${this.timer}s`
      this.timer -= 1
      setTimeout(() => this.countdown(), 1000)
    }
  }
}
