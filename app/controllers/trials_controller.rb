require 'net/http'

class TrialsController < ApplicationController

	def new
	end

	def create
		# First, construct what should be sent to the API to minimize number of calls
		# 1 call per question required = BAD
		# Since API can only do one category at a time, split calls by category

		# Gets the category IDs that the user wants questions from. If 0, choose 5 random categories
		chosen_categories = trial_params[:category].select	{|k,v| v=="1"}.keys

		if chosen_categories.size == 0
			chosen_categories = trial_params[:category].keys.sample(5)
		end

		# Split the number of questions requested up by the number of categories requested:
		questions_per_category = trial_params[:length].to_i/chosen_categories.size

		# Construct an array: [category_id, number_of_questions_for_category]
		questions_by_category = chosen_categories.map { |c| [c, questions_per_category] }

		# Find out the number of questions "leftover" to make the total
		leftover_questions = trial_params[:length].to_i - (questions_per_category * chosen_categories.size)

		# Add these leftovers randomly amongst the categories
		leftover_questions.times do
			questions_by_category[rand(questions_by_category.size)][1] += 1
		end


		# Construct hash for API params. Populate with things that don't change
		request_params = 	{
							difficulty: trial_params[:difficulty],
							type: trial_params[:type],
							}

		# Array to hold questions from the API
		questions = []

		# One API call per category...
		questions_by_category.each do |category_id, n_questions|
			uri = URI("https://opentdb.com/api.php")
			request_params = 	{ 	
								amount: n_questions, 
								category: category_id,
								}

			uri.query = URI.encode_www_form(request_params)

			response = Net::HTTP.get_response(uri)

			parsed_response = JSON.parse(response.body)

			if parsed_response["response_code"] == 0 # successful GET
				questions << parsed_response["results"]
			end
		end

		questions.flatten!

		# To be filled with Question objects
		question_objects = []

		# If the question already exists in the db, fetch it. Otherwise, create it and keep reference
		questions.each do |question|

			same_question = Question.find_by(text: question["question"])

			if same_question.nil?
				new_question = 	Question.new(	text: question["question"],
												correct_answer: question["correct_answer"],
												incorrect_answers: question["incorrect_answers"],
											)
				new_question.save
			else
				new_question = same_question
			end

			question_objects << new_question
		end

		new_trial = helpers.current_user.trials.create()
		new_trial.questions << question_objects
		new_trial.save

		redirect_to trial_path(new_trial.id)
	end

	def show
		@trial = Trial.find_by_id(params[:id])
	end

	private
	def trial_params
		params.require(:trial).permit(:length, :type, :difficulty, category: {})
	end

end