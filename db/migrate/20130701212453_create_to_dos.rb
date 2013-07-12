class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :body
      t.boolean :complete

      t.timestamps
    end
  end
end
