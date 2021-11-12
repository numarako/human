class Content < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :emotions, presence: true
  validates :score, presence: true, numericality: { greater_than:0, less_than: 101 }
  validates :journaling, presence: true, length: { maximum: 650 }
  validates :situation, presence: true, length: { maximum: 650 }
  validates :compassion, presence: true, length: { maximum: 650 }
  validates :release, presence: true
  before_validation :processing_for_validates

 # emotions,releaseに入力漏れがあった場合にエラーを発生させる
 def processing_for_validates
  if self.emotions == "default_emotions"
    self.emotions = ''
  end

  if self.release == 'default_release'
    self.release = ''
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
  enum release: { 
    default_release: '',
    private: 0,
    public: 1
  }, _prefix:true
end
