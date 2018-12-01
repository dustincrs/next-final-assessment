class GameController < ApplicationController
	def new
	end

	def show
		
	end

	def create
		render "show"
	end

	private
  	def game_params
  		params.require(:game).permit(:length, :type, :difficulty, category: {})
	end
end
