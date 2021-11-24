class Memo < ApplicationRecord
  belongs_to :user
  validates :type, presence: true
  validates :tytle, presence: true
  validates :text, presence: true

  enum type: { 
    default_type: '',
    sunny: 0,
    clear: 1,
    fine: 2,
    cloudy: 3,
    rainy: 4
  }
end
