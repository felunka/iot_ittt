class Sensor < ApplicationRecord
  has_many :sensor_mesurements

  enum sensor_type: {
    mqtt: 0,
    rest: 1
  }

  def description
    if mqtt?
      "MQTT on topic: #{topic}"
    elsif rest?
      "REST on url: #{url}"
    end
  end
end
