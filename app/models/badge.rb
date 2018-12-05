class Badge < ApplicationRecord

	# ASSOCIATIONS
	has_many :awards
	has_many :users, through: :awards

	# VALIDATIONS
	validates :rules, :name, :description, :icon, :icon_color, presence: true
	validates :rules, format: { without: /.*destroy.*/ } # For safety, do not allow badges to destroy stuff!

	# FUNCTIONS
	def render
		return "<i class='#{icon}' style='color: #{icon_color}'></i>".html_safe
	end
end
