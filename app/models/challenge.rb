class Challenge < ApplicationRecord

	# ASSOCIATIONS
	belongs_to :trial
	belongs_to :question
	
end