# require_relative '../../uploader/images_uploader'

class Image < ActiveRecord::Base
	# mount_uploader :image, ImageUploader
	belongs_to :user
	has_many :board_images
	has_many :boards, through: :board_images

# def store_dir
#    "#{Dir.pwd}/public/uploads/#{self.class.to_s.underscore}/#{self.image.mounted_as}/#{self.id}"
#  end
end