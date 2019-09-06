require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
    before() do
        @product = Product.create(name: 'Test product')
    end
    
  describe "POST orders#create" do
    it "with valid params" do
      @customer = Customer.create(email: 'hire@geofflancaster.com')
      @variant = Variant.create(product: @product, cost: 100, stock_amount: 5, weight: 10.2)
      post :create, params: { "customer_id": @customer.id, "order_variant": [ { "variant_id": @variant.id, "quantity": 1 } ] }, as: :json
      expect(response.status).to eq(201)
      order = JSON.parse(response.body)
      Order.destroy(order['id'])
    end
    it "with valid params and multiple variants" do
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        @variant = Variant.create(product: @product, cost: 100, stock_amount: 5, weight: 10.2)
        @variant2 = Variant.create(product: @product, cost: 150, stock_amount: 1, weight: 23)
        post :create, params: { "customer_id": @customer.id, "order_variant": [ { "variant_id": @variant.id, "quantity": 1 }, { "variant_id": @variant2.id, "quantity": 1 } ] }, as: :json
        expect(response.status).to eq(201)
        order = JSON.parse(response.body)
        expect(order['order_variant'].size).to eq(2)
        Order.destroy(order['id'])
      end
    it "with invalid quantity" do
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        @variant = Variant.create(product: @product, cost: 100, stock_amount: 1, weight: 10.2)
        post :create, params: { "customer_id": @customer.id, "order_variant": [ { "variant_id": @variant.id, "quantity": 2 } ] }, as: :json
        expect(response.status).to eq(422)
    end
    it "invalid customer" do
        @variant = Variant.create(product: @product, cost: 100, stock_amount: 1, weight: 10.2)
        post :create, params: { "customer_id": 100, "order_variant": [ { "variant_id": @variant.id, "quantity": 1 } ] }, as: :json
        expect(response.status).to eq(404)
    end
    it "invalid variant" do
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        post :create, params: { "customer_id": @customer.id, "order_variant": [ { "variant_id": 300, "quantity": 1 } ] }, as: :json
        expect(response.status).to eq(404)
    end
    it "empty variants specified" do
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        post :create, params: { "customer_id": @customer.id, "order_variant": [] }, as: :json
        expect(response.status).to eq(400)
    end
    it "no variants specified" do
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        post :create, params: { "customer_id": @customer.id }, as: :json
        expect(response.status).to eq(400)
    end
  end
  
  describe "GET index" do
    it "returns a successful response" do
      get :index, as: :json
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).count).to eq(0)
      expect(response.content_type).to eq('application/json')
    end
    it "should have new order item" do        
        @customer = Customer.create(email: 'hire@geofflancaster.com')
        @product = Product.create(name: 'Test product')
      @variant = Variant.create(product: @product, cost: 100, stock_amount: 5, weight: 10.2)
      @order = Order.new(customer: @customer, subtotal: 100, sales_tax_rate: 0.0825, sales_tax: 0.08)
      order_variant = OrderVariant.new(quantity: 1, variant: @variant, item_cost: 100)
      variants = Array.new
      variants.push(order_variant)
      @order.order_variant = variants
      @order.save!
        get :index, as: :json
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(1)
        expect(response.content_type).to eq('application/json')
      end

  end
end
