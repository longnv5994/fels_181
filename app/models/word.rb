class Word < ActiveRecord::Base
  has_many :lessons, through: :results

  scope :filter_category, ->(category_id = 0) do
    where("category_id = ?", "#{category_id}")
  end
  scope :where_contains, -> keyword {where("content like ?","%#{keyword}%")}
  scope :random_words, -> {order("RANDOM()")}
  scope :learned, -> user_id do
    joins(:lessons).distinct.
      where(lessons: {is_complete: true, user_id: user_id})
  end
  scope :unlearned, -> user_id do
    where.not id: Word.learned(user_id)
  end
  scope :showall, -> user_id {}

  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers,
    reject_if: lambda {|a| a[:content].blank?}, allow_destroy: true

  validates :content, presence: true, length: {maximum: 140}
end

