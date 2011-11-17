class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :tel
      t.string :zip1
      t.string :zip2
      t.string :address1
      t.string :address2

      t.timestamps
    end
  end

  def self.down
    drop_table :infos
  end
end
