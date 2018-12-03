class AddIsAnsweredToChallenges < ActiveRecord::Migration[5.2]
  def change
  	add_column(:challenges, :is_answered, :boolean, default: false)
  end
end
