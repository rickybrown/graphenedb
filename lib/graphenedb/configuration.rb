module Graphenedb
  class Configuration
    attr_accessor :api_key, :version, :region, :plan

    def initialize
      @api_key = nil
      @version = 'v314'
      @region  = 'us-east-1'
      @plan    = 'sandbox'
    end
  end
end
