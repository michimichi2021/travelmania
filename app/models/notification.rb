class Notification < ApplicationRecord
  
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  
end
