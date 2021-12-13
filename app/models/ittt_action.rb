class ItttAction < ApplicationRecord
  belongs_to :ittt

  validates :topic, presence: true
  validate :message_xor_send_evaluation_output

  private

  def message_xor_send_evaluation_output
    unless message.blank? ^ !send_evaluation_output?
      errors.add(:message, 'Specify message or use message but not both.')
    end
  end
end
