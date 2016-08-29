class Word < ActiveRecord::Base
  belong_to :category
  has_many :results
  has_many :word_answers

  validates :content, presence: true, length: {maximum: 140}
end

