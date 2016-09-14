class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :results
  scope :correct, -> {where is_correct: true}
  scope :find_answers, ->(word_id) {where("word_id in(?)", word_id)}

  validates :content, presence: true, length: {maximum: 140}
end
