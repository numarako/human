class Memo < ApplicationRecord
  belongs_to :user
  validates :type, presence: true
  validates :tytle, presence: true
  validates :text, presence: true
end
