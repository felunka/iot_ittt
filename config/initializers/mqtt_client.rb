class MqttClient
  if ENV['ENABLE_MQTT_CONNECTION']
    Connection = MqttRails::Client.new
    Connection.persistent = true
  
    ### Register a callback on message event to display messages
    Connection.on_message do |message|
      puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
      MqttHandler.new_message(message)
    end
  
    ### Register a callback trigger on the reception of a CONNACK packet with return code 0x00
    Connection.on_connack = proc { puts "[MQTT RAILS][INFO] Successfully Connected" }
  
    ### Connect to the broker server on port 1883 (Unencrypted mode)
    Connection.connect(ENV['MQTT_BROKER_HOSTNAME'], 1883)
  
    ### Subscribe to a topic
    Connection.subscribe(['#', 2])
  end
end
