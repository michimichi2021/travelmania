class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts,dependent: :destroy
  has_one_attached :image
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  has_many :following_user, through: :followers, source: :followed
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  
  validates :name, presence: true,length:{ maximum:22 }
  validates :email,format: { with: /\A\S+@\S+\.\S+\z/ }
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }
  
  def follow(user_id)
  followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
  followers.find_by(followed_id: user_id).destroy
  end

  def following?(user)
  following_user.include?(user)
  end
  
  def create_notification_follow!(current_user)
  temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
  if temp.blank?
   notification = current_user.active_notifications.new(
   visited_id: id,
   action: 'follow'
   )
   notification.save if notification.valid?
  end
  end

end
