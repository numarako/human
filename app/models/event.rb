class Event < ApplicationRecord
  belongs_to :user
  validates :mind, presence: true
  validates :reason, presence: true
  validates :small_success, presence: true
  validates :date, presence: true

  enum mind: { 
    default_mind: '',
    sunny: 0,
    clear: 1,
    fine: 2,
    cloudy: 3,
    rainy: 4
  }
end
