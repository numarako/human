class Memo < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 500 }
  before_validation :processing_category_params

  # categoryに入力漏れがあった場合にエラーを発生させる
  def processing_category_params
    if self.category == "default_category"
      self.category = ''
    end
  end

  enum category: { 
    default_category: '',
    strength: 0,
    weakness: 1,
    thinking_habits: 2,
    behavioral_habits: 3
  }
end


 