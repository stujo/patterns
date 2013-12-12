require "filters"

module ActionController
  class Metal
    attr_accessor :request, :response

    def process(name)
      # name == "index"
      send name
    end
  end

  class Base < Metal
    include Filters
  end
end