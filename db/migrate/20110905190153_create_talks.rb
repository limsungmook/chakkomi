class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.integer :user_id
      t.text :content, :null => false
      t.integer :secret, :default => 0

      t.timestamps
    end
    add_index :talks, :user_id
  end

  def self.down
    drop_table :talks
  end
end
