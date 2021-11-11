class Content < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :emotions, presence: true
  validates :score, presence: true, numericality: { greater_than:0, less_than: 101 }
  validates :journaling, presence: true, length: { maximum: 650 }
  validates :situation, presence: true, length: { maximum: 650 }
  validates :compassion, presence: true, length: { maximum: 650 }

  enum emotions: { 
    anger: 0,
    disgust: 1,
    sadness: 2,
    surprise: 3,
    fear: 4
  }
end
