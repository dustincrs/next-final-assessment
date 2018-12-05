class Award < ApplicationRecord

	# ASSOCIATIONS
	belongs_to :user
	belongs_to :badge

	# VALIDATIONS
end
