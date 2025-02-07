class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
      # t.token_authenticatable

      t.string :name
      t.text :shortbio
      t.string :weburl
      t.boolean :haslocalpw, :null => false, :default => true
      t.string :role
#      t.string :delivery_address1
#      t.string :delivery_address2
#      t.string :phone

      t.timestamps
    end


#    add_index :users, :name
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
