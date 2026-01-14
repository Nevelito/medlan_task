import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["count", "list"]

    connect() {
        this.updateCount()
    }

    onFrameRender() {
        this.updateCount()
    }

    updateCount() {
        this.countTarget.textContent = this.listTarget.querySelectorAll("tbody tr:not(:has(td[colspan]))").length
    }
}
