require 'net/http'

class TrialsController < ApplicationController
	before_action :set_trial, only: [:show, :fetch_questions, :check_answer]
	before_action :require_login

	def new
	end

	def create
		# First, construct what should be sent to the API to minimize number of calls
		# 1 call per question required = BAD
		# Since API can only do one category at a time, split calls by category

		# Gets the category IDs that the user wants questions from. If 0, choose 5 random categories
		chosen_categories = trial_params[:category].select	{|k,v| v=="1"}.keys

		if chosen_categories.size == 0
			chosen_categories = trial_params[:category].keys.sample(2)
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
		request_params = {}

		# Array to hold questions from the API
		questions = []

		failed = false
		# One API call per category...
		questions_by_category.each do |category_id, n_questions|
			uri = URI("https://opentdb.com/api.php")
			request_params[:amount] = n_questions
			request_params[:category] = category_id

			uri.query = URI.encode_www_form(request_params)

			response = Net::HTTP.get_response(uri)

			parsed_response = JSON.parse(response.body)

			if parsed_response["response_code"] == 0 # successful GET
				questions << parsed_response["results"]
			end

			if parsed_response["response_code"] == 1 # not enough questions!
				failed =true
				break
			end
		end

		if failed
			flash[:notice] = "API doesn't have enough questions for those setting combinations, try something else!"
			redirect_to root_path and return
		end

		questions.flatten!

		# To be filled with Question objects
		question_objects = []

		# If the question already exists in the db, fetch it. Otherwise, create it and keep reference
		questions.each do |question|
			new_question = Question.create_from_api_response(question)
			
			question_objects << new_question
		end

		new_trial = helpers.current_user.trials.create()
		new_trial.questions << question_objects

		if(new_trial.save)
			redirect_to trial_path(new_trial.id) and return
		else
			flash[:notice] = "An error occurred, please try again."
		end
	end

	def show
		if @trial.user.id != helpers.current_user.id
			flash[:notice] = "You do not own this trial! Please create your own game."
			redirect_to root_path
		end

		if @trial.has_been_accessed
			flash[:notice] = "You have already accessed this trial, it is now closed. Please create a new game."
			redirect_to root_path
		end

		@trial.has_been_accessed = true
		@trial.save
	end

	def check_answer
		question = Question.find_by_id(check_answer_params[:question_id])
		challenge = Challenge.find_by(question_id: question.id, trial_id: @trial.id)

		if question.correct_answer == check_answer_params[:selected_answer]
			challenge.is_correct = true
		else
			challenge.is_correct = false
		end

		challenge.is_answered = true
		challenge.save

		respond_to do |format|
			format.json 	{render json: challenge}
		end
	end

	def fetch_questions
		respond_to do |format|
			format.js 	{render json: @trial.questions}
		end

	end

	private
	def set_trial
		@trial = Trial.find_by_id(params[:id])
	end

	def trial_params
		params.require(:trial).permit(:length, category: {})
	end

	def check_answer_params
		params.permit(:id, :question_id, :selected_answer)
	end

end