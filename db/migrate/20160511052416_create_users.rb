class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_user_id
      t.string :protected_auth_token

      t.timestamps null: false
    end

    add_index :users, :github_user_id, :unique => true
  end
end
