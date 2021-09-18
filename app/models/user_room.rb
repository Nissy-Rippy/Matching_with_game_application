class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :group, optional: true
end
