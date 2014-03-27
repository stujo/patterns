require "filters"
require "rendering"

module ActionController
  class Metal
    attr_accessor :request, :response

    def process(action_name)
      # action_name == 'index'
      send action_name
    end
  end

  class Base < Metal
    include Filters
    include Rendering
  end
end