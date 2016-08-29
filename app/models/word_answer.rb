class WordAnswer < ActiveRecord::Base
  belong_to :word
  belong_to :result

  validates :content, presence: true, length: {maximum: 140}
end
