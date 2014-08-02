class AddUserIdToTaxTypes < ActiveRecord::Migration
  def change
    add_column :tax_types, :user_id, :integer
  end
end
