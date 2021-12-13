class SensorMeasurement < ApplicationRecord
  belongs_to :sensor

  after_create :execute_ittt_on_trigger

  def value_with_text
    "#{value} recorded at #{I18n.l created_at}"
  end

  def execute_ittt_on_trigger
    Ittt.joins(:ittt_conditions).where(trigger_on_sensor_update: true).where('sensor_1_id=? OR sensor_2_id=?', sensor_id, sensor_id).each do |ittt|
      ittt.execute
    end
  end
end
