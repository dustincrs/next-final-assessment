class Question < ApplicationRecord

	# ASSOCIATIONS
	has_many :trials
	has_many :users, through: :trials
	
end
