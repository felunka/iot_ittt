class ItttCondition < ApplicationRecord
  belongs_to :ittt
  belongs_to :sensor_1, class_name: 'Sensor'
  belongs_to :sensor_2, class_name: 'Sensor', optional: true

  enum operation: {
    equal: 0,
    smaller_than: 1,
    greater_than: 2
  }
end
