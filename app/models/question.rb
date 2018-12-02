class Question < ApplicationRecord

	# ASSOCIATIONS
	has_many :challenges
	has_many :trials, through: :challenges
	
end
