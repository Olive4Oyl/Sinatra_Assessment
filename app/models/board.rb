class Board < ActiveRecord::Base
	belongs_to :user
	has_many :board_images
	has_many :images, through: :board_images
end