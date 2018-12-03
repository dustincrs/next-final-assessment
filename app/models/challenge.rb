class Challenge < ApplicationRecord
	# CALLBACKS
	after_save :update_user_score

	# ASSOCIATIONS
	belongs_to :trial
	belongs_to :question
	
	private
	def update_user_score
		if(is_answered && is_correct)
			unless(trial.user.answered_questions.include?(question.id))
				trial.user.score += question.score
			else
				trial.user.score += 1
			end

			trial.user.n_correct += 1
		end

		if(is_answered && !is_correct)
			trial.user.n_incorrect += 1
		end

		trial.user.answered_questions << question.id
		trial.user.save
	end
end