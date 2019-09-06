# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer = Customer.create!(name: 'Geoff Lancaster', email: 'hire@geofflancaster.com')
Customer.create!(name: 'John Smith', email: 'john.smith@gmail.com')

product = Product.create!(name: 'Bean Bag Couch')
couch = Variant.create!(name: 'Gray', cost: '39999', stock_amount: 10, weight: 38.283, product_id: product.id)
couch2 = Variant.create!(name: 'Red', cost: '39999', stock_amount: 10, weight: 38.283, product_id: product.id)

order = Order.new(customer_id: customer.id, subtotal: 39_999, sales_tax_rate: 0.0825, sales_tax: 3299.9175)
order.order_variant.new(order_id: order.id, variant_id: couch.id, quantity: 1, item_cost: 39_999)
order.order_variant.new(order_id: order.id, variant_id: couch2.id, quantity: 1, item_cost: 39_999)
