class BoardImage < ActiveRecord::Base
	belongs_to :board
	belongs_to :image
end