require 'rails_helper'

RSpec.describe Badge, type: :model do
	before(:each) do
  		@new_badge = Badge.new(	
  								rules: "score < 50",
  								name: "Test Badge",
  								description: "Test Badge Description",
  								icon: "fas fa-skull-crossbones",
  								icon_color: "#FFF",
  							)
	end

	it "allows valid attributes" do
		@new_badge.save
		expect(Badge.last).to eq(@new_badge)
	end

	it "should not allow the word 'destroy' in its rules" do
		@new_badge.rules = "User.destroy_all"
		expect(@new_badge.save).to eq(false)
	end
end
