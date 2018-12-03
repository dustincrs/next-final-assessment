namespace :badges do
  desc "For badge stuff"
  task populate: :environment do

	# Helper function
	def create_badge(rules, icon_code, icon_color, name, description)
		puts "==========================="
		puts "Making badge #{name}. With rule #{rules}"
		new_badge = Badge.new(	name: name, 
								description: description, 
								rules: rules, 
								icon: icon_code,
								icon_color: icon_color,
							)

		if(new_badge.save)
			puts "Successfully saved badge!"
		else
			puts "Failed to save badge. #{new_badge.errors.full_messages.join(", ")}"
		end
	end

  	# CONSTANTS
	BADGE_TIERS = 	[
						"#cd7f32",
						"#B6B6B6",
						"#FFD700",
						"#4781ff",
					]

  	# First, clear all badges to prevent dupes
  	puts "Destroying all badges..."
  	Badge.destroy_all

	puts "Recreating badges from Rake task..."

	# Make badges for score achieved...
	thresholds = [25, 50, 100, 150]
	keywords = ["Poop Deck Swabber", "Scurvy Scallywag", "First Mate", "Pirate Capitan"]
	thresholds.zip(BADGE_TIERS, keywords).each do |threshold|
		create_badge(	
						"score >= #{threshold[0]}",
						"fas fa-skull-crossbones",
						"#{threshold[1]}",
						"#{threshold[2]}",
						"This pirate has a score of #{threshold[0]}!",
					)
	end

  end

end
