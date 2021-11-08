class Memo < ApplicationRecord
  validates :type, presence: true
  validates :tytle, presence: true
  validates :text, presence: true
end
