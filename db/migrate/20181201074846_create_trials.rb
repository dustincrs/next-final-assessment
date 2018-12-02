class CreateTrials < ActiveRecord::Migration[5.2]
  def change
    create_table :trials do |t|
    	t.integer		:user_id

		t.timestamps
    end
  end
end
