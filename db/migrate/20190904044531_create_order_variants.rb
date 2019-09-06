class CreateOrderVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :order_variants, id: false do |t|
      t.references :order
      t.references :variant
      t.integer :quantity
      t.integer :item_cost
    end
  end
end
