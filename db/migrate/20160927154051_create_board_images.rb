class CreateBoardImages < ActiveRecord::Migration

  def change
  	create_table :board_images do |t|
  		t.integer :board_id
  		t.integer :image_id
  	end
  end

end
