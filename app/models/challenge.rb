class Challenge < ApplicationRecord
	# CALLBACKS
	after_save :update_user_score

	# ASSOCIATIONS
	belongs_to :trial
	belongs_to :question
	
	private
	def update_user_score
		if(is_answered && is_correct)
			trial.user.score += question.score
			trial.user.save
		end
	end
end