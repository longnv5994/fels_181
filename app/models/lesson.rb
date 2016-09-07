class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results

  validate :validate_words_size, on: :create
  before_create :assign_word

  private
  def assign_word
    self.category.words.random_words.limit(Settings.ans_lesson).each do |word|
      self.results.build word_id: word.id
    end
  end

  def validate_words_size
    unless self.category && self.category.words.size >= Settings.min_words
      self.errors.add :category, I18n.t("lesson.error_check_word")
    end
  end
end
