class Initial < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string      :name
      t.string      :email
    end

    create_table :collections do |t|
      t.string      :name
      t.string      :type
    end

    create_table :products do |t|
      t.string      :name
    end

    create_table :variants do |t|
      t.string      :name
      t.integer     :cost
      t.integer     :stock_amount
      t.float       :weight
      t.belongs_to  :product, index: true
    end

    create_table :collections_products, id: false do |t|
      t.belongs_to  :product, index: true
      t.belongs_to  :collection, index: true
    end
  end
end
