class AddScoreToQuestion < ActiveRecord::Migration[5.2]
  def change
  	add_column(:questions, :score, :integer, default: 1)
  end
end
