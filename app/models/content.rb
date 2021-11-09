class Content < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :journaling, presence: true
  validates :situation, presence: true
  validates :compassion, presence: true
end
