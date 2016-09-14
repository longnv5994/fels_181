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
  belongs_to :lesson
  has_many :results
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers,
    reject_if: lambda {|a| a[:content].blank?}, allow_destroy: true

  validates :content, presence: true, length: {maximum: 140}
  validate :validate_answer

  def verify_used_word
    if self.lessons.any?
      errors.add "Used_word:", I18n.t("word.can_not_delete")
    end
  end

  private
  def validate_answer
    size_correct = self.word_answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add "correct_answer:", I18n.t("messages.validate_answer_size_correct")
    end
    correct_answer_size = self.word_answers.size
    if Settings.answer_default > correct_answer_size ||
      correct_answer_size > Settings.max_answer
      errors.add "answer_size:", I18n.t("messages.validate_answer_size")
    end
  end
end
