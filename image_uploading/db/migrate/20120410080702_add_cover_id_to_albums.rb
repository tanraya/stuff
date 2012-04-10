class AddCoverIdToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :cover_id, :integer, :default => nil
    add_index  :albums, :cover_id
  end
end
