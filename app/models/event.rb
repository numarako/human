class Event < ApplicationRecord
  validates :status, presence: true
  validates :reason, presence: true
  validates :small_success, presence: true
end
