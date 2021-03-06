class User < ApplicationRecord
  has_many :contents, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :content_bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :age, presence: true
  validates :gender, presence: true
  before_validation :processing_user_params
  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end 

  # age,genderに入力漏れがあった場合にエラーを発生させる
  def processing_user_params
    if self.age == "default_age"
      self.age = ''
    end

    if self.gender == 'default_gender'
      self.gender = ''
    end
  end

  enum age: { 
    default_age: '',
    under15: 0,
    late_teens: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties: 6,
    over70: 7,
    no_age: 8
  }

  enum gender: { 
    default_gender: '',
    man: 0,
    woman: 1, 
    other: 2,
    no_gender: 3
  }
end
