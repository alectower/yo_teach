class CreateCoreStandards < ActiveRecord::Migration
  def change
    create_table :core_standards do |t|
      t.string :standard_type, null: false
      t.string :dot_notation, null: false
      t.string :uri, null: false
      t.string :guid, null: false
      t.string :description, null: false
    end
  end
end
