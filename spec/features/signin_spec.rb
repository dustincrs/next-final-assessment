require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Signins", type: :feature do
	before(:each) do
		@new_user = User.new(	first_name: "Test", 
								last_name: "User",
								email: "test@email.com",
								password: "1234567890",
								)

		@new_user.save
	end

	it "should sign in an existing user, and welcome them by name" do
		visit '/'

		within("#signinModal") do
			fill_in "Email Address", with: @new_user.email
			fill_in "Password", with: @new_user.password
			click_button "Login!"
		end

		expect(page).to have_content "Welcome, Test User!"
	end

	it "should NOT sign in a non-existent user" do
		visit '/'

		within("#signinModal") do
			fill_in "Email Address", with: "wrong_email@email.com"
			fill_in "Password", with: @new_user.password
			click_button "Login!"
		end

		expect(page).to have_content "The user was not found in the records."
	end

	it "should NOT sign in a user when the password given is incorrect" do
		visit '/'

		within("#signinModal") do
			fill_in "Email Address", with: @new_user.email
			fill_in "Password", with: "1234567899"
			click_button "Login!"
		end
		
		expect(page).to have_content "Incorrect password!"
	end
end
