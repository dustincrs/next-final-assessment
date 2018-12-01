class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
    	t.string		:text
    	t.string		:correct_answer, 				default: ""
    	t.string		:incorrect_answer, array: true, default: []
    	t.string		:digest

		t.timestamps
    end

    add_index(:questions, :digest)
  end
end
