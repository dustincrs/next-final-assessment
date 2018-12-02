class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
    	t.string		:text
    	t.string		:correct_answer, 				default: ""
    	t.string		:incorrect_answers, array: true, default: []

		  t.timestamps
    end

    add_index(:questions, :text)
  end
end
