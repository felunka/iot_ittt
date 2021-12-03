class Sensor < ApplicationRecord
  has_many :sensor_measurements

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

  def most_recent_measurement

  end
end
