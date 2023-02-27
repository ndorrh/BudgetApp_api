class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :Password_digest, null: false, default: ''

      t.timestamps
    end
  end
  add_index :users, :email, unique: true
  add_index :users, :user_name, unique: true
end
