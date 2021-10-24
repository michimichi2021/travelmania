class Post < ApplicationRecord
  belongs_to :user
  belongs_to :area, class_name: 'Area', foreign_key: 'area_id'
  belongs_to :genre, class_name: 'Genre', foreign_key: 'genre_id'
  belongs_to :scene, class_name: 'Scene', foreign_key: 'scene_id'
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
end
