class UpdateAccountsUserReference < ActiveRecord::Migration
  def change
    rename_column :accounts, :owner_id, :user_id
  end
end
