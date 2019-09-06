class OrdersController < ApplicationController
  include Response
  include ExceptionHandler
  include Exceptions

  before_action :set_order, only: %i[show update destroy]

  def index
    @orders = Order.all
    json_response(@orders)
  end

  def create
    data = order_params

    # validate customer is valid. This allows the user specify the customer id but in production should be determined based on the user's token
    unless Customer.exists?(data[:customer_id])
      raise ActiveRecord::RecordNotFound, 'Customer does not exist.'
    end

    # ensure that order_variant is provided
    if !params.key?(:order_variant) || params[:order_variant].empty?
      raise Exceptions::InvalidRequest, 'order_variant not provided'
    end

    @variants = populate_variants(params[:order_variant])

    @order = Order.new(data)
    @order.subtotal = calculate_subtotal # in cents
    @order.sales_tax_rate = '0.0825'.to_f # hard coding but would need to look up based on location
    @order.sales_tax = @order.subtotal.to_f * @order.sales_tax_rate.to_f # in cents
    @order.order_variant = @variants

    raise ActiveRecord::RecordInvalid unless @order.valid?

    @order.save!
    json_response(@order, :created)
  end

  def show
    json_response(Order.find(params[:id]))
  end

  def update
    @order.update!(order_params_update)
    head :no_content
  end

  private

  def order_params
    params.require(:order).permit([
                                    :customer_id,
                                    { order_variant: %i[variant_id quantity] }
                                  ])
  end

  def order_params_update
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.includes(:order_variant).find(params[:id])
    raise ActiveRecord::RecordNotFound unless @order
  end

  def calculate_subtotal
    subtotal = 0
    @variants.each do |v|
      subtotal += v.item_cost.to_f * v.quantity.to_f
    end
    subtotal
  end

  def populate_variants(variants)
    order_variants = []
    variants.each do |v|
      variant = Variant.find(v[:variant_id]) # will raise RecordNotFound (404) if unable to find
      raise ActiveRecord::RecordInvalid if variant.stock_amount < v[:quantity] # check stock per requirements

      o_variant = OrderVariant.new
      o_variant.variant_id = variant.id
      o_variant.item_cost = variant.cost
      o_variant.quantity = v[:quantity]
      order_variants.push(o_variant)
    end
    order_variants
  end
end
