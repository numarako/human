class ContentBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :content
  validates :user_id, presence: true
  validates :content_id, presence: true

  validates_uniqueness_of :content_id, scope: :user_id   # バリデーション（ユーザーと記事の組み合わせは一意）
end
