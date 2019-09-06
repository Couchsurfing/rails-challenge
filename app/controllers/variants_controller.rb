class VariantsController < ApplicationController
    include Response
  include ExceptionHandler
  include Exceptions
    def index
      if params.key?(:product_id)
        @variants = Variant.where({product_id: params[:product_id]})
      else
        @variants = Variant.all
      end
        json_response(@variants);
      end

      def show
        if params.key?(:id)
          @variants = Variant.includes(:product).find(params[:id])
        else
          @variants = Variant.includes(:product).all
        end
        json_response(@variants)
      end
end
