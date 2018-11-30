class User < ApplicationRecord
	has_secure_password

	# Validations
	validates :first_name, :last_name, :email, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

end