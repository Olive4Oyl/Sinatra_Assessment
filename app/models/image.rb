class Image < ActiveRecord::Base

	belongs_to :user
	has_many :board_images
	has_many :boards, through: :board_images

end