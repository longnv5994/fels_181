class Result < ActiveRecord::Base
  belong_to :lesson
  belong_to :word
  belong_to :word_answer
end
