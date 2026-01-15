import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["count", "list", "form", "trigger"]

    connect() {
        this.updateCount()
        this.observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (this.listTarget.contains(mutation.target)) {
                    this.updateCount()
                }

                if (this.triggerTarget.contains(mutation.target)) {
                    this.onBroadcastAction()
                }
            })
        })
        this.observer.observe(this.element, { childList: true, subtree: true })
    }

    onBroadcastAction() {
        // TODO increase delay if there will be more users
        const delay = Math.random() * 100;

        setTimeout(() => { this.formTarget.requestSubmit(); }, delay);
    }

    updateCount() {
        this.countTarget.textContent = this.listTarget.querySelectorAll(".contact-row").length
    }
}
