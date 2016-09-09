class WordAnswer < ActiveRecord::Base
  belongs_to :word
  belongs_to :result
  scope :find_answers, ->(word_id) {where("word_id in(?)", word_id)}

  validates :content, presence: true, length: {maximum: 140}
end
