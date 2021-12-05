if ENV['ENABLE_MQTT_CONNECTION']
  require 'mqtt-rails'

  ::MqttClient = MqttRails::Client.new
  MqttClient.persistent = true

  ### Register a callback on message event to display messages
  MqttClient.on_message do |message|
    puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
    MqttHandler.new_message(message)
  end

  ### Register a callback trigger on the reception of a CONNACK packet with return code 0x00
  MqttClient.on_connack = proc { puts "[MQTT RAILS][INFO] Successfully Connected" }

  ### Connect to the broker server on port 1883 (Unencrypted mode)
  MqttClient.connect('192.168.1.221', 1883)

  ### Subscribe to a topic
  MqttClient.subscribe(['#', 2])
end
