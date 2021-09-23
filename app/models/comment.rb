class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  validates :content, presence: true
  # ratyの評価に対する記述で、数字制限の1以上5以下という設定にしている。そして空白もなし。
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true
end
