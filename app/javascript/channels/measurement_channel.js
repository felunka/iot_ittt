import consumer from "./consumer"

consumer.subscriptions.create("MeasurementsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
    this.updateMeasurement(data);
  },

  updateMeasurement(data) {
    let valueContainer = document.querySelector(`.sensor-card[data-sensor-id="${data.sensor_id}"] .sensor-value`)
    
    valueContainer.innerText = data.value_with_text
    valueContainer.classList.add('highlight');
  
    setTimeout(() => valueContainer.classList.remove('highlight'), 3000)
  }
});
