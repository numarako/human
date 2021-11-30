class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :content
  belongs_to :comment #Commentの”id”がNotificationの"comment_id"と一致するレコードを参照
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id' #Userの”id”がNotificationの"visitor_id"と一致するレコードを参照
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id' #Userの”id”がNotificationの"visited_id"と一致するレコードを参照
end
