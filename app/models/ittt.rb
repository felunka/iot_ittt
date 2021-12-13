class Ittt < ApplicationRecord
  has_many :ittt_conditions, dependent: :destroy
  accepts_nested_attributes_for :ittt_conditions, reject_if: :all_blank, allow_destroy: true

  has_many :ittt_actions, dependent: :destroy
  accepts_nested_attributes_for :ittt_actions, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :ittt_conditions, presence: true
  validates :ittt_actions, presence: true

  def execute
    self.update last_evaluated_at: Time.zone.now
    if evaluate_conditions
      ittt_actions.each do |action|
        send_mqtt_message(action.topic, action.message)
      end
    else
      ittt_actions.where(send_evaluation_output: true).each do |action|
        send_mqtt_message(action.topic, 'True')
      end
    end
  end

  def evaluate_conditions
    ittt_conditions.each do |condition|
      return false unless condition.evaluate
    end
    return true
  end

  private

  def send_mqtt_message(topic, message)
    begin
      MqttClient::Connection.publish topic, message
      MqttClient::Connection.loop_write
    rescue NameError
      Rails.logger.debug 'MqttClient not defined'
    end
  end
end
