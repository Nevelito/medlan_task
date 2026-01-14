import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["count", "list"]

    connect() {
        this.updateCount()
        this.observer = new MutationObserver(() => this.updateCount())
        this.observer.observe(this.element, { childList: true, subtree: true })
    }

    onFrameRender() {
        this.updateCount()
    }

    updateCount() {
        this.countTarget.textContent = this.listTarget.querySelectorAll(".contact-row").length
    }
}
