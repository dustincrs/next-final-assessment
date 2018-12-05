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

	# VALIDATIONS
	validates :text, :correct_answer, :incorrect_answers, :score, :category, presence: true
	validates :score, numericality: { greater_than: 0 }
	
end
