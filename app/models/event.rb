class Event < ApplicationRecord
  belongs_to :user
  validates :mind, presence: true
  validates :reason, presence: true
  validates :small_success, presence: true
  validates :small_thanks, presence: true
  validates :date, presence: true
  before_validation :processing_event_params

  # mindに入力漏れがあった場合にエラーを発生させる
  def processing_event_params
    if self.mind == "default_mind"
      self.mind = ''
    end
  end

  enum mind: { 
    default_mind: '',
    sunny: 0,
    clear: 1,
    fine: 2,
    cloudy: 3,
    rainy: 4
  }
end
