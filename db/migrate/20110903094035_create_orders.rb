class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :receiver
      t.string :phone
      t.string :tel
      t.string :email
      t.string :zipcode
      t.string :address
      t.string :arrival_message
      t.string :account_owner
      t.string :pay_type
      t.string :arrival_payment
      t.integer :total_price
      t.string :deposit_check
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
