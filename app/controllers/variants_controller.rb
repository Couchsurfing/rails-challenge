class VariantsController < ApplicationController
  include Response
  include ExceptionHandler
  include Exceptions
  def index
    @variants = if params.key?(:product_id)
                  Variant.where(product_id: params[:product_id])
                else
                  Variant.all
                end
    json_response(@variants)
    end

  def show
    @variants = if params.key?(:id)
                  Variant.includes(:product).find(params[:id])
                else
                  Variant.includes(:product).all
                end
    json_response(@variants)
  end
end
