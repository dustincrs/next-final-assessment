class AddIconColorToBadges < ActiveRecord::Migration[5.2]
  def change
  	add_column(:badges, :icon_color, :string)
  end
end
