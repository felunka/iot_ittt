class SensorMeasurement < ApplicationRecord
  belongs_to :sensor

  def value_with_text
    "#{value} recorded at #{I18n.l created_at}"
  end
end
