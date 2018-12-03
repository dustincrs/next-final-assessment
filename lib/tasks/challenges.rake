namespace :challenges do
  desc "Handles challenges"
  task cleanup: :environment do

  	unfinished = Challenge.where(is_answered: true).destroy_all

  	puts "Found #{unfinished.size} unfinished challenges! Destroying (if any)."

  end

end
