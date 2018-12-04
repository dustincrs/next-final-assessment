class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string		:first_name
    	t.string		:last_name
    	t.string		:email
    	t.string		:password_digest
    	t.integer		:score,                  		      	default: 0
    	t.string		:correct_answers,    array: true, 		default: []
    	t.string		:incorrect_answers,  array: true,    	default: []

		t.timestamps
    end
  end
end
