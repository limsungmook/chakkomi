class CreateRelays < ActiveRecord::Migration
  def self.up
    create_table :relays do |t|
      t.integer :user_id
      t.integer :talk_id
      t.text :content, :null => false

      t.timestamps
    end
    add_index :relays, [:talk_id, :user_id]
  end

  def self.down
    drop_table :relays
  end
end
