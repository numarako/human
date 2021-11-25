class Content < ApplicationRecord
  # userにsをつけてはいけない
  belongs_to :user
  has_many :content_bookmarks, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  validates :emotions, presence: true
  validates :score, presence: true, numericality: { greater_than:0, less_than: 101 }
  validates :journaling, presence: true, length: { maximum: 500 }
  validates :situation, presence: true, length: { maximum: 500 }
  validates :compassion, presence: true, length: { maximum: 500 }
  validates :status, presence: true
  before_validation :processing_content_params

 # emotions,statusに入力漏れがあった場合にエラーを発生させる
 def processing_content_params
  if self.emotions == "default_emotions"
    self.emotions = ''
  end

  if self.status == 'default_status'
    self.status = ''
  end
end

  enum emotions: { 
    default_emotions: '',
    anger: 0,
    disgust: 1,
    sadness: 2,
    surprise: 3,
    fear: 4
  }
  enum status: { 
    default_status: '',
    private: 0,
    public: 1
  }, _prefix:true
end
