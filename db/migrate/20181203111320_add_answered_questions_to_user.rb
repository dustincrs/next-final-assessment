class AddAnsweredQuestionsToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column(:users, :answered_questions, :string, array: true, default: [])
  end
end
