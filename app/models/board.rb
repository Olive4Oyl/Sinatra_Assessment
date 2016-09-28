class Board < ActiveRecord::Base
	belongs_to :user
	has_many :board_images
	has_many :images, through: :board_images

	def slug
		self.downcase.split(" ").join("-") 
	end 

	def self.find_by_slug(slug)
		Board.all.find do |name|
			name.slug == slug
		end
	end

end