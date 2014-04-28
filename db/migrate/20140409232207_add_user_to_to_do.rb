class AddUserToToDo < ActiveRecord::Migration
  def change
    add_column :to_dos, :user_id, :integer
    change_column :to_dos, :user_id, :integer,
      null: false
    add_index :to_dos, :user_id
  end
end
