class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :name, presence: true, uniqueness: true,length:{ maximum:20 }
  
end
