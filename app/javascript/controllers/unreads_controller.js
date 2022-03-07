import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["mentions"]

  static values = {
    id: Number
  }

  connect() {
    this.username = document.querySelector("meta[name='username']").getAttribute("content")
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

  _received(data) {
    this.element.classList.add("fw-bold")

    if (data.mentions && data.mentions.includes(this.username)) {
      let count = parseInt(this.mentionsTarget.textContent)
      this.mentionsTarget.textContent = count + 1
      this.mentionsTarget.removeAttribute("hidden")
      this.notify(data.body)
    }
  }

  // https://developer.mozilla.org/en-US/docs/Web/API/Notification/permission#examples
  notify(message) {
    // Let's check if the browser supports notifications
    if (!("Notification" in window)) {
      console.log("This browser does not support desktop notification");
    }

    // Let's check whether notification permissions have already been granted
    else if (Notification.permission === "granted") {
      // If it's okay let's create a notification
      const notification = new Notification(message);
    }

    // Otherwise, we need to ask the user for permission
    else if (Notification.permission !== "denied" || Notification.permission === "default") {
      Notification.requestPermission(function (permission) {
        // If the user accepts, let's create a notification
        if (permission === "granted") {
          const notification = new Notification(message);
        }
      });
    }

    // At last, if the user has denied notifications, and you
    // want to be respectful there is no need to bother them any more.
  }
}
