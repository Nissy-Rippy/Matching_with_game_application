class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  #optional: true により nilを許可している
  belongs_to :group, optional: true
end
