class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string  :attachable_type, :default => nil
      t.integer :attachable_id,   :default => 0
      t.string  :attach_uid,      :null => false
      t.timestamps
    end

    add_index :attachments, [:attachable_type, :attachable_id]
    add_index :attachments, :attach_uid
  end
end
