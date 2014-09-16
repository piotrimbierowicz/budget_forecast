class AddAccountIdToLimits < ActiveRecord::Migration
  def change
    add_column :limits, :account_id, :integer
  end
end
