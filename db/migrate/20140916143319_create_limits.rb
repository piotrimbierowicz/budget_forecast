class CreateLimits < ActiveRecord::Migration
  def change
    create_table :limits do |t|
      t.string :period
      t.money :value
      t.string :name

      t.timestamps
    end
  end
end
