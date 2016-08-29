class Activity < ActiveRecord::Base
  belong_to :user

  validates :user_id, presence: true
  validates :status, presence: true, length: {maximum: 250}
end
