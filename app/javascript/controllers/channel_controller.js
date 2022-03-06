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

  }

  _disconnected() {

  }

  _received(data) {
    if (data.message) {
      this.messagesTarget.insertAdjacentHTML('beforeend', data.message)
    }
  }

  clearMessage(e) {
    this.newMessageTarget.value = ''
  }
}
