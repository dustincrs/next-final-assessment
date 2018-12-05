require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = User.create(	first_name: "Test", 
								last_name:"User", 
								email: "test@email.com",
								password: "1234567890",
							)

		@new_user = User.new(	first_name: "Test",
								last_name: "User",
								email: "test2@email.com",
								password: "1234567890",
							)
	end


	context "Validations" do
		it "is valid when saved with valid attributes" do
			old_user_count = User.all.size
			@new_user.save

			expect(User.all.size - 1).to eq(old_user_count)
		end

		it "is not valid when first_name is absent" do
			@new_user.first_name = ""
			expect(@new_user.save).to eq(false)
		end

		it "is not valid when last_name is absent" do
			@new_user.last_name = ""
			expect(@new_user.save).to eq(false)
		end

		it "is not valid when email is absent" do
			@new_user.email = ""
			expect(@new_user.save).to eq(false)
		end

		it "is not valid when a duplicate email is present" do
			@new_user.email = "test@email.com"
			expect(@new_user.save).to eq(false)
		end

		it "is not valid when an invalid email is given" do
			@new_user.email = "invalidemail"
			expect(@new_user.save).to eq(false)
		end
	end

	context "#full_name" do
		it "returns the result of concatenating first_name and last_name (with a space)" do
			expect(@user.full_name).to eq("Test User")
		end
	end
end