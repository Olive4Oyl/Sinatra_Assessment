require 'pry'

class User < ActiveRecord::Base
	has_secure_password
	has_many :boards
	has_many :images

	def slug
		self.username.downcase.split(" ").join("-")
	end

	def self.find_by_slug(slug)
		User.all.find do |username|
			username.slug == slug 
		end
	end

end