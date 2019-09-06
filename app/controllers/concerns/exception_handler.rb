include Exceptions

module ExceptionHandler
    # provides the more graceful `included` method
    extend ActiveSupport::Concern
  
    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ message: e.message }, :not_found)
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({ message: e.message }, :unprocessable_entity)
      end

      rescue_from Exceptions::InvalidRequest do |e|
        json_response({ message: e.message }, 400)
      end
    end
  end