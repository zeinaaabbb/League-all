import { Controller } from "@hotwired/stimulus"

//allows you to create subscriptions - Action Cable that creates a consumer object
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  // array that defines the targets
  static targets = ["messages"]
  // values that the controller recieves
  static values = { chatroomId: Number }

  connect() {
    // console.log("im connected!")
    // console.log(this.messagesTarget)
    // createconsumber - subscription method - sets up connect between browser using action cabel and subscribes to channel named
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
    // console.log(this.chatroom.name)
    console.log(this.messagesTarget)

    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => {
          // console.log(data);
          this.messagesTarget.insertAdjacentHTML("beforeend", data);
          this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);

        }
      }
    )
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
