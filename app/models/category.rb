class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  default_scope {order(created_at: :desc)}
  validates :name, presence: true, length: {maximum: 255}
end
