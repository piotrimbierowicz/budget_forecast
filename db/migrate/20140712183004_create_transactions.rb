class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.integer :account_id

      t.timestamps
    end
    add_money :transactions, :income
    add_money :transactions, :outcome
  end
end
