class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer
  delegate :is_correct, to: :word_answer, allow_nil: true
end
