class Challenge < ApplicationRecord
	# CALLBACKS
	after_save :update_user_score

	# ASSOCIATIONS
	belongs_to :trial
	belongs_to :question

	# VALIDATIONS
	validates :is_correct, :is_answered, presence: true

	# DELEGATIONS
	delegate :answered_questions, :score, :correct_answers, :incorrect_answers, to: :user, prefix: true

	private
	def update_user_score
		if(is_answered && is_correct)
			unless(trial.user_answered_questions.include?(question.id))
				trial.user_score += question.score
			else
				# User has encountered this question before!
				# Only give one point and do not add the question to any of the arrays!
				trial.user.score += 1
				trial.user.save
				return
			end

			trial.user_correct_answers << question.id
		end

		if(is_answered && !is_correct)
			trial.user_incorrect_answers << question.id
		end

		trial.user_answered_questions << question.id
		trial.user.save
	end
end