require 'mqtt-rails'

client = MqttRails::Client.new
client.persistent = true

### Register a callback on message event to display messages
client.on_message do |message|
  puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
  Service::Mqtt.new_message(message)
end

### Register a callback trigger on the reception of a CONNACK packet with return code 0x00
client.on_connack = proc { puts "[MQTT RAILS][INFO] Successfully Connected" }

### Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('192.168.1.221', 1883)

### Subscribe to a topic
client.subscribe(['/sensor/*', 2])
