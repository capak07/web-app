class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :balance
      t.string :email

      t.timestamps
    end
  end
end
