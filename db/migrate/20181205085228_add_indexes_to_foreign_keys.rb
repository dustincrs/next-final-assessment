class AddIndexesToForeignKeys < ActiveRecord::Migration[5.2]
  def change
  	add_index :awards, :user_id
  	add_index :awards, :badge_id
  	add_index :challenges, :trial_id
  	add_index :challenges, :question_id
  	add_index :trials, :user_id
  end
end
