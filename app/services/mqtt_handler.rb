
class MqttHandler
  def self.new_message(message)
    if (sensor = Sensor.find_by(topic: message.topic))
      begin
        value = Float(message.payload)
        mesurement = SensorMesurement.create sensor: sensor, value: message.payload
        ActionCable.server.broadcast 'mesurements',
          time: mesurement.created_at,
          value: mesurement.value
      rescue ArgumentError
        Rails.logger.debug "Invaid value for MQTT message on topic '#{message.topic}': #{message.payload}"
      end
    end
  end
end
