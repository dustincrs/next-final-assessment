class Trial < ApplicationRecord

	# CONSTANTS
	CATEGORIES = 	{
					"9" => ["General Knowledge", 		'<i class="fas fa-brain"></i>'],
					"10" => ["Books", 					'<i class="fas fa-book"></i>'],
					"11" => ["Film", 					'<i class="fas fa-film"></i>'],
					"12" => ["Music", 					'<i class="fas fa-music"></i>'],
					"13" => ["Musicals & Theatres", 	'<i class="fas fa-theater-masks"></i>'],
					"14" => ["Television", 				'<i class="fas fa-tv"></i>'],
					"15" => ["Video Games", 			'<i class="fas fa-gamepad"></i>'],
					"16" => ["Board Games", 			'<i class="fas fa-chess-pawn"></i>'],
					"31" => ["Japanese Anime & Manga", 	'<i class="fas fa-user-ninja"></i>'],
					"32" => ["Cartoon & Animations", 	'<i class="fas fa-running"></i>'],
					"29" => ["Comics", 					'<i class="fas fa-comment"></i>'],
					"19" => ["Mathematics",			 	'<i class="fas fa-chart-area"></i>'],
					"20" => ["Mythology", 				'<i class="fas fa-dragon"></i>'],
					"21" => ["Sports", 					'<i class="fas fa-futbol"></i>'],
					"22" => ["Geography", 				'<i class="fas fa-globe"></i>'],
					"23" => ["History", 				'<i class="fas fa-landmark"></i>'],
					"24" => ["Politics", 				'<i class="fas fa-vote-yea"></i>'],
					"25" => ["Art", 					'<i class="fas fa-palette"></i>'],
					"26" => ["Celebrities", 			'<i class="fas fa-trophy"></i>'],
					"27" => ["Animals", 				'<i class="fas fa-paw"></i>'],
					"28" => ["Vehicles", 				'<i class="fas fa-car"></i>'],
					"17" => ["Science & Nature", 		'<i class="fas fa-atom"></i>'],
					"18" => ["Computers", 				'<i class="fas fa-laptop"></i>'],
					"30" => ["Gadgets", 				'<i class="fas fa-mobile-alt"></i>'],
					}

	# ASSOCIATIONS
	belongs_to :user
	belongs_to :question
	
end
