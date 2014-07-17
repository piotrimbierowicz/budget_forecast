class ChangeAccountedAtToDate < ActiveRecord::Migration
  def change
    add_column :transactions, :accounted_at_date, :date
    Transaction.all.each do |t|
      t.accounted_at_date = t.accounted_at
      t.save!
    end
    change_column :transactions, :accounted_at, :date
    Transaction.all.each do |t|
      t.accounted_at = t.accounted_at_date
      t.save!
    end
    remove_column :transactions, :accounted_at_date
  end
end
