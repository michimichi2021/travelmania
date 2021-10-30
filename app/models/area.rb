class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :name, presence: true, uniqueness: true,length:{ maximum:12 }
  
end
