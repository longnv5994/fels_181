class Activity < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  enum activity_types: [:follow, :unfollow, :create_lesson, :finished,
    :learn_lesson]

end
