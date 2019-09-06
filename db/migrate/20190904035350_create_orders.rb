class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, force: :cascade do |t|
      t.references :customer
      t.string :status, default: :pending
      t.integer :subtotal, null: false # in cents
      t.column :sales_tax_rate, :float, :null => false
      t.column :sales_tax, :float, :null => false
      t.timestamps :null => false
    end
  end
end
