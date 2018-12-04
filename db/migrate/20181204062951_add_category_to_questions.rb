class AddCategoryToQuestions < ActiveRecord::Migration[5.2]
  def change
  	add_column(:questions, :category, :string)
  end
end
