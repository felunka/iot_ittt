class ItttCondition < ApplicationRecord
  belongs_to :ittt
  belongs_to :sensor_1, class_name: 'Sensor'
  belongs_to :sensor_2, class_name: 'Sensor', optional: true

  validate :sensor_2_xor_comparison_value

  enum operation: {
    equal: 0,
    smaller_than: 1,
    greater_than: 2
  }

  def evaluate
    first_value = sensor_1.most_recent_measurement&.value
    second_value = sensor_2&.most_recent_measurement&.value || comparison_value

    return false if first_value.nil? || second_value.nil?

    if equal?
      return first_value == second_value
    elsif smaller_than?
      return first_value < second_value
    elsif greater_than?
      return first_value > second_value
    end
  end

  private

  def sensor_2_xor_comparison_value
    unless sensor_2_id.blank? ^ comparison_value.blank?
      errors.add(:base, "Specify sensor 2 or comparison_value not both")
    end
  end
end
