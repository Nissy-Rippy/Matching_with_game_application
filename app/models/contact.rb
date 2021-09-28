class Contact < ApplicationRecord
  validates :name, :phone_number, :message, :email, {presence: true}
  validates :phone_number, format: {with: /\A[0-9]+\z/, message: "半角数字でお願いします！"}
  
end
