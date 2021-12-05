class Sensor < ApplicationRecord
  has_many :sensor_measurements, dependent: :destroy

  enum sensor_type: {
    mqtt: 0,
    rest: 1
  }

  validates :name, presence: true
  validates :topic, presence: true, if: :mqtt?
  validates :url, presence: true, if: :rest?
  validates :interval, presence: true, if: :rest?
  validates :json_path, presence: true, if: :rest?

  def description
    if mqtt?
      "MQTT on topic: #{topic}"
    elsif rest?
      "REST on url: #{url}"
    end
  end

  def most_recent_measurement
    sensor_measurements.order(:created_at).last
  end
end
