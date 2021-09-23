class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  belongs_to :group, optional: true
end
