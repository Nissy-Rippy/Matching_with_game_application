class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  #optional:true にてnil を許可している。
  belongs_to :group, optional: true
end
