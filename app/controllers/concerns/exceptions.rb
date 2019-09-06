module Exceptions
  class InvalidRequest < StandardError
    def initialize(msg="Invalid Request")
      super
    end
  end
end
