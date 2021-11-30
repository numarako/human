class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :content
  has_many :notifications, dependent: :destroy
  validates :phrase, presence: true
  validates :user_id, presence: true
  validates :content_id, presence: true
  before_validation :processing_phrase_params

  # phraseに入力漏れがあった場合にエラーを発生させる
  def processing_phrase_params
    if self.phrase == "default_phrase"
      self.phrase = ''
    end
  end

  enum phrase: { 
    default_phrase: '',
    anger: 0,
    disgust: 1,
    sadness: 2,
    surprise: 3,
    fear: 4,
    hard: 5,
    happy: 6,
    cheered: 7,
    support: 8,
    thankful: 9
  }
end
