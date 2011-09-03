class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.string :account_owner
      t.text :address
      t.string :email
      t.string :pay_type
      t.string :delivery_type
      t.integer :arrival_payment
      t.integer :total_price
      t.integer :deposit_check

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
