namespace :questions do
  desc "Handles questions"
  task unescape: :environment do
  	# Should not need to be run any more. This was a task made to unescape HTML in the existing questions.
  	Question.all.each do |q|
  		q.text = HTMLEntities.new.decode(q.text)
  		q.correct_answer = HTMLEntities.new.decode(q.correct_answer)
  		q.incorrect_answers = q.incorrect_answers.map { |a| HTMLEntities.new.decode(a) }
  		q.save
  	end
  end

end
