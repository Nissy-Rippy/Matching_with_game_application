class Notification < ApplicationRecord
  # 降順に並べるための記述、デフォルトスコープは強力な記述のためあまり使わない方がよい
  default_scope -> { order(created_at: :desc) }

  belongs_to :visited, class_name: "User", optional: true
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :comment, optional: true
  belongs_to :post, optional: true
end
