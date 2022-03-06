import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["messages", "newMessage"]

  static values = {
    id: Number
  }

  connect() {
    this.subscription = consumer.subscriptions.create({ channel: "MessageChannel", id: this.idValue }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this)
    })
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {
    this.scrollToBottom()
  }

  _disconnected() {

  }

  _received(data) {
    if (data.message) {
      this.messagesTarget.insertAdjacentHTML('beforeend', data.message)

      // Check whether the document is not hidden for the case when user is not on the current chat tab
      if (!document.hidden) {
        this.subscription.perform("touch")
      }
    }
  }

  clearMessage(e) {
    this.newMessageTarget.value = ''
  }

  scrollToBottom() {
    window.scrollTo(0, document.body.scrollHeight)
  }
}
