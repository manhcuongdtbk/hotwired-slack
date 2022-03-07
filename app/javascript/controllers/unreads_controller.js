import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = {
    id: Number
  }

  connect() {
    this.subscription = consumer.subscriptions.create({ channel: "UnreadsChannel", id: this.idValue }, {
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

  _received() {
    this.element.classList.add("fw-bold")
  }
}
