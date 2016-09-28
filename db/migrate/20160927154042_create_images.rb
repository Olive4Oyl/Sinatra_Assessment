class CreateImages < ActiveRecord::Migration
  
  def change
  	create_table :images do |t|
  		t.string :name
  		t.string :description
  		t.integer :user_id
  	end
  end

end
