class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results

  validates :name, presence: true, length: {maximum: 255}
end
