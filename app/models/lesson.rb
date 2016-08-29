class Lesson < ActiveRecord::Base
  belong_to :user
  belong_to :category
  has_many :results

  validates :name, presence: true, length: {maximum: 255}
end
