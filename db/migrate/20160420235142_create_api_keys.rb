class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :user, index: true, foreign_key: true
      t.text :key, null: false
      t.boolean :revoked
      t.datetime :expiration

      t.timestamps null: false
    end
    add_index :api_keys, :key, unique: true
  end
end
