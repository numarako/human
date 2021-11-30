class Content < ApplicationRecord
  default_scope -> { order(updated_at: :desc) }
  # userにsをつけてはいけない
  belongs_to :user
  has_many :content_bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
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

  # コメント通知対応
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人(user_idのみ)をすべて取得し、全員に通知を送る
    # idはcomments_controllerの@contentのid
    temp_ids = Comment.select(:user_id).where(content_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(content_id: id, comment_id: comment_id, visited_id: visited_id)
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
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
