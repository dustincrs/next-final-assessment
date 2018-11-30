class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string		:first_name
    	t.string		:last_name
    	t.string		:email
    	t.string		:password_digest
    	t.integer		:score, 			default: 0
    	t.integer		:n_correct, 		default: 0
    	t.integer		:n_incorrect, 		default: 0

		t.timestamps
    end
  end
end
