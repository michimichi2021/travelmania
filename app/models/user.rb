class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts
  has_one_attached :image
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  has_many :following_user, through: :followers, source: :followed
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
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

end
