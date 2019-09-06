class CustomersController < ApplicationController
  include Response
  include ExceptionHandler
  include Exceptions

  def index
    @customers = Customer.all
    json_response(@customers)
  end
end
