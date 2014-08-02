class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.integer :transaction_id
      t.integer :schedule_id
      t.float :percent
      t.date :accounted_at
      t.string :tax_type

      t.timestamps
    end
  end
end
