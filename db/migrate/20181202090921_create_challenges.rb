class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
    	t.integer 		:trial_id
    	t.integer		:question_id
    	t.boolean		:is_correct, default: false

		t.timestamps
    end
  end
end
