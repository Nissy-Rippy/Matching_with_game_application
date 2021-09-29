class Contact < ApplicationRecord
  validates :name, :phone_number, :message, :email, {presence: true}
  #正規表現にて大文字にならないように設定しています。
  validates :phone_number, format: {with: /\A[0-9]+\z/, message: "半角数字でお願いします！"}
  
end
