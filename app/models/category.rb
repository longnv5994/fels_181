class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  default_scope {order(created_at: :desc)}
  validates :name, presence: true, uniqueness: true, length: {maximum: 255}

  def verify_destroy_category
    if self.words.any? || self.lessons.any?
      errors.add "category", I18n.t("category.can_not_delete")
    end
  end
end
