class User < ApplicationRecord
	has_secure_password
	include PgSearch

	# ASSOCIATIONS
	has_many :authentications, dependent: :destroy
	has_many :trials
	has_many :awards
	has_many :badges, through: :awards

	# VALIDATIONS
	validates :first_name, :last_name, :email, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :email, uniqueness: true

	# SEARCH SCOPES
	pg_search_scope :search_by_name,
					against: [:first_name, :last_name],
					using: { tsearch: { prefix: true } }

	# FUNCTIONS
	def full_name
		return [first_name, last_name].join(" ")
	end

	def update_badges()
		Badge.all.each do |badge|
			if(awards.where(user_id: id, badge_id: badge.id).size == 0)
				if(eval(badge.rules))
					badges << badge
				end
			end
		end
	end

	# OmniAuth2
	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = self.create!(
		 first_name: auth_hash["info"]["first_name"],
		 last_name: auth_hash["info"]["last_name"],
		 email: auth_hash["info"]["email"],
		 password: SecureRandom.hex(10)
		)
		user.authentications << authentication
		return user
	end

end