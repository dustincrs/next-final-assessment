class AddHasBeenAccessedToTrials < ActiveRecord::Migration[5.2]
  def change
	add_column(:trials, :has_been_accessed, :boolean, default: false)  	
  end
end
