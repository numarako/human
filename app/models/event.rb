class Event < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  validates :reason, presence: true
  validates :small_success, presence: true
end
