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
				# User has encountered this question before!
				# Only give one point and do not add the question to any of the arrays!
				trial.user.score += 1
				trial.user.save
				return
			end

			trial.user.correct_answers << question.id
		end

		if(is_answered && !is_correct)
			trial.user.incorrect_answers << question.id
		end

		trial.user.answered_questions << question.id
		trial.user.save
	end
end