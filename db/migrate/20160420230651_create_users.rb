class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :username

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
