class AddUserToToDo < ActiveRecord::Migration
  def change
    add_column :to_dos, :user_id, :integer
    add_index :to_dos, :user_id
  end
end
