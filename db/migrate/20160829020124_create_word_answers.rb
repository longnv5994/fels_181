class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.integer :word_id
      t.text :content
      t.boolean :is_correct, default: false

      t.timestamps null: false
    end
  end
end
