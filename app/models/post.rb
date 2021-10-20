class Post < ApplicationRecord
  belongs_to :user
  belongs_to :area, class_name: 'Area', foreign_key: 'area_id'
  belongs_to :genre, class_name: 'Genre', foreign_key: 'genre_id'
  belongs_to :scene, class_name: 'Scene', foreign_key: 'scene_id'
  has_one_attached :image
  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }
end
