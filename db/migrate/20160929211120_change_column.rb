class ChangeColumn < ActiveRecord::Migration
  def change
  	rename_column :images, :name, :image_name
  end
end
