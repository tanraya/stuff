class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :imageable_type, :null => false
      t.integer :imageable_id, :null => false
      t.string :description
      t.string :image_uid, :null => false

      t.timestamps
    end
  end
end
