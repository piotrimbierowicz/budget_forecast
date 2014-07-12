class AddAccountedAtToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :accounted_at, :datetime
  end
end
