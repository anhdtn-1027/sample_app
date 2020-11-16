class AddRememberTokenToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :remember_token, :string
  end

  def down
    remove_column :users, :remember_token, :string
  end
end
