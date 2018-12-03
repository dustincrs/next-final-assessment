class Question < ApplicationRecord

	# CONSTANTS
	SCORES = 	{
					"easy" => 1,
					"medium" => 2,
					"hard" => 3,
				}

	# ASSOCIATIONS
	has_many :challenges
	has_many :trials, through: :challenges
	
end
