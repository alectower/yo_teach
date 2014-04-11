class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :stripe_customer_id
      t.references :owner, index: true
    end
  end
end
