class Ittt < ApplicationRecord
  has_many :ittt_conditions, dependent: :destroy
  accepts_nested_attributes_for :ittt_conditions, reject_if: :all_blank, allow_destroy: true

  has_many :ittt_actions, dependent: :destroy
  accepts_nested_attributes_for :ittt_actions, reject_if: :all_blank, allow_destroy: true
end
