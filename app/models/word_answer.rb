class WordAnswer < ActiveRecord::Base
  belongs_to :word
  belongs_to :result

  validates :content, presence: true, length: {maximum: 140}
end
