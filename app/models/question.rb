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
	
	# Takes a question from the API response as argument. If the question already exists, returns that question.
	# Otherwise, creates and returns the question
	def self.create_from_api_response(question)

		same_question = self.find_by(text: question["question"])

		if same_question.nil?
			new_question = 	self.new(	text: HTMLEntities.new.decode(question["question"]),
											correct_answer: HTMLEntities.new.decode(question["correct_answer"]),
											incorrect_answers: question["incorrect_answers"].map { |a| HTMLEntities.new.decode(a) },
											category: question["category"],
											score: self::SCORES[question["difficulty"]],
										)
			new_question.save
		else
			new_question = same_question
		end

		return new_question
	end
end
