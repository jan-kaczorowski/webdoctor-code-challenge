class AddColumnsToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :state, :string, null: false, default: 'pending'
    add_column :payments, :amount, :decimal, precision: 10, scale: 6, null: false
  end
end
