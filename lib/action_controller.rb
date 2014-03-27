module ActionController
  class Base
    attr_accessor :request, :response

    def process(action_name)
      # action_name == 'index'
      send action_name
    end
  end
end