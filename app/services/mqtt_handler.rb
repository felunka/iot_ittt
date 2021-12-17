
class MqttHandler
  def self.new_message(message)
    if (sensor = Sensor.find_by(topic: message.topic))
      begin
        value = Float(message.payload)
        unless sensor.toleranz.present? && abs(sensor.most_recent_measurement - value) < sensor.toleranz
          mesurement = SensorMeasurement.create sensor: sensor, value: value

          ActionCable.server.broadcast 'measurements',
            sensor_id: sensor.id,
            time: mesurement.created_at,
            value: mesurement.value,
            value_with_text: mesurement.value_with_text
        end
      rescue ArgumentError
        Rails.logger.debug "Invaid value for MQTT message on topic '#{message.topic}': #{message.payload}"
      end
    end
  end
end
