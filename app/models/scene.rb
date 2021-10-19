class Scene < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  
end
