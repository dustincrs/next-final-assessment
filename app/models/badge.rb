class Badge < ApplicationRecord

	# ASSOCIATIONS
	has_many :awards
	has_many :users, through: :awards


	# FUNCTIONS
	def render
		return "<i class='#{icon}' style='color: #{icon_color}'></i>".html_safe
	end
end
