class ChangeTransactionColumns < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :slot_id, :string
    change_column :transactions, :parking_fee, :integer
  end
end
