class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
    	t.string		:rules
    	t.string		:name
    	t.string		:description
    	t.string		:icon # FA code ONLY (NO HTML)

		t.timestamps
    end
  end
end
