class Question < ApplicationRecord

	# CONSTANTS
	SCORES = 	{
					"easy" => 2,
					"medium" => 4,
					"hard" => 6,
				}

	# ASSOCIATIONS
	has_many :challenges
	has_many :trials, through: :challenges
	
end
