class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.money :income
      t.money :outcome
      t.string :name
      t.date :starting_at
      t.string :frequency
      t.integer :account_id

      t.timestamps
    end
  end
end
