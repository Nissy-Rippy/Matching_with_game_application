class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  attachment :item_image
end
